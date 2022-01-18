module keep_talk(
	output [7:0]led_R,led_G,led_B,
	output [3:0]led_sele,
	output [7:0]seg,
	output [3:0]seg_com,
	output [3:0]keyboard_R,
	input  [3:0]keyboard_C,
	input  [7:0]switch_in,
	input  RBB,
	output beep,
	input L_btn,R_btn,
	output [0:7] LCD_data,
	output LCD_E,LCD_rw,LCD_rs,
	input Clk,
	input iClk
);
	reg all_done;
	
   reg [27:0]seed;
	reg prepare;
	reg khz,ohz;	// 1kHz、1s Hz
	reg [14:0]khz_count;
	reg [24:0]ohz_count;
	
	reg [1:0]wrong_time;
	
	wire time_over;
	
	wire sw_reset;    //不可逆的重啟 使用變數
	assign sw_reset = (wait_count>50 && wait_count<80)?1:0;
	
	wire sw_boom, sw_done;
	
	wire [3:0] timer_num [3:0]; //timer 使用變數
	wire timer_reset,timer_enable;
	assign timer_reset =  (wait_count>50 && wait_count<100)?0:1,
			 timer_enable = (all_done || boom || ~prepare)?0:1;
	
	wire boom; 		//爆炸判定
	assign boom = prepare&&(wrong_time>2 || sw_boom || time_over);
	
	wire rick_beep; //蜂鳴器
	wire wrong_beep;
	wire corr_beep;
	wire cong_beep;
	
	wire rick_enable;
	wire wrobeep_enable;
	wire corbeep_enable;
	wire congbeep_enable;
	
	assign rick_enable = (boom)?1:0,
			 wrobeep_enable = (wbeep_count>20 && wbeep_count<30 )?0:1,
			 corbeep_enable = (cbeep_count>10),
			 congbeep_enable = (all_done);
	
	assign beep = (all_done)?cong_beep:(boom)?rick_beep:((cbeep_count<1000)?corr_beep:wrong_beep);
	
	wire [2:0] block_tip; //[自我相似的雌雄同體]模組 使用變數
	wire block_wrong;
	wire block_done;
	reg [1:0] old_wt;
	reg old_co;
	reg old_ad;
	wire block_cortip;
	
	wire corrtip;
	assign corrtip = block_cortip^sw_done;
	
	wire [2:0]color;      //[分離與喪失的未視感]模組 使用變數
	wire [2:0] draw_paper [0:3][0:3];
	wire draw_done;
	
	reg dot;
	
	reg [2:0] show[7:0][0:7]; //8x8 led矩陣
	wire led_enable;
	assign led_enable = (prepare && ~boom);

	wire [3:0] rbb_hold; //[因果律的溶解]模組
	wire cRBB;
	reg wrongRBB;
	reg test_rbb,test_block;
	
	reg [6:0] wait_count; //計時器
	reg [6:0] wbeep_count;
	reg [9:0] cbeep_count;
	reg [13:0] giveup_count;
	
	wire [7:0] a2h; //從種子計算型號(第2、3個字母)
	reg  [7:0] i2z;
	assign a2h = 8'b01000001 + seed[23:21];
	
	parameter gv = 8000;
	
	always@(*)
		case(seed[27:26])
			2'd0: i2z = "S";
			2'd1: i2z = "R";
			2'd2: i2z = "J";
			2'd3: i2z = "N";
			endcase
	
	reg [159:0] row_1, row_2, name;
	integer i,j;
	
	parameter N = 3'b111,
				 B = 3'b110,
				 G = 3'b101,
				 C = 3'b100,
				 R = 3'b011,
				 P = 3'b010,
				 Y = 3'b001,
				 W = 3'b000;
	
	switch  C0(switch_in, seed[1:0], seed[4:2], khz, sw_reset, sw_boom, sw_done);
	timer   C1(timer_num, time_over, timer_reset, timer_enable, ohz);
	player  C2(rick_beep, Clk, rick_enable);
	block   C3(seed[16:5], L_btn, R_btn, seed[17], wrong_time, khz, block_tip, block_wrong,block_done,block_cortip);
	spin    C5(color, Clk, iClk);
	draw    C6(color, keyboard_R, keyboard_C, Clk, draw_paper, {seed[1:0],seed[23:18]}, draw_done);
	segshow C7(seg, seg_com, timer_num, khz, dot);
	led8x8  C8(led_R, led_G, led_B, led_sele, show, khz, led_enable);
	clrbb   C9(RBB, khz, ohz, cRBB, rbb_hold);
	LCD2002 CA(Clk, 1'b1, LCD_rw, LCD_E, LCD_rs, LCD_data, row_1, row_2);
	player_wrong CB(wrong_beep, Clk, wrobeep_enable);
	player_correct CC(corr_beep, Clk, corbeep_enable);
	player_cong    CD(cong_beep, Clk, congbeep_enable);
	
	initial begin
		prepare <= 0;
		seed <= 28'b0010010110011010100111011101;
		sw_reset <= 0;
		old_wt <= 0;
		timer_enable <= 0;
		timer_reset <= 0;
		rick_enable <= 0;
		wrong_time <= 0;
		all_done <= 0;
		cbeep_count <= 1000;
		end
	
	always@(*) begin //計算型號
		case(seed[1:0])
			2'b00: name[159:152] = "Z";
			2'b01: name[159:152] = "X";
			2'b10: name[159:152] = "C";
			2'b11: name[159:152] = "V";
			endcase
		if(seed[18])begin name[151:144] = a2h; name[143:136] = i2z; end
		else begin name[151:144] = i2z; name[143:136] = a2h; end
		name[135:128] = 8'b00101101;
		name[127:120] = 8'b00110000 + (seed[11:8]%10);
		name[119:112] = 8'b00110000 + (seed[18:15]%10);
		case(seed[20:18])
			3'd0: name[111:96] = "40";
			3'd1: name[111:96] = "17";
			3'd2: name[111:96] = "58";
			3'd3: name[111:96] = "11";
			3'd4: name[111:96] = "36";
			3'd5: name[111:96] = "69";
			3'd6: name[111:96] = "30";
			3'd7: name[111:96] = "55";
			endcase
		
		case({seed[7],seed[24],seed[3]})
			3'd0: name[95:0] = "NYKD54      ";
			3'd1: name[95:0] = "228922      ";
			3'd2: name[95:0] = "HC6uQ0      ";
			3'd3: name[95:0] = "steins      ";
			3'd4: name[95:0] = "HaYakU      ";
			3'd5: name[95:0] = "rICk37      ";
			3'd6: name[95:0] = "si2fdg      ";
			3'd7: name[95:0] = "h5nk42      ";
			endcase
		
		end
	
	always @(posedge Clk) //LCD顯示
		if(~prepare) begin
			row_1 = "   Cheak SW all on  ";
			row_2 = " and push S1 button ";
			end
		else 
			if(all_done)begin
				if(giveup_count < gv)begin
					row_1 = " Congratulations!!  ";
					row_2 = "    I give you up   ";
					end
				else begin
					row_1 = " Just kidding,      ";
					row_2 = "NEVER GONNAGIVE U UP";
					end
				end
			else if(boom)begin
				row_1 = " Never gonna        ";
				row_2 = "       give you up  ";
				end
			else begin
					row_1 = name;
					case(wrong_time)
						2'b00: row_2 = "you have ZERO error.";
						2'b01: row_2 = {" 1 error ",32'b10111001101010001011000010110110,"       "};
						2'b10: row_2 = {" 2 error ",32'b10111001101010001011000010110110," HEHEHE"};
						2'b11: row_2 = {" the WHAT.          "};
					endcase
				end
			
	
	always @(posedge Clk) //1K hz 除頻器
		if(khz_count > 25000)begin khz <= ~khz; khz_count <= 0; end
		else khz_count <= khz_count +1;
	
	always @(posedge Clk) // 1 hz 除頻器
		if(ohz_count > 25000000)begin ohz <= ~ohz; ohz_count <= 0; end
		else ohz_count <= ohz_count +1;
	
	always @(posedge ohz) //控制冒號閃爍
		if(seed[17])dot <= ~dot;
		else dot <= 0;
	
	always @(posedge Clk)  //計算錯誤次數
		if(prepare == 0)begin
			wrong_time =0;
			test_block = block_wrong;
			test_rbb   = wrongRBB;
			end
		else
			if(wrong_time < 3)begin
				if(test_block != block_wrong)begin wrong_time = wrong_time+1; test_block = block_wrong; end
				if(test_rbb != wrongRBB)     begin wrong_time = wrong_time+1; test_rbb   = wrongRBB   ; end
				end
	
	always@(posedge khz) //等待100ms 後再進入拆彈
		if(~prepare)wait_count <= 0;
		else if(wait_count < 100)wait_count <= wait_count+1;
	
	always@(posedge khz) //重置錯誤音效
		if(wbeep_count < 100)wbeep_count <= wbeep_count +1;
		else 
			if(old_wt != wrong_time)begin old_wt <= wrong_time; wbeep_count <= 0; end
	
	always@(posedge khz) //重置正確音效
		if(cbeep_count < 1000)cbeep_count <= cbeep_count +1;
		else 
			if(old_co != corrtip)begin old_co <= corrtip; cbeep_count <= 0; end
			
	always@(posedge khz) //違反誠實信用原則
		if(giveup_count < gv)giveup_count <= giveup_count +1;
		else 
			if(old_ad != all_done)begin old_ad <= all_done; giveup_count <= 0; end
	
	always@(posedge Clk)
		if(~prepare) 
			for(i=0;i<8;i=i+1)
				for(j=0;j<8;j=j+1)
					show[i][j] <= 3'b111;
		else if(all_done)begin
			{show[0][0],show[1][0],show[2][0],show[3][0],show[4][0],show[5][0],show[6][0],show[7][0]} <= {R,R,R,R,R,R,R,R};
			{show[0][1],show[1][1],show[2][1],show[3][1],show[4][1],show[5][1],show[6][1],show[7][1]} <= {R,G,G,R,R,R,R,R};
			{show[0][2],show[1][2],show[2][2],show[3][2],show[4][2],show[5][2],show[6][2],show[7][2]} <= {G,G,G,G,R,R,R,R};
			{show[0][3],show[1][3],show[2][3],show[3][3],show[4][3],show[5][3],show[6][3],show[7][3]} <= {R,G,G,R,R,Y,Y,Y};
			{show[0][4],show[1][4],show[2][4],show[3][4],show[4][4],show[5][4],show[6][4],show[7][4]} <= {R,G,G,R,R,Y,Y,Y};
			{show[0][5],show[1][5],show[2][5],show[3][5],show[4][5],show[5][5],show[6][5],show[7][5]} <= {R,G,G,R,R,Y,Y,Y};
			{show[0][6],show[1][6],show[2][6],show[3][6],show[4][6],show[5][6],show[6][6],show[7][6]} <= {R,R,R,R,R,R,R,R};
			{show[0][7],show[1][7],show[2][7],show[3][7],show[4][7],show[5][7],show[6][7],show[7][7]} <= {R,R,R,R,R,R,R,R};
			end
		else begin
			
			//以下顯示分離與喪失的未視感的著色畫面
			for(i=0;i<4;i=i+1) 
				for(j=0;j<4;j=j+1)
					show[i][j] <= draw_paper[i][j];
			
			show[0][7]<={sw_done,draw_done,block_done};
		   //以下顯示旋鈕產生之顏色
			show[1][5]<= color;
			show[1][6]<= color;
			show[2][5]<= color;
			show[2][6]<= color;
					
			//以下顯示自我相似的雌雄同體之提示
			show[5][1]<= block_tip;
			show[5][2]<= block_tip;
			show[6][1]<= block_tip;
			show[6][2]<= block_tip;
					
			//以下顯示不可逆的重啟之提示
			if(seed[1:0] == 2'b00)begin 
				show[4][4] <= seed[4:2]; 
				show[4][5] <= seed[4:2];  
				show[5][4] <= seed[4:2];  
				show[5][5] <= seed[4:2]; 
				end
			else begin
				show[4][4] <= seed[19:17];
				show[4][5] <= seed[19:17];
				show[5][4] <= seed[19:17];
				show[5][5] <= seed[19:17];
				end
				
			if(seed[1:0] == 2'b01)begin 
				show[6][4] <= seed[4:2]; 
				show[6][5] <= seed[4:2];  
				show[7][4] <= seed[4:2];  
				show[7][5] <= seed[4:2]; 
				end
			else begin
				show[6][4] <= seed[16:14];
				show[6][5] <= seed[16:14];
				show[7][4] <= seed[16:14];
				show[7][5] <= seed[16:14];
				end
				
			if(seed[1:0] == 2'b10)begin 
				show[4][6] <= seed[4:2]; 
				show[4][7] <= seed[4:2];  
				show[5][6] <= seed[4:2];  
				show[5][7] <= seed[4:2]; 
				end
			else begin
				show[4][6] <= seed[23:21];
				show[4][7] <= seed[23:21];
				show[5][6] <= seed[23:21];
				show[5][7] <= seed[23:21];
				end
				
			if(seed[1:0] == 2'b11)begin 
				show[6][6] <= seed[4:2]; 
				show[6][7] <= seed[4:2];  
				show[7][6] <= seed[4:2];  
				show[7][7] <= seed[4:2]; 
				end
			else begin
				show[6][6] <= seed[17:15];
				show[6][7] <= seed[17:15];
				show[7][6] <= seed[17:15];
				show[7][7] <= seed[17:15];
				end
		end
		
	always@(negedge cRBB) //[因果律的溶解]模組
		if(~prepare && switch_in == 8'b00001111)begin
				all_done <= 0;
				prepare <=1;
				end
		else begin
			if((sw_done)&&(draw_done)&&(block_done))
				case(seed[27:26])
					2'b00: if((timer_num[0]==5)||(timer_num[1]==5)||(timer_num[2]==5)||(timer_num[3]==5)) all_done<=1; else wrongRBB <= ~wrongRBB;
					2'b01: if((timer_num[0]==9)||(timer_num[1]==9)||(timer_num[2]==9)||(timer_num[3]==9)) all_done<=1; else wrongRBB <= ~wrongRBB;
					2'b10: if (rbb_hold>=2) all_done <=1; else wrongRBB <= ~wrongRBB;
					2'b11: if (rbb_hold<2) all_done <=1; else wrongRBB <= ~wrongRBB;
					endcase
			else wrongRBB <= ~wrongRBB;
			end
	always@(posedge Clk) //生成seed
		if(~prepare) begin
			seed[0] <= seed[6] ^ seed[1];
			seed[1] <= seed[0] ^ seed[11];
			seed[2] <= seed[6] ^ seed[18];
			seed[3] <= seed[12];
			seed[4] <= seed[1];
			seed[5] <= seed[13] ^ seed[1];
			seed[6] <= seed[13];
			seed[7] <= seed[2];
			seed[8] <= seed[5];
			seed[9] <= seed[12] ^ seed[11];
			seed[10] <= seed[26] ^ seed[14];
			seed[11] <= seed[23] ^ seed[7];
			seed[12] <= seed[22];
			seed[13] <= seed[9] ^ seed[25];
			seed[14] <= seed[16] ^ seed[27];
			seed[15] <= seed[23] ^ seed[17];
			seed[16] <= seed[23] ^ seed[16];
			seed[17] <= seed[14] ^ seed[10];
			seed[18] <= seed[3];
			seed[19] <= seed[1] ^ seed[11];
			seed[20] <= seed[4] ^ seed[8];
			seed[21] <= seed[26] ^ seed[0];
			seed[22] <= seed[0] ^ seed[19];
			seed[23] <= seed[1] ^ seed[18];
			seed[24] <= seed[3];
			seed[25] <= seed[20] ^ seed[9];
			seed[26] <= seed[7];
			seed[27] <= seed[17] ^ seed[3]; 
			end

endmodule

module clrbb(
	input ibtn,
	input khz,ohz,
	output cbtn,
	output [3:0] push_sec
);
	reg [8:0]scount;
	reg [3:0]hold;
	
	always@(posedge khz)
		if(ibtn != cbtn) 
			if(scount > 100)cbtn <= ibtn;
			else scount <= scount +1;
		else
			scount <= 0;
			
	always@(posedge ohz)
		if(cbtn)hold <= hold +1;
		else hold <= 0;
	
	always@(negedge cbtn)
		push_sec <= hold;
	
endmodule