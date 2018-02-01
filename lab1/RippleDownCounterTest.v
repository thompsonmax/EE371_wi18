/*
Test bench for Ripple Down Counter
Description: This module tests the down Ripple Down Counter built using the structural model
Authors: Akhil Avula, Max Thompson, Varun Venkatesh
Date: 1/16/18
*/

`include "RippleDownCounter.v"

module TestBench;
	wire clk, rst;
	wire [3:0] q;
	
	RippleDownCounter counter (q[3:0], clk, rst);
	
	Tester tester (clk, rst, q[3:0]);
	
	// file for gtkwave
	initial
		begin
		// these two files support gtkwave and are required
		$dumpfile("RippleDownCounter.vcd");
		$dumpvars(1, counter);
		end
endmodule

module Tester (clk, rst, q);
	output clk, rst;
	reg clk, rst;
	input [3:0] q;
	
	parameter stimDelay = 20;
	
	initial
	begin
		$display("\t\t clk \t rst \t q3 q2 q1 q0 \t Time ");
		$monitor("\t\t %b \t %b \t %b %b %b %b",
				clk, rst, q[3], q[2], q[1], q[0], $time);
	end
	/*
	parameter CLOCK_PERIOD = 100
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	*/
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
		
	