//Rudy Hill
//ECEN 2350
//Spring 2018

module MAGIC(clock, lights);
	input clock;
	output reg [9:0] lights;
	reg [3:0] state;
	initial state=4'b0000;
	integer counter;
	integer forward;
	
	
	parameter A=10'b0000000000;
	parameter B=10'b1000000000;
	parameter C=10'b1100000000;
	parameter D=10'b0110000000;
	parameter E=10'b0011000000;
	parameter F=10'b0001100000;
	parameter G=10'b0000110000;
	parameter H=10'b0000011000;
	parameter I=10'b0000001100;
	parameter J=10'b0000000110;
	parameter K=10'b0000000011;
	parameter L=10'b0000000001;
	parameter M=10'b0000000000;
	
	always@(posedge clock)
		if(counter ==650000) begin //650,000 cycles
		case(state)
			4'b0000: begin
							lights=A;
							state=4'b0001;
							forward=1;
						end
			4'b0001: begin
							lights=B;
							if (forward) state=4'b0010;
							else state=4'b0000;
						end
			4'b0010: begin
							lights=C;
							if (forward) state=4'b0011;
							else state=4'b0001;
						end
			4'b0011: begin
							lights=D;
							if (forward) state=4'b0100;
							else state=4'b0010;
						end
			4'b0100: begin
							lights=E;
							if (forward) state=4'b0101;
							else state=4'b0011;
						end
			4'b0101: begin 
							lights=F;
							if (forward) state=4'b0110;
							else state=4'b0100;
						end
			4'b0110: begin 
							lights=G;
							if (forward) state=4'b0111;
							else state=4'b0101;
						end
			4'b0111: begin 
							lights=H;
							if (forward) state=4'b1000;
							else state=4'b0110;
						end
			4'b1000: begin 
							lights=I;
							if (forward) state=4'b1001;
							else state=4'b0111;
						end
			4'b1001: begin 
							lights=J;
							if (forward) state=4'b1010;
							else state=4'b1000;
						end
			4'b1010: begin 
							lights=K;
							if (forward) state=4'b1011;
							else state=4'b1001;
						end
			4'b1011: begin 
							lights=L;
							if (forward) state=4'b1100;
							else state=4'b1010;
						end
			4'b1100: begin 
							lights=M;
							state=4'b1011;
							forward=0;
						end			
		endcase
		counter =0;
		end else begin
			counter=counter +1;
		end
			
	

endmodule 
