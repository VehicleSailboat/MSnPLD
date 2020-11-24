module	CodeToHex	(	input						clk,
								input				[3:0]	code_n,
								input						non_code,
								output	reg	[6:0]	hex_n);

always @ (posedge clk)	begin
	if (non_code)
		hex_n <= 7'b0;
	else
		case (code_n)
			4'b0000:	hex_n <= 7'b0111111;
			4'b0001:	hex_n <= 7'b0000110;
			4'b0010:	hex_n <= 7'b1011011;
			4'b0011:	hex_n <= 7'b1001111;
			4'b0100:	hex_n <= 7'b1100110;
			4'b0101:	hex_n <= 7'b1101101;
			4'b0110:	hex_n <= 7'b1111101;
			4'b0111:	hex_n <= 7'b0000111;
			4'b1000:	hex_n <= 7'b1111111;
			4'b1001:	hex_n <= 7'b1101111;
			4'b1010:	hex_n <= 7'b1110111;
			4'b1011:	hex_n <= 7'b1111100;
			4'b1100:	hex_n <= 7'b0111001;
			4'b1101:	hex_n <= 7'b1011110;
			4'b1110:	hex_n <= 7'b1111001;
			4'b1111:	hex_n <= 7'b1110001;
		endcase
end

endmodule 