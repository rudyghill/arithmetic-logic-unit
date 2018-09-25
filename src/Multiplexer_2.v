//Rudy Hill
//ECEN 2350
//Spring 2018

module MULTIPLEXER_2(MODE,A,B,C,D,F);
	input [1:0] MODE;
	input [9:0] A,B,C,D;
	output reg [9:0] F;
	reg [1:0] button;
	
	initial
	begin
		button = 2'b00;
	end
		
	always @(posedge MODE[0])
	begin
		button[0] = ~button[0];
	end
	
	always @(posedge MODE[1])
	begin
		button[1] = ~button[1];
	end
	
	always @*
		case(button)
			2'b00: F = A;
			2'b01: F = B;
			2'b10: F = C;
			2'b11: F = D;
		endcase
endmodule
		
	
