module	test (	
	input		[1:0]	clk,
	output	reg	[3:0]	HEX0,
	output	reg	[3:0]	HEX1,
	output	reg			h2,
	output	reg			h3 );

always @ (posedge clk[0])
	HEX0 <= HEX0 + 1'b1;

always @ (posedge clk[1])
	HEX1 <= HEX1 + 1'b1;

always @ (posedge clk[0])	
	h2 = ~h2;

always @ (posedge clk[1])	
	h3 = ~h3;

endmodule 