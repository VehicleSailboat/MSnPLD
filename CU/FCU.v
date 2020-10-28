module FCU (
	input Pin,
	input [3:0] D,F,
	output [3:0] P
);

assign P[0]=D[0]||(Pin&F[0]);
assign P[1]=D[1]||(D[0]&F[1])||(Pin&F[0]&F[1]);
assign P[2]=D[2]||(D[1]&F[2])||(D[0]&F[1]&F[2])||(Pin&F[0]&F[1]&F[2]);
assign P[3]=D[3]||(D[2]&F[3])||(D[1]&F[2]&F[3])||(D[0]&F[1]&F[2]&F[3])||(Pin&F[0]&F[1]&F[2]&F[3]);

endmodule





