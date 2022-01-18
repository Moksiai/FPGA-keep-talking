module switch(
	input [7:0] swline,
	input [1:0] sw_type,
	input [2:0]color,
	input Clk, //1K Hz
	input rst,
	output reg boom,
	output reg done
);
	wire [7:0]line;
	reg [7:0] fir,sec;
	reg state;
	clsw CL1(swline,Clk,line,sw_move);
	
	initial begin
		boom <= 0;
		done <= 0;
		state <= 0;
		end
		
	always@(*)
		case(sw_type)
			2'b00:begin 
				case(color)
					3'b111:begin fir <= 8'b01001111 ; sec <= 8'b01000111; end
					3'b110:begin fir <= 8'b00011111 ; sec <= 8'b00011101; end
					3'b101:begin fir <= 8'b00101111 ; sec <= 8'b00101101; end
					3'b100:begin fir <= 8'b00001110 ; sec <= 8'b00101110; end
					3'b011:begin fir <= 8'b00001011 ; sec <= 8'b10001011; end
					3'b010:begin fir <= 8'b00000111 ; sec <= 8'b00000011; end
					3'b001:begin fir <= 8'b00101111 ; sec <= 8'b00101110; end
					3'b000:begin fir <= 8'b10001111 ; sec <= 8'b10011111; end
					endcase
				end
			2'b01:begin 
				case(color)
					3'b111:begin fir <= 8'b00001011 ;sec <= 8'b00101011; end
					3'b110:begin fir <= 8'b00001101 ;sec <= 8'b00001001; end
					3'b101:begin fir <= 8'b00011111 ;sec <= 8'b00011011; end
					3'b100:begin fir <= 8'b00001011 ;sec <= 8'b01001011; end
					3'b011:begin fir <= 8'b10001111 ;sec <= 8'b10001011; end
					3'b010:begin fir <= 8'b00000111 ;sec <= 8'b00000110; end
					3'b001:begin fir <= 8'b00101111 ;sec <= 8'b00101101; end
					3'b000:begin fir <= 8'b01001111 ;sec <= 8'b01101111; end
					endcase
				end
			2'b10:begin 
				case(color)
					3'b111:begin fir <= 8'b00000111 ;sec <= 8'b00000011; end
					3'b110:begin fir <= 8'b00101111 ;sec <= 8'b00111111; end
					3'b101:begin fir <= 8'b10001111 ;sec <= 8'b10001101; end
					3'b100:begin fir <= 8'b01001111 ;sec <= 8'b01011111; end
					3'b011:begin fir <= 8'b00001011 ;sec <= 8'b00001010; end
					3'b010:begin fir <= 8'b00001101 ;sec <= 8'b00001001; end
					3'b001:begin fir <= 8'b01001111 ;sec <= 8'b01001101; end
					3'b000:begin fir <= 8'b00001011 ;sec <= 8'b00000011; end
					endcase
				end
			2'b11:begin 
				case(color)
					3'b111:begin fir <= 8'b00011111 ;sec <= 8'b01011111; end
					3'b110:begin fir <= 8'b10001111 ;sec <= 8'b10101111; end
					3'b101:begin fir <= 8'b00101111 ;sec <= 8'b00101011; end
					3'b100:begin fir <= 8'b01001111 ;sec <= 8'b01000111; end
					3'b011:begin fir <= 8'b00001011 ;sec <= 8'b10001011; end
					3'b010:begin fir <= 8'b00011111 ;sec <= 8'b00011101; end
					3'b001:begin fir <= 8'b00001011 ;sec <= 8'b00011011; end
					3'b000:begin fir <= 8'b00001110 ;sec <= 8'b00001100; end
					endcase
				end
		endcase

		always@(posedge sw_move, posedge rst)
			if(rst) begin state <= 0; boom <= 0; done <= 0; end
			else 
				if(~state)
					if(swline == fir)state <= 1;
					else boom <= 1;
				else
					if(swline == sec)done <= 1;
					else boom <= 1;

endmodule

module clsw(
	input [7:0]swh,
	input Clk,
	output reg [7:0] cswh,
	output reg mv
);
	reg [7:0]wai;
	
	always@(posedge Clk)
		if( swh != cswh)begin
			if(wai > 200)begin cswh <= swh; mv <= 1; end
			else wai <= wai+1;
			end
		else begin wai <= 0; mv <= 0; end
endmodule