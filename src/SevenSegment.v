//Rudy Hill
//ECEN 2350
//Spring 2018

module eight_segment(IN,OUT);
	input [3:0] IN;
	output reg [7:0] OUT;
	
	always @*
		case(IN)
			4'b0000: OUT = 8'b11000000;
			4'b0001: OUT = 8'b11111001;
			4'b0010: OUT = 8'b10100100;
			4'b0011: OUT = 8'b10110000;
			4'b0100: OUT = 8'b10011001;
			4'b0101: OUT = 8'b10010010;
			4'b0110: OUT = 8'b10000010;
			4'b0111: OUT = 8'b11111000;
			4'b1000: OUT = 8'b10000000;
			4'b1001: OUT = 8'b10010000;
			4'b1010: OUT = 8'b10001000;
			4'b1011: OUT = 8'b10000011;
			4'b1100: OUT = 8'b11000110;
			4'b1101: OUT = 8'b10100001;
			4'b1110: OUT = 8'b10000110;
			4'b1111: OUT = 8'b10001110;
		endcase
endmodule
