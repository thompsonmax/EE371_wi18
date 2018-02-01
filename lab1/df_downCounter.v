/*
Four bit synchronous down counter module
Description: This module creates a 4 bit down counter based on dataflow  model.
	Each bit's value changes on the its current value and the other bits' values. 
Author: Akhil Avula, Max Thompson, Varun Venkatesh
Date: 1/8/18
*/

//`include "DFlipFlop.v"

module df_downCounter(reset, clk, out);
	// Set inputs.
	input reset, clk;
	// Creates wires to drive the bits.
	wire [3:0] inNot, d;
	// Register used to divide the clock.
	reg [31:0] whichClock;
	// Set outputs.
	output [3:0] out;
	
	// Assign equations to each output bit. 
	// Equations derived from state diagram, truth table, and Karnaugh maps.
	assign d[3] = (out[3]~^(out[2]|out[1]|out[0]))&reset;
	assign d[2] = (out[2]~^(out[1]|out[0]))&reset;
	assign d[1] = (out[1]~^out[0])&reset;
	assign d[0] = ~out[0]&reset;
	
	// Slows down the clock by incrementing the counter and then choosing the bit
	// in the D Flip Flop.
	always @(posedge clk) begin
		whichClock <= whichClock + 1'b1;
	end
	
	// Changes the the output to be the input at each clock cycle. 
	DFlipFlop downCount3 (out[3], inNot[3], d[3], whichClock[25], reset);
	DFlipFlop downCount2 (out[2], inNot[2], d[2], whichClock[25], reset);
	DFlipFlop downCount1 (out[1], inNot[1], d[1], whichClock[25], reset);
	DFlipFlop downCount0 (out[0], inNot[0], d[0], whichClock[25], reset);

endmodule 
