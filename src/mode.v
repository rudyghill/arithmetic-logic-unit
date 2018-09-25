//Rudy Hill
//ECEN 2350
//Spring 2018

module print_mode(MODE,HEX5);
	input [1:0] MODE;
	output reg [7:0] HEX5;
	reg [1:0] k;
	
	initial
	begin
		k[0] = 0;
		k[1] = 0;
	end
	
	always @(posedge MODE[0])
	begin
		k[0] = ~k[0];
	end
	
	always @(posedge MODE[1])
	begin
		k[1] = ~k[1];
	end
	
	always @*
		case(k)
			2'b00: HEX5 = 8'b10001000;
			2'b01: HEX5 = 8'b11000111;
			2'b10: HEX5 = 8'b11000110;
			2'b11: HEX5 = 8'b11000001;
		endcase
endmodule
