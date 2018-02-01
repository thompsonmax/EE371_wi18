/*
Counter Test module
Description: This module is used with any of the counters' test bench.
	Lets the bits run to see how the bits change.
Authors: Akhil Avula, Max Thompson, Varun Venkatesh
*/

module Tester (clk, rst, q);
	// Sets outputs
	output clk, rst;
	// Creates registers for the outputs
	reg clk, rst;
	// Sets input
	input [3:0] q;
	// Delay variable
	parameter stimDelay = 1;
	// Displays the values of the clock, reset and bits.
	initial
	begin
		$display("\t\t clk \t rst \t q3 q2 q1 q0 \t Time ");
		$monitor("\t\t %b \t %b \t %b %b %b %b",
				clk, rst, q[3], q[2], q[1], q[0], $time);
	end
	// Simulates the clock periods and sets the reset to high.
	initial begin
		clk <= 0;
		rst <= 0;
		#stimDelay
		rst <= 1;
		repeat(50) 
		begin
			#stimDelay clk <= ~clk;
		end
	end
	
endmodule 