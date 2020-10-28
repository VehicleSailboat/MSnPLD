module SM (A,B,S,M,Pin,R,D,F,Pout);

	input  A,B,M,Pin;
	input  [3:0] S;
	output R,D,F,Pout;

/* description */
assign R = (S[3]&A&B|S[2]&A&~B)^(A|S[1]&~B|S[0]&B)^(M&Pin);
assign D=(S[3]&A&B)|(S[2]&A&~B);
assign F=A|(S[1]&~B)|(S[0]&B);
assign Pout=D|F&Pin;
/* description */

endmodule

