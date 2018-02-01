/*
Bathysphere Location Module
Description: This module tells when a bathysphere is inside the interlock depending
	on the inputs given.
Author: Akhil Avula, Varun Venkatesh, Max Thompson
Date: 2/1/18
*/

module bathysphereLocation (bathInChamber, clk, reset, outerGate, innerGate, chamberFull, bathysphereSignal);
	// Set output
	output bathInChamber; // 0 - not in the interlock, 1 - in the interlock
	// Set input
	input clk, reset, outerGate, innerGate, chamberFull;
	input [1:0] bathysphereSignal; // Tells if bathysphere is arriving or departing (or neither).
											 // first bit is departing, second is arriving.
	
	// Variables used to change the state of the bathysphere location in the interlock.
	reg ps, ns;
	
	// Combinational logic to tell when the bathysphere can and cannot be in the interlock.
	always@(*) begin
		case(ps)
			1'b0: if ((bathysphereSignal == 2'b10 & ~chamberFull & innerGate & ~outerGate) 	
						| (bathysphereSignal == 2'b01 & chamberFull & ~innerGate & outerGate)) begin 
								// if it is departing, the chamber is empty, and inner gate is open
								// if it is arriving, the chamber is full, and the outer gate is open
						ns = 1'b1;
					end
					else begin
						ns = ps;
					end
			1'b1: if ((bathysphereSignal == 2'b10 & chamberFull & ~innerGate & outerGate) 
								| (bathysphereSignal == 2'b01 & ~chamberFull & innerGate & ~outerGate)) begin 
								// if it is departing, the chamber is full, and outer gate is open
								// if it is arriving, the chamber is empty, and inner gate is open
						ns = 1'b0;
					end
					else begin
						ns = ps; 
					end
		endcase
	end
	
	// Sequential logic to change the bathysphere state
	always@(posedge clk) begin
		if (reset) begin
			ps <= 0;
		end
		else begin
			ps <= ns;
		end
	end
	
	assign bathInChamber = ps;
	
endmodule 
