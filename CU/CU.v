// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"
// CREATED		"Sun Nov 15 02:44:59 2020"

module CU(
	clk,
	reset,
	KP,
	KB,
	Indicator
);


input wire	clk;
input wire	reset;
input wire	KP;
input wire	[3:0] KB;
output wire	[15:0] Indicator;

wire	[3:0] DataIn;
wire	[3:0] DataOut;
wire	[2:0] PortID;
wire	PortRead;
wire	PortWrite;





CCD	b2v_CCD(
	.clk(clk),
	.reset(reset),
	.DataIn(DataIn),
	.PortRead(PortRead),
	.PortWrite(PortWrite),
	.DataOut(DataOut),
	.PortID(PortID));


DataInput	b2v_DI(
	.clk(clk),
	.reset(reset),
	.KP(KP),
	.PortID(PortID[0]),
	.PortRead(PortRead),
	.KB(KB),
	.DataOut(DataIn));


DataOutput	b2v_DO(
	.clk(clk),
	.reset(reset),
	.rw(PortWrite),
	.Data(DataOut),
	.PortID(PortID[1:0]),
	.Indicator(Indicator));


endmodule
