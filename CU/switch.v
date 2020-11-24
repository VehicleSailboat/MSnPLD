module switch(
	input clk,
	input [9:0] SW,
	output [3:0] KB,
	output KP
);

// send button (switch)
wire send;
reg [2:0] send_sync;
always @(posedge clk) begin
	send_sync={SW[5],send_sync[2:1]};
end
assign send = (~send_sync[2] & send_sync[1]);
// send button (switch)

assign KB = SW[9:6];
assign KP = send;



endmodule