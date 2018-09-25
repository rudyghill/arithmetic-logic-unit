//Rudy Hill
//ECEN 2350
//Spring 2018

module LOGIC(NUMBER, OP, F);
	input [7:0] NUMBER;
	input [1:0] OP;
	output [9:0] F;
	wire [39:0] W;
	
	MY_AND A1(NUMBER[7:4],NUMBER[3:0],W[39:30]);
	MY_OR O1(NUMBER[7:4],NUMBER[3:0],W[29:20]);
	MY_EXOR E1(NUMBER[7:4],NUMBER[3:0],W[19:10]);
	MY_NOT N1(NUMBER[7:0],W[9:0]);
	
	
	//AND FOR 00, OR FOR 01, XOR FOR 10, NOT FOR 11
	assign F[0] = (~OP[0]&~OP[1]&W[30])|(OP[0]&~OP[1]&W[20])|(~OP[0]&OP[1]&W[10])|(OP[0]&OP[1]&W[0]);
	assign F[1] = (~OP[0]&~OP[1]&W[31])|(OP[0]&~OP[1]&W[21])|(~OP[0]&OP[1]&W[11])|(OP[0]&OP[1]&W[1]);
	assign F[2] = (~OP[0]&~OP[1]&W[32])|(OP[0]&~OP[1]&W[22])|(~OP[0]&OP[1]&W[12])|(OP[0]&OP[1]&W[2]);
	assign F[3] = (~OP[0]&~OP[1]&W[33])|(OP[0]&~OP[1]&W[23])|(~OP[0]&OP[1]&W[13])|(OP[0]&OP[1]&W[3]);
	assign F[4] = (~OP[0]&~OP[1]&W[34])|(OP[0]&~OP[1]&W[24])|(~OP[0]&OP[1]&W[14])|(OP[0]&OP[1]&W[4]);
	assign F[5] = (~OP[0]&~OP[1]&W[35])|(OP[0]&~OP[1]&W[25])|(~OP[0]&OP[1]&W[15])|(OP[0]&OP[1]&W[5]);
	assign F[6] = (~OP[0]&~OP[1]&W[36])|(OP[0]&~OP[1]&W[26])|(~OP[0]&OP[1]&W[16])|(OP[0]&OP[1]&W[6]);
	assign F[7] = (~OP[0]&~OP[1]&W[37])|(OP[0]&~OP[1]&W[27])|(~OP[0]&OP[1]&W[17])|(OP[0]&OP[1]&W[7]);
	assign F[8] = (~OP[0]&~OP[1]&W[38])|(OP[0]&~OP[1]&W[28])|(~OP[0]&OP[1]&W[18])|(OP[0]&OP[1]&W[8]);
	assign F[9] = (~OP[0]&~OP[1]&W[39])|(OP[0]&~OP[1]&W[29])|(~OP[0]&OP[1]&W[19])|(OP[0]&OP[1]&W[9]);
endmodule
			
/*Take two 4 bit inputs and output ANDed 
 *4bits and 6 leading zeroes*/
module MY_AND(A,B,F);
	input [3:0] A,B;
	output [9:0] F;
	
	assign F[0] = A[0] & B[0];
	assign F[1] = A[1] & B[1];
	assign F[2] = A[2] & B[2];
	assign F[3] = A[3] & B[3];
	assign F[9:4] = 6'b000000;
endmodule

module MY_OR(A,B,F);
	input [3:0] A,B;
	output [9:0] F;
	
	assign F[0] = A[0]|B[0];
	assign F[1] = A[1]|B[1];
	assign F[2] = A[2]|B[2];
	assign F[3] = A[3]|B[3];
	assign F[9:4] = 6'b000000;
endmodule

module MY_EXOR(A,B,F);
	input [3:0] A,B;
	output [9:0] F;
	
	assign F[0] = A[0]^B[0];
	assign F[1] = A[1]^B[1];
	assign F[2] = A[2]^B[2];
	assign F[3] = A[3]^B[3];
	assign F[9:4] = 6'b000000;
endmodule

module MY_NOT(A,F);
	input [7:0] A;
	output [9:0] F;
	
	assign F[0] = ~A[0];
	assign F[1] = ~A[1];
	assign F[2] = ~A[2];
	assign F[3] = ~A[3];
	assign F[4] = ~A[4];
	assign F[5] = ~A[5];
	assign F[6] = ~A[6];
	assign F[7] = ~A[7];
	assign F[8] = 0;
	assign F[9] = 0;
endmodule
