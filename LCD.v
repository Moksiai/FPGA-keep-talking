module LCD2002(
	input CLK,
	input _RST,
	output reg rw,
	output LCD_E ,
	output reg LCD_RS,
	output reg[7:0]LCD_DATA,
	input [159:0]row_1,row_2
);

initial begin 
	rw = 0;
end
parameter TIME_20MS=1_000_000;//需要20ms以達上電穩定(初始化)
reg[19:0]cnt_20ms;
always@(posedge CLK or negedge _RST)
    if(!_RST)
        cnt_20ms<=1'b0;
    else if(cnt_20ms==TIME_20MS-1'b1)
        cnt_20ms<=cnt_20ms;
    else
        cnt_20ms<=cnt_20ms+1'b1 ;

wire delay_done=(cnt_20ms==TIME_20MS-1'b1)?1'b1:1'b0;//上電延時完畢
parameter TIME_500HZ=100_000;//工作週期
reg[19:0]cnt_500hz;
always@(posedge CLK or negedge _RST)
    if(!_RST)
        cnt_500hz<=1'b0;
    else if(delay_done)begin
        if(cnt_500hz==TIME_500HZ-1'b1)
            cnt_500hz<=1'b0;
        else
            cnt_500hz<=cnt_500hz+1'b1;
			end
    else
        cnt_500hz<=1'b0;

assign LCD_E=(cnt_500hz>(TIME_500HZ-1'b1)/2)?1'b0:1'b1;//使能端,每個工作週期一次下降沿,執行一次命令
wire write_flag=(cnt_500hz==TIME_500HZ-1'b1)?1'b1:1'b0;//每到一個工作週期,write_flag置高一週期
parameter IDLE=8'h00;
parameter SET_FUNCTION=8'h01;
parameter DISP_OFF=8'h02;
parameter DISP_CLEAR=8'h03;
parameter ENTRY_MODE=8'h04;
parameter DISP_ON=8'h05;
parameter ROW1_ADDR=8'h06;
parameter ROW1_0=8'h07;
parameter ROW1_1=8'h08;
parameter ROW1_2=8'h09;
parameter ROW1_3=8'h0A;
parameter ROW1_4=8'h0B;
parameter ROW1_5=8'h0C;
parameter ROW1_6=8'h0D;
parameter ROW1_7=8'h0E;
parameter ROW1_8=8'h0F;
parameter ROW1_9=8'h10;
parameter ROW1_A=8'h11;
parameter ROW1_B=8'h12;
parameter ROW1_C=8'h13;
parameter ROW1_D=8'h14;
parameter ROW1_E=8'h15;
parameter ROW1_F=8'h16;
parameter ROW1_10=8'h17;
parameter ROW1_11=8'h18;
parameter ROW1_12=8'h19;
parameter ROW1_13=8'h1A;
parameter ROW2_ADDR=8'h1B;
parameter ROW2_0=8'h1C;
parameter ROW2_1=8'h1D;
parameter ROW2_2=8'h1E;
parameter ROW2_3=8'h1F;
parameter ROW2_4=8'h20;
parameter ROW2_5=8'h21;
parameter ROW2_6=8'h22;
parameter ROW2_7=8'h23;
parameter ROW2_8=8'h24;
parameter ROW2_9=8'h25;
parameter ROW2_A=8'h26;
parameter ROW2_B=8'h27;
parameter ROW2_C=8'h28;
parameter ROW2_D=8'h29;
parameter ROW2_E=8'h2A;
parameter ROW2_F=8'h2B;
parameter ROW2_10=8'h2C;
parameter ROW2_11=8'h2D;
parameter ROW2_12=8'h2E;
parameter ROW2_13=8'h2F;

reg[5:0]c_state;//Current state,當前狀態
reg[5:0]n_state;//Next state,下一狀態

always@(posedge CLK or negedge _RST)
    if(!_RST)
        c_state<=IDLE;
    else if(write_flag)//每一個工作週期改變一次狀態
        c_state<=n_state;
    else
        c_state<=c_state;

always@(*)
    case (c_state)
        IDLE:n_state=SET_FUNCTION;
        SET_FUNCTION:n_state=DISP_OFF;
        DISP_OFF:n_state=DISP_CLEAR;
        DISP_CLEAR:n_state=ENTRY_MODE;
        ENTRY_MODE:n_state=DISP_ON;
        DISP_ON:n_state=ROW1_ADDR;
        ROW1_ADDR:n_state=ROW1_0;
        ROW1_0:n_state=ROW1_1;
        ROW1_1:n_state=ROW1_2;
        ROW1_2:n_state=ROW1_3;
        ROW1_3:n_state=ROW1_4;
        ROW1_4:n_state=ROW1_5;
        ROW1_5:n_state=ROW1_6;
        ROW1_6:n_state=ROW1_7;
        ROW1_7:n_state=ROW1_8;
        ROW1_8:n_state=ROW1_9;
        ROW1_9:n_state=ROW1_A;
        ROW1_A:n_state=ROW1_B;
        ROW1_B:n_state=ROW1_C;
        ROW1_C:n_state=ROW1_D;
        ROW1_D:n_state=ROW1_E;
        ROW1_E:n_state=ROW1_F;
        ROW1_F:n_state=ROW1_10;
		  ROW1_10:n_state=ROW1_11;
		  ROW1_11:n_state=ROW1_12;
		  ROW1_12:n_state=ROW1_13;
		  ROW1_13:n_state=ROW2_ADDR;	
        ROW2_ADDR:n_state=ROW2_0;
        ROW2_0:n_state=ROW2_1;
        ROW2_1:n_state=ROW2_2;
        ROW2_2:n_state=ROW2_3;
        ROW2_3:n_state=ROW2_4;
        ROW2_4:n_state=ROW2_5;
        ROW2_5:n_state=ROW2_6;
        ROW2_6:n_state=ROW2_7;
        ROW2_7:n_state=ROW2_8;
        ROW2_8:n_state=ROW2_9;
        ROW2_9:n_state=ROW2_A;
        ROW2_A:n_state=ROW2_B;
        ROW2_B:n_state=ROW2_C;
        ROW2_C:n_state=ROW2_D;
        ROW2_D:n_state=ROW2_E;
        ROW2_E:n_state=ROW2_F;
        ROW2_F:n_state=ROW2_10;
		  ROW2_10:n_state=ROW2_11;
		  ROW2_11:n_state=ROW2_12;
		  ROW2_12:n_state=ROW2_13;
		  ROW2_13:n_state=ROW1_ADDR;	//迴圈到1-1進行掃描顯示
        default:;
    endcase

always@(posedge CLK or negedge _RST)
    if(!_RST)
        LCD_RS<=1'b0;//為0時輸入指令,為1時輸入資料
    else if(write_flag)
        //當狀態為七個指令任意一個,將RS置為指令輸入狀態
        if((n_state==SET_FUNCTION)||(n_state==DISP_OFF)||(n_state==DISP_CLEAR)||(n_state==ENTRY_MODE)||(n_state==DISP_ON)||(n_state==ROW1_ADDR)||(n_state==ROW2_ADDR))
            LCD_RS<=1'b0; 
        else
            LCD_RS<=1'b1;
    else
        LCD_RS<=LCD_RS;

always@(posedge CLK or negedge _RST)
    if(!_RST)
        LCD_DATA<=1'b0;
    else if(write_flag)
        case(n_state)
            IDLE:LCD_DATA<=8'hxx;
            SET_FUNCTION:LCD_DATA<=8'h38;//8'b0011_1000,工作方式設定:DL=1(DB4,8位資料介面),N=1(DB3,兩行顯示),L=0(DB2,5x8點陣顯示).
            DISP_OFF:LCD_DATA<=8'h08;//8'b0000_1000,顯示開關設定:D=0(DB2,顯示關),C=0(DB1,游標不顯示),D=0(DB0,游標不閃爍)
            DISP_CLEAR:LCD_DATA<=8'h01;//8'b0000_0001,清屏
            ENTRY_MODE:LCD_DATA<=8'h06;//8'b0000_0110,進入模式設定:I/D=1(DB1,寫入新資料游標右移),S=0(DB0,顯示不移動)
            DISP_ON:LCD_DATA<=8'h0c;//8'b0000_1100,顯示開關設定:D=1(DB2,顯示開),C=0(DB1,游標不顯示),D=0(DB0,游標不閃爍)
            ROW1_ADDR:LCD_DATA<=8'h80;//8'b1000_0000,設定DDRAM地址:00H->1-1,第一行第一位
            //將輸入的row_1以每8-bit拆分,分配給對應的顯示位
            ROW1_0:LCD_DATA<=row_1[ 159: 152];
            ROW1_1:LCD_DATA<=row_1[ 151: 144];
            ROW1_2:LCD_DATA<=row_1[ 143: 136];
            ROW1_3:LCD_DATA<=row_1[ 135: 128];
            ROW1_4:LCD_DATA<=row_1[ 127: 120];
            ROW1_5:LCD_DATA<=row_1[ 119: 112];
            ROW1_6:LCD_DATA<=row_1[ 111: 104];
            ROW1_7:LCD_DATA<=row_1[ 103: 96];
            ROW1_8:LCD_DATA<=row_1[ 95: 88];
            ROW1_9:LCD_DATA<=row_1[ 87: 80];
            ROW1_A:LCD_DATA<=row_1[ 79: 72];
            ROW1_B:LCD_DATA<=row_1[ 71: 64];
            ROW1_C:LCD_DATA<=row_1[ 63: 56];
            ROW1_D:LCD_DATA<=row_1[ 55: 48];
            ROW1_E:LCD_DATA<=row_1[ 47:  40];
            ROW1_F:LCD_DATA<=row_1[  39:  32];
            ROW1_10:LCD_DATA<=row_1[  31:  24];
				ROW1_11:LCD_DATA<=row_1[  23:  16];
				ROW1_12:LCD_DATA<=row_1[  15:  8];
				ROW1_13:LCD_DATA<=row_1[  7:  0];
				ROW2_ADDR:LCD_DATA<=8'hc0;//8'b1100_0000,設定DDRAM地址:40H->2-1,第二行第一位
				ROW2_0:LCD_DATA<=row_2[ 159: 152];
            ROW2_1:LCD_DATA<=row_2[ 151: 144];
            ROW2_2:LCD_DATA<=row_2[ 143: 136];
            ROW2_3:LCD_DATA<=row_2[ 135: 128];
            ROW2_4:LCD_DATA<=row_2[ 127: 120];
            ROW2_5:LCD_DATA<=row_2[ 119: 112];
            ROW2_6:LCD_DATA<=row_2[ 111: 104];
            ROW2_7:LCD_DATA<=row_2[ 103: 96];
            ROW2_8:LCD_DATA<=row_2[ 95: 88];
            ROW2_9:LCD_DATA<=row_2[ 87: 80];
            ROW2_A:LCD_DATA<=row_2[ 79: 72];
            ROW2_B:LCD_DATA<=row_2[ 71: 64];
            ROW2_C:LCD_DATA<=row_2[ 63: 56];
            ROW2_D:LCD_DATA<=row_2[ 55: 48];
            ROW2_E:LCD_DATA<=row_2[ 47:  40];
            ROW2_F:LCD_DATA<=row_2[  39:  32];
            ROW2_10:LCD_DATA<=row_2[  31:  24];
				ROW2_11:LCD_DATA<=row_2[  23:  16];
				ROW2_12:LCD_DATA<=row_2[  15:  8];
				ROW2_13:LCD_DATA<=row_2[  7:  0];
        endcase
    else
        LCD_DATA<=LCD_DATA;
endmodule