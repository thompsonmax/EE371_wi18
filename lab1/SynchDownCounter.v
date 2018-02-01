// Copyright (C) 2017  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 17.1.0 Build 590 10/25/2017 SJ Standard Edition"
// CREATED		"Wed Jan 17 14:16:03 2018"

module SynchDownCounter(
	reset,
	clk,
	out2,
	out3,
	out1,
	out0
);


input wire	reset;
input wire	clk;
output wire	out2;
output wire	out3;
output wire	out1;
output wire	out0;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_10;
wire	SYNTHESIZED_WIRE_2;
reg	SYNTHESIZED_WIRE_11;
reg	SYNTHESIZED_WIRE_12;
reg	SYNTHESIZED_WIRE_13;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_8;
reg	DFF_inst;
wire	SYNTHESIZED_WIRE_9;

assign	out2 = SYNTHESIZED_WIRE_13;
assign	out3 = DFF_inst;
assign	out1 = SYNTHESIZED_WIRE_12;
assign	out0 = SYNTHESIZED_WIRE_11;
assign	SYNTHESIZED_WIRE_10 = 1;




always@(posedge clk or negedge reset or negedge SYNTHESIZED_WIRE_10)
begin
if (!reset)
	begin
	DFF_inst <= 0;
	end
else
if (!SYNTHESIZED_WIRE_10)
	begin
	DFF_inst <= 1;
	end
else
	begin
	DFF_inst <= SYNTHESIZED_WIRE_0;
	end
end


always@(posedge clk or negedge reset or negedge SYNTHESIZED_WIRE_10)
begin
if (!reset)
	begin
	SYNTHESIZED_WIRE_13 <= 0;
	end
else
if (!SYNTHESIZED_WIRE_10)
	begin
	SYNTHESIZED_WIRE_13 <= 1;
	end
else
	begin
	SYNTHESIZED_WIRE_13 <= SYNTHESIZED_WIRE_2;
	end
end

assign	SYNTHESIZED_WIRE_8 = SYNTHESIZED_WIRE_11 | SYNTHESIZED_WIRE_12;

assign	SYNTHESIZED_WIRE_9 = SYNTHESIZED_WIRE_12 | SYNTHESIZED_WIRE_11 | SYNTHESIZED_WIRE_13;



always@(posedge clk or negedge reset or negedge SYNTHESIZED_WIRE_10)
begin
if (!reset)
	begin
	SYNTHESIZED_WIRE_12 <= 0;
	end
else
if (!SYNTHESIZED_WIRE_10)
	begin
	SYNTHESIZED_WIRE_12 <= 1;
	end
else
	begin
	SYNTHESIZED_WIRE_12 <= SYNTHESIZED_WIRE_4;
	end
end


always@(posedge clk or negedge reset or negedge SYNTHESIZED_WIRE_10)
begin
if (!reset)
	begin
	SYNTHESIZED_WIRE_11 <= 0;
	end
else
if (!SYNTHESIZED_WIRE_10)
	begin
	SYNTHESIZED_WIRE_11 <= 1;
	end
else
	begin
	SYNTHESIZED_WIRE_11 <= SYNTHESIZED_WIRE_6;
	end
end

assign	SYNTHESIZED_WIRE_6 =  ~SYNTHESIZED_WIRE_11;

assign	SYNTHESIZED_WIRE_4 = SYNTHESIZED_WIRE_12 ~^ SYNTHESIZED_WIRE_11;

assign	SYNTHESIZED_WIRE_2 = SYNTHESIZED_WIRE_13 ~^ SYNTHESIZED_WIRE_8;

assign	SYNTHESIZED_WIRE_0 = DFF_inst ~^ SYNTHESIZED_WIRE_9;


endmodule
