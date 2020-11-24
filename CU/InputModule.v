module InputModule (	input							clk,
							input				[9:0]		t_sw,
							input				[3:0]		t_key,
							input							ps_clk,
							input							ps_dat,
							output	reg	[31:0]	freq,
							output	reg	[9:0]		Switch,
							output			[3:0]		KeyboardBus,
							output						KeyPressed,
							output	reg				Button0,
							output	reg				Button1,
							output	reg				Button2,
							output	reg				Button3);

always @ (posedge clk)	begin
	Button0 <= t_key[0];
	Button1 <= t_key[1];
	Button2 <= t_key[2];
	Button3 <= t_key[3];
	freq <= freq + 1'b1;
	Switch <= t_sw;
end

switch setter(
	.clk(clk),
	.SW(t_sw),
	.KP(KeyPressed),
	.KB(KeyboardBus)
);

keyboard	u1(	
	.ps2clk(ps_clk),
	.ps2dat(ps_dat)
);


endmodule 