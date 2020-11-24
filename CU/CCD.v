 module CCD(
	input clk,reset,
	input [3:0] DataIn,
	output [3:0] DataOut,
	output PortRead,PortWrite,
	output [2:0] PortID
);

wire [16:0] ControlBus;
wire Pout;
reg CarryFlag,ZeroFlag;

ControlUnit CU(
	.reset(reset),
	.clk(clk),
	.CarryFlag(CarryFlag),
	.ZeroFlag(ZeroFlag),
	.ControlBus(ControlBus)
);

RALU RALU(
	.clk(clk),
	.reset(reset),
	.DataIn(DataIn),
	.S(ControlBus[16:13]),
	.M(ControlBus[12]),
	.Pin(ControlBus[11]),
	.ISR(ControlBus[10]),
	.ISL(ControlBus[9]),
	.A(ControlBus[8]),
	.wr(ControlBus[7]),
	.adr(ControlBus[6:4]),
	.v(ControlBus[3:0]),

	.Pout(Pout),
	.Rout(DataOut)
);

assign PortRead=ControlBus[8]&ControlBus[0];
assign PortWrite=ControlBus[3];
assign PortID=ControlBus[6:4];

always @(posedge clk) begin
	if(reset) begin
			CarryFlag<=0;
			ZeroFlag<=0;
		end
	else
	begin
		CarryFlag<=Pout;
		ZeroFlag<=~(DataOut[3]||DataOut[2]||DataOut[1]||DataOut[0]);
	end
end


endmodule