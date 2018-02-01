/*
Bathysphere Arrival and Departure Minutes Module
Description: This module shows the time of the arrival or departure signal before assigning the output to the input. 
Author: Akhil Avula, Varun Venkatesh, Max Thompson
Date: 2/1/18
*/

module bathCountDisplayForTesting (departing, arriving, seconds, clk, reset, bathysphereSignal);
	// Set outputs
	output departing, arriving;
	output [6:0] seconds;
	// Set inputs
	input clk, reset;
	input [1:0] bathysphereSignal;
	// Variables used for the sequential logic
	reg [1:0] ps, ns;
	reg [3:0] count, max;
	
	// Sets parameters for testing purposes
	parameter CLOCK_DELAY = 0;
	parameter ARRDEP_DELAY = 5;
	
	
	// Assigns the output to the input
	always@(*) begin
		ns = bathysphereSignal;
		max = ARRDEP_DELAY;
	end
	// Sequential logic needed to count to 5 before making the assignment
	always@(posedge clk) begin
	if (reset | bathysphereSignal == 0) begin
			count <= 0;
			ps <= 0;
		end
		else begin
			if (count != max) begin
				#CLOCK_DELAY count <= count + 1'b1;
			end
			else begin 
				count <= max;
				ps <= ns;
			end 
		end
	end
	// Display the seconds as hex figures
	numDisplay hexNumber (seconds, count);
	// assign the outputs to the present state
	assign departing = ps[1];
	assign arriving = ps[0];
endmodule 