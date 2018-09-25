//Rudy Hill
//ECEN 2350
//Spring 2018

module COMPARISON(NUMBER, OP, F);
	input [7:0] NUMBER;
	input [1:0] OP;
	output [9:0] F;
	wire [39:0] W;
	
	EQUAL E1(NUMBER[7:4],NUMBER[3:0],W[39:30]);
	GREATER G1(NUMBER[7:4],NUMBER[3:0],W[29:20]);
	LESSER L1(NUMBER[7:4],NUMBER[3:0],W[19:10]);
	MAX M1(NUMBER[7:4],NUMBER[3:0],W[9:0]);
	
	MULTIPLEXER M2(OP,W[39:30],W[29:20],W[19:10],W[9:0],F);
	
endmodule

module EQUAL(A,B,F);
	input [3:0] A,B;
	output reg [9:0] F;
	
	always @*
	begin
		if(A == B)
			F[0] = 1;
		else
			F[0] = 0;
		F[9:1] = 9'b000000000;
	end
endmodule

module GREATER(A,B,F);
	input [3:0] A,B;
	output reg [9:0] F;
	
	always @*
	begin
		if(A > B)
			F[0] = 1;
		else
			F[0] = 0;
		F[9:1] = 9'b000000000;
	end
endmodule

module LESSER(A,B,F);
	input [3:0] A,B;
	output reg [9:0] F;
	
	always @*
	begin
		if(A < B)
			F[0] = 1;
		else
			F[0] = 0;
		F[9:1] = 9'b000000000;
	end
endmodule

module MAX(A,B,F);
	input [3:0] A,B;
	wire [6:0] i;
	output [9:0] F;

	//A>B
	assign i[0] = A[3] & ~B[3];
	//A3=B3
	assign i[1] = ~(A[3]^B[3]);
	//A>B
	assign i[2] = (i[1]&A[2]& ~B[2])|i[0];
	//A3,A2=B3,B2
	assign i[3] = i[1] & ~(A[2]^B[2]);
	//A>B
	assign i[4] = (i[3]&A[1]& ~B[1])|i[2];
	//A3,A2,A1=B3,B2,B1
	assign i[5] = i[3] & ~(A[1]^B[1]);
	//A>B
	assign i[6] = (i[5]&A[0]& ~B[0])|i[4];
	
	assign F[0] = (i[6]&A[0])|(~i[6]&B[0]);
	assign F[1] = (i[6]&A[1])|(~i[6]&B[1]);
	assign F[2] = (i[6]&A[2])|(~i[6]&B[2]);
	assign F[3] = A[3]|B[3];
	assign F[9:4] = 6'b000000;
endmodule
	
