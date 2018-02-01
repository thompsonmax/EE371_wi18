/*
Four bit Ripple down counter module.
Description: This module creates a 4 bit ripple down counter based on the structural model.
	Counts down at a speed proportional to the input clock speed. 
	Uses low reset that resets the output to "0000"
Author: Akhil Avula, Max Thompson, Varun Venkatesh
Date: 1/8/18
*/

`include "DFlipFlop.v"

module RippleDownCounter(q, clk, rst);
	input clk, rst;
	output [3:0] q;
	wire [3:0] qnot;
	
	DFlipFlop D0 (q[0], qnot[0], qnot[0], clk, rst);
	DFlipFlop D1 (q[1], qnot[1], qnot[1], q[0], rst);
	DFlipFlop D2 (q[2], qnot[2], qnot[2], q[1], rst);
	DFlipFlop D3 (q[3], qnot[3], qnot[3], q[2], rst);
endmodule		