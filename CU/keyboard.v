module keyboard(	input 				ps2clk,
					input 				ps2dat,
					output	reg			KP,
					output	reg	[3:0]	KB);


reg	[3:0]	i=0;
reg	[7:0]	num=0;
reg	[2:0]	in=0;
reg			dub=0;

always @ (posedge ps2clk)	begin
	i = i + 1'b1;
	case (i)
		1:		in = 1'b0;
		2,3,4,5,6,7,8,9:	begin
					num[in] = ps2dat;
					in = in + 1'b1;
				end
		10:		begin
					if (~num[7])	begin
						if ((	num==8'b01101001)||(num==8'b01110010)||(num==8'b01111010)||(num==8'b01101011)
							||(num==8'b01110011)||(num==8'b01110100)||(num==8'b01101100)||(num==8'b01110101)
							||(num==8'b01111101)||(num==8'b00011100)||(num==8'b00110010)||(num==8'b00100001)
							||(num==8'b00100011)||(num==8'b00100100)||(num==8'b00101011)||(num==8'b01110000))	begin
								dub <= 1'b1;
						end
					end
				end
		11: 	begin
					i = 4'b0000;
					in = 1'b0;
					dub <= 1'b0;
				end
	endcase
	if (i == 4'b1100)
		i = 4'b0;
end

always @ (posedge dub)
	KP = ~KP;

always @ (posedge KP)	begin
	case (num)
		8'b0110_1001: KB <= 4'b0001; // 1
		8'b0111_0010: KB <= 4'b0010; // 2
		8'b0111_1010: KB <= 4'b0011; // 3
		8'b0110_1011: KB <= 4'b0100; // 4
		8'b0111_0011: KB <= 4'b0101; // 5
		8'b0111_0100: KB <= 4'b0110; // 6
		8'b0110_1100: KB <= 4'b0111; // 7
		8'b0111_0101: KB <= 4'b1000; // 8
		8'b0111_1101: KB <= 4'b1001; // 9
		8'b0001_1100: KB <= 4'b1010; // A
		8'b0011_0010: KB <= 4'b1011; // B
		8'b0010_0001: KB <= 4'b1100; // C
		8'b0010_0011: KB <= 4'b1101; // D
		8'b0010_0100: KB <= 4'b1110; // E
		8'b0010_1011: KB <= 4'b1111; // F
		8'b0111_0000: KB <= 4'b0000; // 0
	endcase
end

endmodule 