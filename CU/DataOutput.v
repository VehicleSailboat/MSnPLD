module DataOutput ( input	    	 	clk,
					input	    	 	reset,
					input	    	 	rw,
					input     	[3:0]  	Data,
					input     	[1:0]  	PortID,
					output reg 	[15:0] 	Indicator );
					
always @ (posedge clk)
	if(reset) Indicator <= 16'b0;
	else 
	if(rw)
	
		case(PortID)
			0: Indicator[3:0]   <= Data;
			1: Indicator[7:4]   <= Data;
			2: Indicator[11:8]  <= Data;
			3: Indicator[15:12] <= Data;
		endcase

endmodule
