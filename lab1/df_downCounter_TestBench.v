/*
Test bench for dataflow down counter
Description: This module tests the down counter based on the dataflow model
Authors: Akhil Avula, Max Thompson, Varun Venkatesh
*/

`include "df_downCounter.v"
`include "Tester.v"

module df_downCounter_TestBench;
	// Wire variables made to be passed through the counter
	wire clk, rst;
	wire [3:0] q;
	// Runs the variables through the design under test
	df_downCounter counter (rst, clk, q);
	// Tester module used to display the values of the bits
	Tester tester (clk, rst, q[3:0]);
	// file for gtkwave
	initial
		begin
		// these two files support gtkwave and are required
		$dumpfile("df_downCounter.vcd");
		$dumpvars(1, counter);
		end
endmodule

		
	