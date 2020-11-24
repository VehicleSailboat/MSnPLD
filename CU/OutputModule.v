module OutputModule (	input						clk,
								input				[9:0]	LedRed,
								input				[7:0]	LedGreen,
								input				[3:0]	HEX_0,
								input				[3:0]	HEX_1,
								input				[3:0]	HEX_2,
								input				[3:0]	HEX_3,
								input						hex_0_off,
								input						hex_1_off,
								input						hex_2_off,
								input						hex_3_off,
								output	reg	[9:0]	LR,
								output	reg	[7:0]	LG,
								output			[6:0]	H0,
								output			[6:0]	H1,
								output			[6:0]	H2,
								output			[6:0]	H3);

always @ (posedge clk)	begin
	LR <= LedRed;
	LG <= LedGreen;
end

CodeToHex	conv0 (	.clk(clk),	.code_n(HEX_0),	.non_code(hex_0_off),	.hex_n(H0));
CodeToHex	conv1 (	.clk(clk),	.code_n(HEX_1),	.non_code(hex_1_off),	.hex_n(H1));
CodeToHex	conv2 (	.clk(clk),	.code_n(HEX_2),	.non_code(hex_2_off),	.hex_n(H2));
CodeToHex	conv3 (	.clk(clk),	.code_n(HEX_3),	.non_code(hex_3_off),	.hex_n(H3));

endmodule 