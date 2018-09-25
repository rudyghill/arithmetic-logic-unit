//Rudy Hill
//ECEN 2350
//Spring 2018

/* Multiplexer.v
 * This needs to take in a all of the outputs from the cpu operation modules and the
 * mode buttons, to output to a the 7-segment display.
 * 	This module should multiplex a single digit-to-7segment display.
 * Hint:​ These should be ​~kinda like ​a 4-1 multiplexer implementation, where each1 input
 * of to the multiplexer is actually a full BCD digit output from the differentmodules.
 */
 
 module MULTIPLEXER(MODE,A,B,C,D,F);
	input [1:0] MODE;
	input [9:0] A,B,C,D;
	output reg [9:0] F;
	
	always @*
		case(MODE)
			2'b00: F = A;
			2'b01: F = B;
			2'b10: F = C;
			2'b11: F = D;
		endcase
endmodule

