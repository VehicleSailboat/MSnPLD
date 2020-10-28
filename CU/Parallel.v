module Parallel (
	input [3:0] A,B,S,
	input M,Pin,
	output Pout,
	output [3:0] R
	);

wire [3:0] D,F,P;

SM SM0 (
	.A(A[0]),
	.B(B[0]),
	.S(S),
	.R(R[0]),
	.D(D[0]),
	.F(F[0]),
	.M(M),
	.Pin(Pin)
	);

SM SM1 (
	.A(A[1]),
	.B(B[1]),
	.S(S),
	.R(R[1]),
	.D(D[1]),
	.F(F[1]),
	.M(M),
	.Pin(P[0])
	);

SM SM2 (
	.A(A[2]),
	.B(B[2]),
	.S(S),
	.R(R[2]),
	.D(D[2]),
	.F(F[2]),
	.M(M),
	.Pin(P[1])
);

SM SM3 (
	.A(A[3]),
	.B(B[3]),
	.S(S),
	.R(R[3]),
	.D(D[3]),
	.F(F[3]),
	.M(M),
	.Pin(P[2])
	);

FCU FCU(
	.Pin(Pin),
	.D(D),
	.F(F),
	.P(P)
	);

assign Pout=P[3];

endmodule