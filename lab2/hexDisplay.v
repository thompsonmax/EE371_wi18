/*
Hex Display Module
Description: This module determines what to display on the HEX output. It determines what to display for the direction
of the bathysphere based on the bathysphere signal and what to dsiplay for the pressure level on whether the chamber is full or not.
Author: Akhil Avula, Varun Venkatesh, Max Thompson
Date: 2/1/18
*/
module hexDisplay (direction, pressureLevel, bathysphereSignal, chamberFull);

	// Two Hex outputs that display the direction of the bathysphere and the pressure level
	output [6:0] direction, pressureLevel; // A: arriving, D: departing, F: Fill, E: Empty
	
	// Inputs 
	input [1:0] bathysphereSignal;
	input chamberFull;
	 
	reg [6:0] letter1, letter2;
	
	// Based on the bathysphere signal, display the direction of the bathysphere
	always@(*) begin
		case (bathysphereSignal)
			2'b10: letter1 = 7'b0100001; // d for departure		
			2'b01: letter1 = 7'b0001000; // A for arrival
			default: letter1 = 7'b1111111;
		endcase
	end
	
	// Based on the pressure level, displays whether the chamber is full or empty
	always@(*) begin
		case (chamberFull)
			1: letter2 = 7'b0001110; // F for full
			0: letter2 = 7'b0000110; // E for empty
			default: letter2 = 7'b1111111;
		endcase
	end
	
	assign direction = letter1;
	assign pressureLevel = letter2;

endmodule 