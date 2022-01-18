module block(
	input [11:0] oseed,
	input L_btn,R_btn,mod,
	input [1:0] wrong_time,
	input Clk,                //1KHz
	output reg [2:0] show,
	output reg wrong,
	output done,
	output reg corrtip
	//output [0:5]spo,
	//output [2:0]cort
);

	wire [1:0] seed[0:5];
		assign seed[0] = oseed[11:10],
				 seed[1] = oseed[9:8],
			 	 seed[2] = oseed[7:6],
			  	 seed[3] = oseed[5:4],
				 seed[4] = oseed[3:2],
				 seed[5] = oseed[1:0];
	reg [1:0]level;
	reg [2:0]color[3:0]; 
	reg [1:0]showstate;    //目前展示的顏色位址
	reg [2:0]showlist[0:3]; //循環展示的顏色列表
	reg [9:0]clkcnt;
	reg [0:5]answer;
	reg [2:0]correct;
	reg enable;
	reg spclk;
	wire nclk;
	assign nclk = ~spclk;
	//assign spo = answer;
	//assign cort = correct;
	assign done = (level==3)?1:0;
	
	cllr C3({L_btn,R_btn},Clk, click);
	parameter 
		RED = 3'b011,
		BLUE= 3'b110,
		GREN= 3'b101,
		YELW= 3'b001,
		DARK= 3'b111;
	parameter logic [0:3]cas2[0:2] ='{
		4'b0101,
		4'b1100,
		4'b1011};
	parameter logic [0:3]cas1[0:2] ='{
		4'b1010,
		4'b0110,
		4'b0010};
	
	initial begin
		enable <= 1;
		correct <= 0;
		level <= 0;
		{color[3],color[2],color[1],color[0]} <= 12'b001101110011;
		end
		
	always @(posedge Clk) //Level 
		case(level)
			2'b00: if(correct == 1)begin level <= 1; corrtip <= ~corrtip; end
			2'b01: if(correct == 3)begin level <= 2; corrtip <= ~corrtip; end
			2'b10: if(correct == 6)begin level <= 3; enable <=0 ; corrtip <= ~corrtip; end
			endcase
		
		
	always@(posedge click)
		if(R_btn)
			if(answer[correct]==1'b1)begin 
				correct <= correct+1; 
				end
			else begin 
				wrong <= ~wrong;
				case(level)
					2'b00:correct <= 0;
					2'b01:correct <= 1;
					2'b10:correct <= 3;
					endcase
				end
		else if (L_btn)
			if(answer[correct]==1'b0)begin 
				correct<= correct+1; 
				end
			else begin 
				wrong <= ~wrong; 
				case(level)
					2'b00:correct <= 0;
					2'b01:correct <= 1;
					2'b10:correct <= 3;
					endcase
				end
	
	always@(posedge Clk) //產生特殊Clk
		if(spclk)begin  //顯示顏色時
			if(clkcnt > 200)begin
				clkcnt <= 0;
				spclk <= 0;
				end
			else clkcnt <= clkcnt+1;
			end
		else begin
			if(clkcnt > 1000)begin
				clkcnt <= 0;
				spclk <= 1;
				end
			else clkcnt <= clkcnt+1;
			end
	
	always@(posedge Clk)begin  //更新展示列表、答案
		case(level)
			2'b00: {showlist[0],showlist[1],showlist[2],showlist[3]} <= {color[seed[0]],DARK,DARK,DARK};
			2'b01: {showlist[0],showlist[1],showlist[2],showlist[3]} <= {color[seed[1]],color[seed[2]],DARK,DARK};
			2'b10: {showlist[0],showlist[1],showlist[2],showlist[3]} <= {color[seed[3]],color[seed[4]],color[seed[5]],DARK};
			2'b11: {showlist[0],showlist[1],showlist[2],showlist[3]} <= {DARK,DARK,DARK,DARK};
		endcase
		if(mod)
			answer <= {cas2[wrong_time][seed[0]],cas2[wrong_time][seed[1]],cas2[wrong_time][seed[2]],cas2[wrong_time][seed[3]],cas2[wrong_time][seed[4]],cas2[wrong_time][seed[5]]};
		else
			answer <= {cas1[wrong_time][seed[0]],cas1[wrong_time][seed[1]],cas1[wrong_time][seed[2]],cas1[wrong_time][seed[3]],cas1[wrong_time][seed[4]],cas1[wrong_time][seed[5]]};
		end
	
	always@(negedge spclk)  //循環展示(更新狀態)
		case(level)
			2'b00:
				if(showstate > 0)showstate <= 0;
				else showstate <= showstate+1;
			2'b01:
				if(showstate > 1)showstate <= 0;
				else showstate <= showstate+1;
			2'b10:
				if(showstate > 2)showstate <= 0;
				else showstate <= showstate+1;
			default:
				if(showstate > 0)showstate <= 0;
				else showstate <= showstate+1;
		endcase
	
	always@(posedge spclk or posedge nclk) //將顏色output出去
		if(nclk)
			show <= showlist[showstate];
		else
			show <= DARK;
			
endmodule
	
	

module cllr(
	input [1:0]lr,
	input Clk,
	output reg mv
);
	reg [7:0]wai;
	reg [1:0]temp;
	
	always@(posedge Clk)
		if( lr != temp)begin
			if(wai > 200)begin temp <= lr; mv <= 1; end
			else wai <= wai+1;
			end
		else begin wai <= 0; mv <= 0; end
endmodule