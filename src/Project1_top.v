//Rudy Hill
//ECEN 2350
//Spring 2018

module Project1_top(MODE, OP, IN, LED, HEX0, HEX1, HEX5, CLOCK);
	input [1:0] MODE,OP;
	input [7:0] IN;
	input CLOCK;
	output [9:0] LED;
	output [7:0] HEX0,HEX1,HEX5;
	wire [39:0] W;
	wire[9:0] F;
	
	ARITHMETIC A1(IN,OP,W[39:30]);
	LOGIC L1(IN,OP,W[29:20]);
	COMPARISON C1(IN,OP,W[19:10]);
	MAGIC MA1(CLOCK, W[9:0]);
	
	//assign W[39:30] = 10'b1111111111;
	
	MULTIPLEXER_2 M1(MODE,W[39:30],W[29:20],W[19:10],W[9:0],F);
	
	print_mode P1(MODE,HEX5);
	
	eight_segment E1(F[7:4],HEX1[7:0]);
	eight_segment E2(F[3:0],HEX0[7:0]);
	
	assign LED = F;
	
	
	// 7-segment display
endmodule
