/*
Pressure Control Module
Description: This module controls the pressure of the interlock by either emptying it or filling it with water.
Author: Akhil Avula, Varun Venkatesh, Max Thompson
Date: 2/1/18
*/

module pressureControlForTesting (chamberFull, hexNum, clk, reset, 
		outerGate, innerGate, fillSignal, emptySignal);
	// Set output
	output chamberFull;// chamberFull: 0 - empty, 1 - full
	output [6:0] hexNum;
	// Set input
	input clk, reset, outerGate, innerGate, fillSignal, emptySignal;
	
	parameter CLOCK_DELAY = 0;
	parameter FILL_DELAY = 0;
	parameter EMPTY_DELAY = 0;
	// Variables used to change the state of the water in the interlock.
	reg ps, ns;
	reg [3:0] count, max;
	
	// Combinational logic to tell the chamber when it should be full or empty
	always@(*) begin
		case (ps)
			// Currently empty
			0: if (fillSignal & ~emptySignal & ~outerGate & ~innerGate) begin // and if pressure diff < 0.1 atm
					max = FILL_DELAY;
					ns = 1; // pressurize and fill
				end
				else begin
					max = 0;
					ns = ps;
				end
			// Currently full
			1: if (~fillSignal & emptySignal & ~outerGate & ~innerGate) begin // and if pressure diff < 0.1 atm
					max = EMPTY_DELAY;
					ns = 0; // empty
				end
				else begin
					max = 0;
					ns = ps;
				end
		endcase
	end
	
	// Sequential logic to change the state of the water.
	always@(posedge clk) begin
		if (reset) begin
			count <= 0;
			ps <= 0;
		end
		else begin
			if (count != max) begin
				#19 count <= count + 1'b1;
			end
			else begin 
				count <= max;
				ps <= ns;
			end 
		end
	end
	// Decodes the count to a 7 bit number
	numDisplay hexNumber (hexNum, count);
	// Assigns the output to be the current state.
	assign chamberFull = ps;
	
endmodule 
