/*
Top Level Module
Description: This module is used to test each of the down counters created.
Author: Akhil Avula, Max Thompson, Varun Venkatesh
Date: 1/18/18
*/

module counter_topLevel(reset, CLOCK_50, out);
	// Set inputs
	input reset, CLOCK_50;
	// Set 4 bit output
	output [3:0] out;
	
	// Register used to divide the clock.
	reg [31:0] clk;
	parameter whichClock = 25; // Sets the clock rate.
	
	// Slows down the clock by incrementing the counter and then choosing the bit
	// in the D Flip Flop.
	always @(posedge CLOCK_50) begin
		clk <= clk + 1'b1;
	end
	
	// Reset, divided clock, and output are passed through each counter to be tested.
	// Only one should be uncommented at a time while testing.
	
//	RippleDownCounter structural_model (out, clk[whichClock], reset);
	
//	df_downCounter dataflow_model (reset, clk[whichClock], out);
	
//	behaveCount behavioral_model (reset, clk[whichClock], out);

	SynchDownCounter schematic_model (reset, clk[whichClock], out[2], out[3], out[1], out[0]);
	
endmodule 