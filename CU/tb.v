`timescale 1ns/1ns

module tb();

reg clk;
reg [9:0] SW;
wire [6:0] H0,H1,H2,H3;
reg [3:0] KEY;
BasicProject UUT(
	.KEY(KEY),
	.CLOCK_50(clk),
	.SW(SW),
	.HEX0(H0),
	.HEX1(H1),
	.HEX2(H2),
	.HEX3(H3)
);

always begin
#10 clk=~clk;
end

initial begin
  $dumpfile("BP.vcd");
  $dumpvars;
end

initial begin
clk=0;
SW=0;
KEY=0;
#10
KEY[0]=1;
#100
KEY[0]=0;
#200
SW [9:6] = 4'd4;
SW [5] = 1;
#100
SW[5]=0;
#200
SW [9:6] = 4'b0101;
SW [5] = 1;
#100
SW[5]=0;
#200
SW [9:6] = 4'b1100;
SW [5] = 1;
#100
SW[5]=0;
#500
$finish;
end

endmodule