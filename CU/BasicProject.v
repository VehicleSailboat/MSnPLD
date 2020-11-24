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
// CREATED		"Sun Nov 15 02:44:07 2020"

module BasicProject(
	PS2_CLK,
	PS2_DAT,
	CLOCK_50,
	KEY,
	SW,
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	LEDG,
	LEDR
);


input wire	PS2_CLK;
input wire	PS2_DAT;
input wire	CLOCK_50;
input wire	[3:0] KEY;
input wire	[9:0] SW;
output wire	[6:0] HEX0;
output wire	[6:0] HEX1;
output wire	[6:0] HEX2;
output wire	[6:0] HEX3;
output wire	[7:0] LEDG;
output wire	[9:0] LEDR;

wire	B0;
wire	B1;
wire	B2;
wire	B3;
wire	[31:0] freq;
wire	[6:0] H0;
wire	[6:0] H1;
wire	[6:0] H2;
wire	[6:0] H3;
wire	[15:0] Indicator;
wire	[3:0] KB;
wire	KP;
wire	[7:0] LG;
wire	[9:0] SWCH;

wire	[7:0] GDFX_TEMP_SIGNAL_0;





assign	GDFX_TEMP_SIGNAL_0 = {freq[26:24],KP,B3,B2,B1,B0};


CU	b2v_CU(
	.clk(CLOCK_50),
	.reset(B0),
	.KP(KP),
	.KB(KB),
	.Indicator(Indicator));


InputModule	b2v_Input(
	.clk(CLOCK_50),
	.ps_clk(PS2_CLK),
	.ps_dat(PS2_DAT),
	.t_key(KEY),
	.t_sw(SW),
	.KeyPressed(KP),
	.Button0(B0),
	.Button1(B1),
	.Button2(B2),
	.Button3(B3),
	.freq(freq),
	.KeyboardBus(KB),
	.Switch(SWCH));

assign	LG = GDFX_TEMP_SIGNAL_0;


assign	HEX0 =  ~H0;

assign	HEX1 =  ~H1;

assign	HEX2 =  ~H2;

assign	HEX3 =  ~H3;


OutputModule	b2v_Output(
	.clk(CLOCK_50),
	
	
	
	
	.HEX_0(Indicator[3:0]),
	.HEX_1(Indicator[7:4]),
	.HEX_2(Indicator[11:8]),
	.HEX_3(Indicator[15:12]),
	.LedGreen(LG),
	.LedRed(SWCH),
	.H0(H0),
	.H1(H1),
	.H2(H2),
	.H3(H3),
	.LG(LEDG),
	.LR(LEDR));


endmodule
