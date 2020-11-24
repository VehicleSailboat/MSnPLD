 module ControlUnit(
	input reset,clk,
	input CarryFlag,ZeroFlag,
	output [16:0] ControlBus
);

reg[19:0] ROM [0:255];
initial $readmemb("ROM.bin", ROM);

wire [19:0] Command;
reg [6:0] PC=0;

assign Command=ROM[PC];


always @(posedge clk) begin
	if(reset) begin
		PC <=0;
	end
	else
	begin
		case(Command[19:17])
			3'b000:
					PC<=PC+1;
			3'b001:
				if(!ZeroFlag)
					PC<=Command[6:0];
				else
					PC<=PC+1;
			3'b010:
				if(CarryFlag && !ZeroFlag)
					PC<=Command[6:0];
				else
					PC<=PC+1;
			3'b011:
				if(!CarryFlag && !ZeroFlag)
					PC<=Command[6:0];
				else
					PC<=PC+1;
			3'b100:
				if(ZeroFlag)
					PC<=Command[6:0];
				else
					PC<=PC+1;
			3'b101:
				if(CarryFlag || ZeroFlag)
					PC<=Command[6:0];
				else
					PC<=PC+1;
			3'b110:
				if(!CarryFlag || ZeroFlag)
					PC<=Command[6:0];
				else
					PC<=PC+1;
			3'b111:
				PC<=Command[6:0];
		endcase
	end
end

assign ControlBus=(Command[19:17]==3'b000)?Command[16:0]:17'b0;
endmodule