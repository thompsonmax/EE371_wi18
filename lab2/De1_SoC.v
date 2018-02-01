/*
Interlock System Top Level Module
Description: This module is the overall control of the interlock system. It controls when the gates are open and closed, and 
		when to empty and fill the interlock with water. It is also responsible for handling the signals and indicators
		of the bathysphere and the interlock gates. 
Author: Akhil Avula, Varun Venkatesh, Max Thompson
Date: 2/1/18
*/

module De1_SoC (HEX, HEX1, HEX2, HEX3, LEDR, SW, KEY, CLOCK_50);

	input CLOCK_50;
	input [3:0] SW;
	input [2:0] KEY;
	output [5:0] LEDR;
	output [6:0] HEX, HEX1, HEX2, HEX3;
	
	// Register used to divide the clock.
	reg [31:0] clk;
	parameter whichClock = 23; // Sets the clock rate.
	
	// Slows down the clock by incrementing the counter and then choosing the bit
	// in the D Flip Flop.
	always @(posedge CLOCK_50) begin
		clk <= clk + 1'b1;
	end
	
	// Delays for the bathysphere arrival/departure and for the chamber to fill/empty.
	parameter CLOCK_DELAY = 19, ARRDEP_DELAY = 4'b0101, FILL_DELAY = 4'b0111, EMPTY_DELAY = 4'b1000;
	
	
	wire chamberFull;
	// module that fills/empties the pressure of the interlock chamber
	pressureControl #(CLOCK_DELAY, FILL_DELAY,EMPTY_DELAY) pControl (.chamberFull(chamberFull),.hexNum(HEX2), .clk(clk[whichClock]), .reset(~KEY[0]),
					.outerGate(SW[3]), .innerGate(SW[2]), .fillSignal(~KEY[1]), .emptySignal(~KEY[2]));
					
	// module that displays whether the bathsyphere is arriving/departing and whether the interlock is
	// pressurizing or emptying
	hexDisplay minDisplay (.direction(HEX1), .pressureLevel(HEX3), .bathysphereSignal(SW[1:0]), .chamberFull(chamberFull));

	// module that calculates the location of the bathsyphere
	bathysphereLocation location (.bathInChamber(LEDR[5]), .clk(clk[whichClock]), .reset(~KEY[0]), .outerGate(LEDR[2]), 
					.innerGate(LEDR[3]), .chamberFull(chamberFull), .bathysphereSignal(LEDR[1:0]));

	bathCountDisplay #(CLOCK_DELAY, ARRDEP_DELAY) timeDisplay(.departing(LEDR[1]), .arriving(LEDR[0]), .seconds(HEX), 
						.clk(clk[whichClock]), .reset(~KEY[0]), .bathysphereSignal(SW[1:0]));
	assign LEDR[4] = chamberFull; // Water in the interlock
	assign LEDR[2] = SW[2] & ~SW[3] & chamberFull; // outer gate
	assign LEDR[3] = ~SW[2] & SW[3] & ~chamberFull; // inner gate

endmodule 