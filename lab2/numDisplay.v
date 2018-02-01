/*
Number Display Module
Description: This module displays a number on the HEX that represents the time counting down.
Author: Akhil Avula, Varun Venkatesh, Max Thompson
Date: 2/1/18
*/
module numDisplay (hexNum, count);

	output [6:0] hexNum;
	
	input [3:0] count;
	
	reg [6:0] number; 
	
	// based on the count inputted into the module, display the number on the hex
	always@(*) begin
		case(count)
			0: number = 7'b1000000; // Display 0
			1: number = 7'b1111001; // Display 1
			2: number = 7'b0100100; // Display 2
			3: number = 7'b0110000; // Display 3
			4: number = 7'b0011001; // Display 4
			5: number = 7'b0010010; // Display 5
			6: number = 7'b0000010; // Display 6
			7: number = 7'b1111000; // Display 7
			8: number = 7'b0000000; // Display 8
			default: number = 7'b1111111; // Display nothing
		endcase
	end
	
	assign hexNum = number;
endmodule 