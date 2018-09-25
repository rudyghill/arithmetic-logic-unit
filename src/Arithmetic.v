//Rudy Hill
//ECEN 2350
//Spring 2018

module ARITHMETIC(NUMBER, OP, F);
	input [7:0] NUMBER;
	input [1:0] OP;
	output [9:0] F;
	wire [39:0] W;
	
	ADD A1(NUMBER[7:4],NUMBER[3:0],W[39:30]);
	SUB S1(NUMBER[7:4],NUMBER[3:0],W[29:20]);
	MULT M1(NUMBER[7:0],W[19:10]);
	DIV D1(NUMBER[7:0],W[9:0]);
	
	MULTIPLEXER M3(OP,W[39:30],W[29:20],W[19:10],W[9:0],F);
endmodule

module MULT(A,product);
	input [7:0] A; 
	output [9:0] product;
	
	// procedural or continuous?
	assign product[7:0] = A << 1;
	// what is going on here? Do A and product have to be the same size
	assign product[8] = 0;
	assign product[9] = A[7];
endmodule

module DIV(A,quotient);
	input [7:0] A;
	output [9:0] quotient;
	
	// procedural or continuous?
	assign quotient[7:0] = A >> 1;
	assign quotient[8] = 0;
	assign quotient[9] = A[0];
endmodule

//page 713
module ADD(A, B, sum);
	parameter n = 4;
	input [n-1:0] A,B;
	output [9:0] sum;
	wire [n:0] C;
	
	genvar i;
	// sets initial carryin to 0
	assign C[0] = 0;
	
	generate
		for (i = 0; i < n; i = i+1)
		begin:addbit
			full_add stage(A[i],B[i],C[i],sum[i],C[i+1]);
		end
	endgenerate
	
	assign sum[n] = C[n];
	assign sum[8:5] = 4'b0000;
	assign sum[9] = C[n];
endmodule

module SUB(X,Y,difference);
	parameter n = 4;
	input [n-1:0] X,Y;
	wire [9:0] DP;
	wire [9:0] DN;
	wire [9:0] DN2;
	reg [n-1:0] temp;
	output reg [9:0] difference;
	wire [n:0] B;
	integer k;
	
	genvar i;
	assign B[0] = 0;
	
	generate
		for (i = 0; i < n; i = i+1)
		begin:subtractbit
			full_subtract stage(X[i],Y[i],B[i],DP[i],B[i+1]);
		end
	endgenerate
	
	always @*
	begin	
		for (k=0; k<n; k=k+1)
		begin
			temp[k] = ~DP[k];
		end
	end
	
	ADD A2(temp[n-1:0], 4'b0001, DN[9:0]);
	
	assign DN2[8:0] = DN[8:0];
	assign DN2[9] = 1;
	
	assign DP[8:n]= 5'b00000;
	assign DP[9]=0;
	
	always @*
		case(B[n])
			1'b0: difference = DP;
			1'b1: difference = DN2;
		endcase
endmodule


module full_add(input A, input B, input C0, output sum, output C1);
	assign sum = A^B^C0;
	assign C1 = (A&B)|(A&C0)|(B&C0);
endmodule

module full_subtract(input A, input B, input B0, output difference, output B1);
	assign difference = A^B^B0;
	assign B1 = (~A&B)|(~A&B0)|(B&B0);
endmodule


	
