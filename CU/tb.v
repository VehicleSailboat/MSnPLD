`timescale 1ns/1ns
module tb();


reg clk,reset;
reg [3:0] DataIn;
wire [3:0] Rout;
//АЛУ	
reg [3:0] S;
reg M,Pin;
wire Pout;
//AЛУ
//регистры
reg A;
reg [3:0] v;
reg ISR,ISL;
wire OSR,OSL;
//регистры
//RAM
reg [2:0] adr;
reg wr;
//RAM

RALU UUT(
	.clk(clk),
	.reset(reset),
	.DataIn(DataIn),
	.Rout(Rout),
	.S(S),
	.M(M),
	.Pin(Pin),
	.Pout(Pout),
	.A(A),
	.v(v),
	.ISR(ISR),
	.ISL(ISL),
	.OSR(OSR),
	.OSL(OSL),
	.adr(adr),
	.wr(wr)
);

always begin
#10 clk=~clk;
end

initial begin
clk=0;
reset=0;
DataIn=0;
S=0;
M=0;
Pin=0;
A=0;
v=0;
ISR=0;
ISL=0;
adr=0;
wr=0;

//reset
#20
reset=1;
#20
reset=0;
#30

//A=0101 -> RgA -> (A-1) -> RAM -> RgB
DataIn=4'b0101;
A=1;
v=4'b0111;
S=4'b1111; M=1;
wr=1;
#40
wr=0;
#20
//B=1100 -> RgA
v=4'b0001;
DataIn=4'b1100;
S=4'b0100;M=0;
//Rout
#20
v=4'b1000;
#100
$finish;

end



/*initial
	$monitor($stime,,RALU);*/	

initial begin
  $dumpfile("RALU.vcd");
  $dumpvars;
end

endmodule