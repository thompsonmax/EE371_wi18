`include "pressureControlForTesting.v"
`include "numDisplay.v"
/*
	File Name: testBench_behave.v
	Description: TestBench Module for the Johnson down counter. 
	Authors: Varun Venkatesh, Akhil Avula, Max Thompson	

*/
module testBench_Pressure; 

	
	wire chamberFull;// chamberFull: 0 - empty, 1 - full
	wire [6:0] hexNum;
	// Set input
	wire clk, reset, outerGate, innerGate, fillSignal, emptySignal;
	
	pressureControlForTesting counter (chamberFull, hexNum[6:0], clk, reset, outerGate, innerGate, fillSignal, emptySignal);
	
	Tester tester (chamberFull, hexNum[6:0], clk, reset, outerGate, innerGate, fillSignal, emptySignal);
	
	// file for gtkwave
	initial
		begin
		// these two files support gtkwave and are required
		$dumpfile("pressureControlForTesting.vcd");
		$dumpvars(1, counter);
		end

endmodule 


module Tester (chamberFull, hexNum, clk, rst, outerGate, innerGate, fillSignal, emptySignal);
	/*output clk, rst;
	reg clk, rst;
	input [3:0] q;*/
	
	input chamberFull;// chamberFull: 0 - empty, 1 - full
	input [6:0] hexNum;
	// Set input
	output reg  clk, rst, outerGate, innerGate, fillSignal, emptySignal;
	
	
	parameter stimDelay = 1;
	parameter stateDelay = 3;
	
	initial
	begin
		$display("\t\t clk \t rst \t\t outerGate innerGate fillSignal emptySignal \t chamberFull\t Time ");
		$monitor("\t\t %b \t %b \t\t %b %b %b %b \t %b",
				clk, rst, outerGate, innerGate, fillSignal, emptySignal, chamberFull, $time);
	end

	initial begin
		clk <= 0;
		#stimDelay
		rst <= 1;
		repeat(250)
		begin
			#stimDelay clk <= ~clk;
		end
	end
	
	initial begin
		outerGate <= 1'b0; // All gates are initially closed with no fill or empty signal
		innerGate <= 1'b0;
		fillSignal <= 1'b0;
		emptySignal <= 1'b0;
		rst <= 1'b1;
		@(posedge clk);
		rst <= 1'b0;
		repeat(stateDelay) @(posedge clk);  // neither fills nor empties with inner gate open
		outerGate <= 1'b0;
		innerGate <= 1'b1;
		fillSignal <= 1'b0;
		emptySignal <= 1'b0;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // neither fills nor empties with both gates closed
		innerGate <= 1'b0;
		fillSignal <= 1'b0;
		emptySignal <= 1'b0;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // All gates are closed with fill signal on
		innerGate <= 1'b0;
		fillSignal <= 1'b1;
		emptySignal <= 1'b0;
		repeat(stateDelay) @(posedge clk);
		outerGate <= 1'b0; // neither fills nor empties with both gates closed
		innerGate <= 1'b0;
		fillSignal <= 1'b0;
		emptySignal <= 1'b0;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b1; // neither fills nor empties with outer gate open
		innerGate <= 1'b0;
		fillSignal <= 1'b0;
		emptySignal <= 1'b0;
		repeat(stateDelay) @(posedge clk);
		outerGate <= 1'b0; // neither fills nor empties with both gates closed
		innerGate <= 1'b0;
		fillSignal <= 1'b0;
		emptySignal <= 1'b0;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // empties with both gates closed
		innerGate <= 1'b0;
		fillSignal <= 1'b0;
		emptySignal <= 1'b1;
		repeat(stateDelay) @(posedge clk);
		outerGate <= 1'b0; // neither fills nor empties with both gates closed
		innerGate <= 1'b0;
		fillSignal <= 1'b0;
		emptySignal <= 1'b0;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // neither fills nor empties with inner gate open
		innerGate <= 1'b1;
		fillSignal <= 1'b0;
		emptySignal <= 1'b0;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // neither fills nor empties with both gates closed
		innerGate <= 1'b0;
		fillSignal <= 1'b0;
		emptySignal <= 1'b0;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // Perform reset to ensure return to defined state
		innerGate <= 1'b0;
		fillSignal <= 1'b0;
		emptySignal <= 1'b0;
		rst <= 1'b1;
		@(posedge clk);
		rst <= 1'b0;
		repeat (stateDelay) @(posedge clk); // Test possible error cases
		outerGate <= 1'b0; // neither fills nor empties with both gates closed
		innerGate <= 1'b0;
		fillSignal <= 1'b0;
		emptySignal <= 1'b0;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // neither fills nor empties with inner gate open
		innerGate <= 1'b1;
		fillSignal <= 1'b0;
		emptySignal <= 1'b0;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // tries to fill with inner gate open
		innerGate <= 1'b1;
		fillSignal <= 1'b1;
		emptySignal <= 1'b0;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // neither fills nor empties with inner gate open
		innerGate <= 1'b1;
		fillSignal <= 1'b0;
		emptySignal <= 1'b0;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // neither fills nor empties with both gates closed
		innerGate <= 1'b0;
		fillSignal <= 1'b0;
		emptySignal <= 1'b0;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // Perform reset to ensure return to defined state
		innerGate <= 1'b0;
		fillSignal <= 1'b0;
		emptySignal <= 1'b0;
		rst <= 1'b1;
		@(posedge clk);
		rst <= 1'b0;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // neither fills nor empties with both gates closed
		innerGate <= 1'b0;
		fillSignal <= 1'b0;
		emptySignal <= 1'b0;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // fills w/ both gates closed
		innerGate <= 1'b0;
		fillSignal <= 1'b1;
		emptySignal <= 1'b0;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // neither fills nor empties with both gates closed
		innerGate <= 1'b0;
		fillSignal <= 1'b0;
		emptySignal <= 1'b0;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b1; // neither fills nor empties with outer gate open
		innerGate <= 1'b0;
		fillSignal <= 1'b0;
		emptySignal <= 1'b0;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b1; // tries to empty with outer gate open
		innerGate <= 1'b0;
		fillSignal <= 1'b0;
		emptySignal <= 1'b1;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b1; // neither fills nor empties with outer gate open
		innerGate <= 1'b0;
		fillSignal <= 1'b0;
		emptySignal <= 1'b0;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // neither fills nor empties with both gates closed
		innerGate <= 1'b0;
		fillSignal <= 1'b0;
		emptySignal <= 1'b0;
		repeat (stateDelay) @(posedge clk);
		outerGate <= 1'b0; // Perform reset to ensure return to defined state
		innerGate <= 1'b0;
		fillSignal <= 1'b0;
		emptySignal <= 1'b0;
		rst <= 1'b1;
		@(posedge clk);
		rst <= 1'b0;
		/*@(posedge clk); 
		outerGate <= 1'b0; // empties w/ both gates closed
		innerGate <= 1'b0;
		fillSignal <= 1'b0;
		emptySignal <= 1'b1;		
		@(posedge clk);
		outerGate <= 1'b0; // fills with inner gate open (undefined)
		innerGate <= 1'b1;
		fillSignal <= 1'b1;
		emptySignal <= 1'b0;
		@(posedge clk);
		outerGate <= 1'b1; // fills with outer gate open (undefined)
		innerGate <= 1'b0;
		fillSignal <= 1'b1;
		emptySignal <= 1'b0;
		@(posedge clk); 
		outerGate <= 1'b0; // empties with inner gate open (undefined)
		innerGate <= 1'b1;
		fillSignal <= 1'b0;
		emptySignal <= 1'b1;
		@(posedge clk);
		outerGate <= 1'b1; // empties with outer gate open (undefined)
		innerGate <= 1'b0;
		fillSignal <= 1'b0;
		emptySignal <= 1'b1;
		@(posedge clk);
		outerGate <= 1'b1; // fills with both gates open (undefined)
		innerGate <= 1'b1;
		fillSignal <= 1'b1;
		emptySignal <= 1'b0;
		@(posedge clk);
		outerGate <= 1'b1; // empties with both gate open (undefined)
		innerGate <= 1'b1;
		fillSignal <= 1'b0;
		emptySignal <= 1'b1;	*/	
	end
	
endmodule
		