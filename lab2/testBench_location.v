`include "bathysphereLocation.v"
/*
	File Name: testBench_behave.v
	Description: TestBench Module for the Johnson down counter. 
	Authors: Varun Venkatesh, Akhil Avula, Max Thompson	

*/
module testBench_location; 

	wire clk, reset, outerGate, innerGate, chamberFull; //input
	wire [1:0] bathysphereSignal; //input
	wire bathInChamber; // output
	
	bathysphereLocation counter (bathInChamber, clk, reset, outerGate, innerGate, chamberFull, bathysphereSignal[1:0]);
	
	Tester tester (bathInChamber, clk, reset, outerGate, innerGate, chamberFull, bathysphereSignal[1:0]);
	
	// file for gtkwave
	initial
		begin
		// these two files support gtkwave and are required
		$dumpfile("bathysphereLocation.vcd");
		$dumpvars(1, counter);
		end

endmodule 


module Tester (bathInChamber, clk, rst, outerGate, innerGate, chamberFull, bathysphereSignal);
	/*output clk, rst;
	reg clk, rst;
	input [3:0] q;*/
	
	
	output reg clk, rst, outerGate, innerGate, chamberFull; //input
	output reg [1:0] bathysphereSignal; //input
	input bathInChamber; // output
	
	parameter stimDelay = 1;
	parameter stateDelay = 3;
	
	initial
	begin
		$display("\t\t clk \t rst \t\t bathInChamber \t outerGate innerGate chamberFull bathysphereSignal[1] bathysphereSignal[0] \t Time ");
		$monitor("\t\t %b \t %b \t\t %b \t %b %b %b %b %b",
				clk, rst, bathInChamber, outerGate, innerGate, chamberFull, bathysphereSignal[1], bathysphereSignal[0], $time);
	end

	initial begin
		clk <= 0;
		#stimDelay
		rst <= 1;
		repeat(100)
		begin
			#stimDelay clk <= ~clk;
		end
	end
	
	initial begin
		outerGate <= 1'b0; // Bathysphere is neither arriving nor departing, gates are closed
		innerGate <= 1'b0;
		chamberFull <= 1'b0;
		bathysphereSignal <= 2'b00;
		rst <= 1'b1;
		@(posedge clk);
		rst <= 1'b0;
		repeat (stateDelay) @(posedge clk); 
		outerGate <= 1'b0; // Bathysphere is neither arriving nor departing, gates are closed
		innerGate <= 1'b0;
		chamberFull <= 1'b0;
		bathysphereSignal <= 2'b00;
		repeat (stateDelay) @(posedge clk); 		
		outerGate <= 1'b0; // Bathysphere is arriving and the outer gate is closed and chamber is not filled
		innerGate <= 1'b0;
		chamberFull <= 1'b0;
		bathysphereSignal <= 2'b01;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // Bathysphere is arriving and the outer gate is closed and chamber is filled
		innerGate <= 1'b0;
		chamberFull <= 1'b1;
		bathysphereSignal <= 2'b01;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b1; // Bathysphere is arriving and the outer gate is open and chamber is filled
		innerGate <= 1'b0;
		chamberFull <= 1'b1;
		bathysphereSignal <= 2'b01;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // Bathysphere is arriving and the outer gate is closed and chamber is filled
		innerGate <= 1'b0;
		chamberFull <= 1'b1;
		bathysphereSignal <= 2'b01;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // Bathysphere is arriving and the outer gate is closed and chamber is empty
		innerGate <= 1'b0;
		chamberFull <= 1'b0;
		bathysphereSignal <= 2'b01;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // Bathysphere is arriving and the inner gate is open and chamber is empty
		innerGate <= 1'b1;
		chamberFull <= 1'b0;
		bathysphereSignal <= 2'b01;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // Bathysphere is in the port and the inner gate is closed and chamber is empty
		innerGate <= 1'b0;
		chamberFull <= 1'b0;
		bathysphereSignal <= 2'b00;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // Bathysphere is departing and the inner gate is closed and chamber is empty
		innerGate <= 1'b0;
		chamberFull <= 1'b0;
		bathysphereSignal <= 2'b10;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // Bathysphere is departing and the inner gate is open and chamber is empty
		innerGate <= 1'b1;
		chamberFull <= 1'b0;
		bathysphereSignal <= 2'b10;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // Bathysphere is departing and the inner gate is closed and chamber is empty
		innerGate <= 1'b0;
		chamberFull <= 1'b0;
		bathysphereSignal <= 2'b10;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // Bathysphere is departing and the inner gate is closed and chamber is full
		innerGate <= 1'b0;
		chamberFull <= 1'b1;
		bathysphereSignal <= 2'b10;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b1; // Bathysphere is departing and the outer gate is open and chamber is full
		innerGate <= 1'b0;
		chamberFull <= 1'b1;
		bathysphereSignal <= 2'b10;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // Bathysphere has departed and the outer gate is closed and chamber is full
		innerGate <= 1'b0;
		chamberFull <= 1'b1;
		bathysphereSignal <= 2'b10;
		rst <= 1'b1;
		@(posedge clk);
		rst <= 1'b0;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // Bathysphere is arriving and the inner gate is open and chamber is full
		innerGate <= 1'b1;
		chamberFull <= 1'b1;
		bathysphereSignal <= 2'b01;
	end
	
	
endmodule
		