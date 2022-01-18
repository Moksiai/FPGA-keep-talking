module draw(
	input [2:0]color,
	output [3:0]R,
	input [3:0]C,
	input Clk,
	output reg [2:0] paper [0:3][0:3],
	input [7:0]seed,
	output reg correct
);
	wire [3:0]btn;
	wire [2:0]color1,color2;
	wire [47:0]za;
	wire [47:0]answer;
	reg [3:0] shapeg[3:0];
	//wire [47:0]answer;
	assign color1 = seed[5:3],
			 color2 = seed[2:0];
			 
	assign answer[47:45] = (shapeg[3][3])?color1:color2;
	assign answer[44:42] = (shapeg[3][2])?color1:color2;
	assign answer[41:39] = (shapeg[3][1])?color1:color2;
	assign answer[38:36] = (shapeg[3][0])?color1:color2;
	assign answer[35:33] = (shapeg[2][3])?color1:color2;
	assign answer[32:30] = (shapeg[2][2])?color1:color2;
	assign answer[29:27] = (shapeg[2][1])?color1:color2;
	assign answer[26:24] = (shapeg[2][0])?color1:color2;
	assign answer[23:21] = (shapeg[1][3])?color1:color2;
	assign answer[20:18] = (shapeg[1][2])?color1:color2;
	assign answer[17:15] = (shapeg[1][1])?color1:color2;
	assign answer[14:12] = (shapeg[1][0])?color1:color2;
	assign answer[11:9] = (shapeg[0][3])?color1:color2; 
	assign answer[8:6] = (shapeg[0][2])?color1:color2;  
	assign answer[5:3] = (shapeg[0][1])?color1:color2;  
	assign answer[2:0] = (shapeg[0][0])?color1:color2;  
	assign za = answer-{paper[0][0],paper[0][1],paper[0][2],paper[0][3],paper[1][0],paper[1][1],paper[1][2],paper[1][3],paper[2][0],paper[2][1],paper[2][2],paper[2][3],paper[3][0],paper[3][1],paper[3][2],paper[3][3]};
	
	kb K(btn,R,touch,C,Clk);
	
	parameter logic [3:0] sqar [3:0] = '{
		4'b0000,
		4'b0110,
		4'b0110,
		4'b0000};
	parameter logic [3:0] cookie [3:0] = '{
		4'b0011,
		4'b0011,
		4'b1100,
		4'b1100};
	parameter logic [3:0] cros [3:0] = '{
		4'b0110,
		4'b1001,
		4'b1001,
		4'b0110};
	parameter logic [3:0] line [3:0] = '{
		4'b1100,
		4'b1110,
		4'b0111,
		4'b0011};
	
	always@(za)
		if(za==0)correct<=1'b1;
		else correct<=1'b0;
	
	always@(posedge Clk)
		case(seed[7:6])
			2'b00: shapeg <= sqar;
			2'b01: shapeg <= cookie;
			2'b10: shapeg <= cros;
			2'b11: shapeg <= line;
			endcase
	
	always@(posedge touch)
		case(btn)
			4'b0000: paper[0][0] <= color;
			4'b0001: paper[1][0] <= color;
			4'b0010: paper[2][0] <= color;
			4'b0011: paper[3][0] <= color;
			4'b0100: paper[0][1] <= color;
			4'b0101: paper[1][1] <= color;
			4'b0110: paper[2][1] <= color;
			4'b0111: paper[3][1] <= color;
			4'b1000: paper[0][2] <= color;
			4'b1001: paper[1][2] <= color;
			4'b1010: paper[2][2] <= color;
			4'b1011: paper[3][2] <= color;
			4'b1100: paper[0][3] <= color;
			4'b1101: paper[1][3] <= color;
			4'b1110: paper[2][3] <= color;
			4'b1111: paper[3][3] <= color;
			endcase
	
endmodule

module kb(
	output reg [3:0]btn,
	output reg [3:0] R,
	output reg touch,
	input [3:0] C,
	input Clk
);
	reg [1:0] state;
	reg divclk;
	reg [15:0] dcnt;
	
	//initial state <= 2'b11;
	
	always@(posedge Clk)
		if(dcnt > 50000)begin
			divclk <= !divclk;
			dcnt <= 0;
		end
		else
			dcnt <= dcnt +1;
	
	always@(posedge divclk)
		state <= state +1;
	
	always@(posedge divclk)
		case(state)
			2'b00:begin 
				R <= 4'b1011; 
				case(C)
					4'b0111: begin btn <= 4'd0; touch<=1; end
					4'b1011: begin btn <= 4'd1; touch<=1; end
					4'b1101: begin btn <= 4'd2; touch<=1; end
					4'b1110: begin btn <= 4'd3; touch<=1; end
					default touch <= 0;
				endcase
				end
		   2'b01:begin 
				R <= 4'b1101; 
				case(C)
					4'b0111: begin btn <= 4'd4; touch<=1; end
					4'b1011: begin btn <= 4'd5; touch<=1; end
					4'b1101: begin btn <= 4'd6; touch<=1; end
					4'b1110: begin btn <= 4'd7; touch<=1; end
					default touch <= 0;
				endcase
				end
			2'b10:begin 
				R <= 4'b1110; 
				case(C)
					4'b0111: begin btn <= 4'd8; touch<=1; end
					4'b1011: begin btn <= 4'd9; touch<=1; end
					4'b1101: begin btn <= 4'd10; touch<=1; end
					4'b1110: begin btn <= 4'd11; touch<=1; end
					default touch <= 0;
				endcase
				end
			2'b11:begin 
				R <= 4'b0111; 
				case(C)
					4'b0111: begin btn <= 4'd12;  touch<=1; end
					4'b1011: begin btn <= 4'd13;  touch<=1; end
					4'b1101: begin btn <= 4'd14;  touch<=1; end
					4'b1110: begin btn <= 4'd15;  touch<=1; end
					default touch <= 0;
				endcase
				end
		endcase
		
endmodule