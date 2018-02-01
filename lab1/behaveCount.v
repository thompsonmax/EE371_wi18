`ifndef behaveCount 
`define behaveCount
/*
	File Name: behaveCount.v
	Description: Johnson Down counter using behavior modeling. 
	Authors: Varun Venkatesh, Akhil Avula, Max Thompson	

*/
module behaveCount(reset, clk, count);
// declare input and output variables
	input clk,reset;
	output reg [3:0] count;
	
	
	// Ring counter that changes/shifts the bit down and replaces
	// the most significant bit with the opposite value of the previous
	// least significant bit
	always @(posedge clk or negedge reset) begin// or negedge reset) begin
		if (!reset)
			count <= 4'b0000;
		else begin
				count <= {~count[0], count[3:1]};
		end
	end
	
endmodule 

`endif
