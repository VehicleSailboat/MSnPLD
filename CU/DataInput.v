module DataInput ( 	input 	   		clk,
					input       	reset,
					input 	[3:0] 	KB,
					input 	   		KP,
					input	   		PortID,
					input	   		PortRead,
					output 	[3:0] 	DataOut );

reg 	  KPD, Ready;
reg [3:0] Data;

always @ (posedge clk)
	if(reset)
	begin
		KPD  <= 1'b0;
		Data <= 4'b0;
	end else
	begin
		KPD <= KP;
		if(KP & ~KPD) Data <= KB;
	end
	
always @ (posedge clk)
	if(reset | (PortRead & Ready & ~PortID)) Ready <= 1'b0;
	else if(KP & ~KPD) Ready <= 1'b1;

assign DataOut = PortID ? Data : {3'b000, Ready};

endmodule