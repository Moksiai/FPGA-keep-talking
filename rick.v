module player(
	output reg beep,
	input Clk,enable
);
	reg [16:0] count,tone; //beep 的計數器、頻率
	reg clk_khz; 				  //ms Clk
	reg [14:0]kcnt;           //ms counter
	reg beep_enable;           
	reg [8:0] now;          //樂譜演奏進度
	reg [12:0] lengh,beeplengh;  //控制beep的長度
	parameter 
		all = 9'd339, //樂譜長度
		NOTE_B0  = 17'hc4e33,
		NOTE_C1  = 17'hb8f47,
		NOTE_CS1 = 17'hae62d,
		NOTE_D1  = 17'ha4f5b,
		NOTE_DS1 = 17'h9c801,
		NOTE_E1  = 17'h94ddc,
		NOTE_F1  = 17'h8ab75,
		NOTE_FS1 = 17'h84af6,
		NOTE_G1  = 17'h7c8fc,
		NOTE_GS1 = 17'h75601,
		NOTE_A1  = 17'h6ef91,
		NOTE_AS1 = 17'h693ba,
		NOTE_B1  = 17'h62719,
		NOTE_C2  = 17'h5de67,
		NOTE_CS2 = 17'h5874e,
		NOTE_D2  = 17'h539c1,
		NOTE_DS2 = 17'h4e400,
		NOTE_E2  = 17'h4a6ee,
		NOTE_F2  = 17'h4627c,
		NOTE_FS2 = 17'h41a11,
		NOTE_G2  = 17'h3e47e,
		NOTE_GS2 = 17'h3ab00,
		NOTE_A2  = 17'h377c8,
		NOTE_AS2 = 17'h342ab,
		NOTE_B2  = 17'h319f4,
		NOTE_C3  = 17'h2e977,
		NOTE_CS3 = 17'h2be90,
		NOTE_D3  = 17'h29854,
		NOTE_DS3 = 17'h27200,
		NOTE_E3  = 17'h24fdb,
		NOTE_F3  = 17'h22e09,
		NOTE_FS3 = 17'h20fdf,
		NOTE_G3  = 17'h1f23f,
		NOTE_GS3 = 17'h1d580,
		NOTE_A3  = 17'h1bbe4,
		NOTE_AS3 = 17'h1a320,
		NOTE_B3  = 17'h18b5e,
		NOTE_C4  = 17'h174bb,
		NOTE_CS4 = 17'h1608c,
		NOTE_D4  = 17'h14c2a,
		NOTE_DS4 = 17'h13a01,
		NOTE_E4  = 17'h127ed,
		NOTE_F4  = 17'h117d1,
		NOTE_FS4 = 17'h107ef,
		NOTE_G4  = 17'hf91f,
		NOTE_GS4 = 17'heb50,
		NOTE_A4  = 17'hddf2,
		NOTE_AS4 = 17'hd190,
		NOTE_B4  = 17'hc5af,
		NOTE_C5  = 17'hbab9,
		NOTE_CS5 = 17'hb046,
		NOTE_D5  = 17'ha65d,
		NOTE_DS5 = 17'h9d00,
		NOTE_E5  = 17'h9430,
		NOTE_F5  = 17'h8be8,
		NOTE_FS5 = 17'h83f7,
		NOTE_G5  = 17'h7c8f,
		NOTE_GS5 = 17'h7584,
		NOTE_A5  = 17'h6ef9,
		NOTE_AS5 = 17'h68c8,
		NOTE_B5  = 17'h62d7,
		NOTE_C6  = 17'h5d45,
		NOTE_CS6 = 17'h580e,
		NOTE_D6  = 17'h531c,
		NOTE_DS6 = 17'h4e70,
		NOTE_E6  = 17'h4a09,
		NOTE_F6  = 17'h45e7,
		NOTE_FS6 = 17'h41fb,
		NOTE_G6  = 17'h3e47,
		NOTE_GS6 = 17'h3acb,
		NOTE_A6  = 17'h377c,
		NOTE_AS6 = 17'h345c,
		NOTE_B6  = 17'h316b,
		NOTE_C7  = 17'h2ea8,
		NOTE_CS7 = 17'h2c0c,
		NOTE_D7  = 17'h2992,
		NOTE_DS7 = 17'h273c,
		NOTE_E7  = 17'h2508,
		NOTE_F7  = 17'h22f3,
		NOTE_FS7 = 17'h20fd,
		NOTE_G7  = 17'h1f23,
		NOTE_GS7 = 17'h1d65,
		NOTE_A7  = 17'h1bbe,
		NOTE_AS7 = 17'h1a30,
		NOTE_B7  = 17'h18b7,
		NOTE_C8  = 17'h1754,
		NOTE_CS8 = 17'h1604,
		NOTE_D8  = 17'h14c8,
		NOTE_DS8 = 17'h139e,
		REST     = 17'h0,
		l2  = 13'd960,
		l4  = 13'd480,
		l4d = 13'd720,
		l8  = 13'd240,
		l8d = 13'd360,
		l16 = 13'd120,
		l16d= 13'd180;
	
	initial begin
		tone <= NOTE_D5;
		beep_enable = 1;
		lengh <= 0;
		now <= 0;
		beeplengh <= l16;
		end
	
	always@(negedge clk_khz)
		case(now)
			9'd0:  begin tone <= NOTE_D5  ; beeplengh<= l4d ; end
			9'd1:  begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end 
			9'd2:  begin tone <=  NOTE_A4  ; beeplengh<= l4 ; end  
			9'd3:  begin tone <= NOTE_E5  ; beeplengh<= l4d ; end  
			9'd4:  begin tone <=  NOTE_FS5  ; beeplengh<= l4d ; end
			9'd5:  begin tone <=  NOTE_A5  ; beeplengh<= l16 ; end 
			9'd6:  begin tone <=  NOTE_G5  ; beeplengh<= l16 ; end 
			9'd7:  begin tone <=  NOTE_FS5  ; beeplengh<= l8 ; end
			9'd8:  begin tone <= NOTE_D5  ; beeplengh<= l4d ; end
			9'd9:  begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end
			9'd10:  begin tone <=  NOTE_A4  ; beeplengh<= l2 ; end
			9'd11:  begin tone <= NOTE_A4  ; beeplengh<= l16 ; end
			9'd12:  begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			9'd13:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd14:  begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			9'd15:  begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			9'd16:  begin tone <= NOTE_D5  ; beeplengh<= l4d ; end
			9'd17:  begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end
			9'd18:  begin tone <=  NOTE_A4  ; beeplengh<= l4 ; end
			9'd19:  begin tone <= NOTE_E5  ; beeplengh<= l4d ; end
			9'd20:  begin tone <=  NOTE_FS5  ; beeplengh<= l4d ; end
			9'd21:  begin tone <=  NOTE_A5  ; beeplengh<= l16 ; end
			9'd22:  begin tone <=  NOTE_G5  ; beeplengh<= l16 ; end
			9'd23:  begin tone <=  NOTE_FS5  ; beeplengh<= l8 ; end
			9'd24:  begin tone <= NOTE_D5  ; beeplengh<= l4d ; end
			9'd25:  begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end
			9'd26:  begin tone <=  NOTE_A4  ; beeplengh<= l2 ; end
			9'd27:  begin tone <= NOTE_A4  ; beeplengh<= l16 ; end
			9'd28:  begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			9'd29:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd30:  begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			9'd31:  begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			9'd32:  begin tone <= REST  ; beeplengh<= l4 ; end
			9'd33:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd34:  begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			9'd35:  begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			9'd36:  begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			9'd37:  begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			9'd38:  begin tone <=  NOTE_CS5  ; beeplengh<= l8d ; end
			9'd39:  begin tone <= NOTE_B4  ; beeplengh<= l16 ; end
			9'd40:  begin tone <=  NOTE_A4  ; beeplengh<= l2 ; end
			9'd41:  begin tone <=  REST  ; beeplengh<= l4 ; end
			9'd42:  begin tone <= REST  ; beeplengh<= l8 ; end
			9'd43:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd44:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd45:  begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			9'd46:  begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			9'd47:  begin tone <=  NOTE_B4  ; beeplengh<= l4 ; end
			9'd48:  begin tone <=  NOTE_A4  ; beeplengh<= l8 ; end
			9'd49:  begin tone <= NOTE_A5  ; beeplengh<= l8 ; end
			9'd50:  begin tone <=  REST  ; beeplengh<= l8 ; end
			9'd51:  begin tone <=  NOTE_A5  ; beeplengh<= l8 ; end
			9'd52:  begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end
			9'd53:  begin tone <=  REST  ; beeplengh<= l4 ; end
			9'd54:  begin tone <= NOTE_B4  ; beeplengh<= l8 ; end
			9'd55:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd56:  begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			9'd57:  begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			9'd58:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd59:  begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			9'd60:  begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			9'd61:  begin tone <=  REST  ; beeplengh<= l8 ; end
			9'd62:  begin tone <= REST  ; beeplengh<= l8 ; end
			9'd63:  begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			9'd64:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd65:  begin tone <=  NOTE_A4  ; beeplengh<= l4d ; end
			9'd66:  begin tone <=  REST  ; beeplengh<= l4 ; end
			9'd67:  begin tone <= REST  ; beeplengh<= l8 ; end
			9'd68:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd69:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd70:  begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			9'd71:  begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			9'd72:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd73:  begin tone <=  NOTE_A4  ; beeplengh<= l4 ; end
			9'd74:  begin tone <= NOTE_E5  ; beeplengh<= l8 ; end
			9'd75:  begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			9'd76:  begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			9'd77:  begin tone <=  NOTE_FS5  ; beeplengh<= l8 ; end
			9'd78:  begin tone <=  NOTE_E5  ; beeplengh<= l4 ; end
			9'd79:  begin tone <=  REST  ; beeplengh<= l4 ; end
			9'd80:  begin tone <= NOTE_D5  ; beeplengh<= l2 ; end
			9'd81:  begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			9'd82:  begin tone <=  NOTE_FS5  ; beeplengh<= l8 ; end
			9'd83:  begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			9'd84:  begin tone <= NOTE_E5  ; beeplengh<= l8 ; end
			9'd85:  begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			9'd86:  begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			9'd87:  begin tone <=  NOTE_FS5  ; beeplengh<= l8 ; end
			9'd88:  begin tone <=  NOTE_E5  ; beeplengh<= l4 ; end
			9'd89:  begin tone <=  NOTE_A4  ; beeplengh<= l4 ; end
			9'd90:  begin tone <= REST  ; beeplengh<= l2 ; end
			9'd91:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd92:  begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			9'd93:  begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			9'd94:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd95:  begin tone <= REST  ; beeplengh<= l8 ; end
			9'd96:  begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			9'd97:  begin tone <=  NOTE_FS5  ; beeplengh<= l8 ; end
			9'd98:  begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end
			9'd99:  begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			9'd100:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd101:  begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			9'd102:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd103:  begin tone <= NOTE_FS5  ; beeplengh<= l8d ; end
			9'd104:  begin tone <=  NOTE_FS5  ; beeplengh<= l8d ; end
			9'd105:  begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end
			9'd106:  begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			9'd107:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd108:  begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			9'd109:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd110:  begin tone <= NOTE_E5  ; beeplengh<= l8d ; end
			9'd111:  begin tone <=  NOTE_E5  ; beeplengh<= l8d ; end
			9'd112:  begin tone <=  NOTE_D5  ; beeplengh<= l8d ; end
			9'd113:  begin tone <=  NOTE_CS5  ; beeplengh<= l16 ; end
			9'd114:  begin tone <=  NOTE_B4  ; beeplengh<= l8d ; end
			9'd115:  begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			9'd116:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd117:  begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			9'd118:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd119:  begin tone <= NOTE_D5  ; beeplengh<= l4 ; end
			9'd120:  begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			9'd121:  begin tone <=  NOTE_CS5  ; beeplengh<= l8d ; end
			9'd122:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd123:  begin tone <=  NOTE_A4  ; beeplengh<= l8 ; end
			9'd124:  begin tone <=  NOTE_A4  ; beeplengh<= l8 ; end
			9'd125:  begin tone <=  NOTE_A4  ; beeplengh<= l8 ; end
			9'd126:  begin tone <= NOTE_E5  ; beeplengh<= l4 ; end
			9'd127:  begin tone <=  NOTE_D5  ; beeplengh<= l2 ; end
			9'd128:  begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			9'd129:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd130:  begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			9'd131:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd132:  begin tone <= NOTE_FS5  ; beeplengh<= l8d ; end
			9'd133:  begin tone <=  NOTE_FS5  ; beeplengh<= l8d ; end
			9'd134:  begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end
			9'd135:  begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			9'd136:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd137:  begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			9'd138:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd139:  begin tone <= NOTE_A5  ; beeplengh<= l4 ; end
			9'd140:  begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			9'd141:  begin tone <=  NOTE_D5  ; beeplengh<= l8d ; end
			9'd142:  begin tone <=  NOTE_CS5  ; beeplengh<= l16 ; end
			9'd143:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd144:  begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			9'd145:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd146:  begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			9'd147:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd148:  begin tone <= NOTE_D5  ; beeplengh<= l4 ; end
			9'd149:  begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			9'd150:  begin tone <=  NOTE_CS5  ; beeplengh<= l8d ; end
			9'd151:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd152:  begin tone <=  NOTE_A4  ; beeplengh<= l4 ; end
			9'd153:  begin tone <=  NOTE_A4  ; beeplengh<= l8 ; end
			9'd154:  begin tone <= NOTE_E5  ; beeplengh<= l4 ; end
			9'd155:  begin tone <=  NOTE_D5  ; beeplengh<= l2 ; end
			9'd156:  begin tone <=  REST  ; beeplengh<= l4 ; end
			9'd157:  begin tone <= REST  ; beeplengh<= l8 ; end
			9'd158:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd159:  begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			9'd160:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd161:  begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			9'd162:  begin tone <=  NOTE_E5  ; beeplengh<= l4 ; end
			9'd163:  begin tone <=  REST  ; beeplengh<= l8 ; end
			9'd164:  begin tone <= REST  ; beeplengh<= l8 ; end
			9'd165:  begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			9'd166:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd167:  begin tone <=  NOTE_A4  ; beeplengh<= l4d ; end
			9'd168:  begin tone <=  REST  ; beeplengh<= l4 ; end
			9'd169:  begin tone <= REST  ; beeplengh<= l8 ; end
			9'd170:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd171:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd172:  begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			9'd173:  begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			9'd174:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd175:  begin tone <=  NOTE_A4  ; beeplengh<= l4 ; end
			9'd176:  begin tone <= REST  ; beeplengh<= l8 ; end
			9'd177:  begin tone <=  NOTE_A5  ; beeplengh<= l8 ; end
			9'd178:  begin tone <=  NOTE_A5  ; beeplengh<= l8 ; end
			9'd179:  begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			9'd180:  begin tone <=  NOTE_FS5  ; beeplengh<= l8 ; end
			9'd181:  begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			9'd182:  begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			9'd183:  begin tone <= REST  ; beeplengh<= l8 ; end
			9'd184:  begin tone <=  NOTE_A4  ; beeplengh<= l8 ; end
			9'd185:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd186:  begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			9'd187:  begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			9'd188:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd189:  begin tone <= REST  ; beeplengh<= l8 ; end
			9'd190:  begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			9'd191:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd192:  begin tone <=  NOTE_A4  ; beeplengh<= l4d ; end
			9'd193:  begin tone <=  REST  ; beeplengh<= l4 ; end
			9'd194:  begin tone <= NOTE_B4  ; beeplengh<= l8 ; end
			9'd195:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd196:  begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			9'd197:  begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			9'd198:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd199:  begin tone <=  NOTE_A4  ; beeplengh<= l4 ; end
			9'd200:  begin tone <=  REST  ; beeplengh<= l8 ; end
			9'd201:  begin tone <= REST  ; beeplengh<= l8 ; end
			9'd202:  begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			9'd203:  begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			9'd204:  begin tone <=  NOTE_FS5  ; beeplengh<= l4 ; end
			9'd205:  begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end
			9'd206:  begin tone <= NOTE_D5  ; beeplengh<= l2 ; end
			9'd207:  begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			9'd208:  begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			9'd209:  begin tone <=  NOTE_FS5  ; beeplengh<= l8 ; end
			9'd210:  begin tone <=  NOTE_E5  ; beeplengh<= l4 ; end
			9'd211:  begin tone <= NOTE_E5  ; beeplengh<= l8 ; end
			9'd212:  begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			9'd213:  begin tone <=  NOTE_FS5  ; beeplengh<= l8 ; end
			9'd214:  begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			9'd215:  begin tone <=  NOTE_A4  ; beeplengh<= l8 ; end
			9'd216:  begin tone <=  NOTE_A4  ; beeplengh<= l4 ; end
			9'd217:  begin tone <= REST  ; beeplengh<= l4d ; end
			9'd218:  begin tone <=  NOTE_A4  ; beeplengh<= l8 ; end
			9'd219:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd220:  begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			9'd221:  begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			9'd222:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd223:  begin tone <= REST  ; beeplengh<= l8 ; end
			9'd224:  begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			9'd225:  begin tone <=  NOTE_FS5  ; beeplengh<= l8 ; end
			9'd226:  begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end
			9'd227:  begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			9'd228:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd229:  begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			9'd230:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd231:  begin tone <= NOTE_FS5  ; beeplengh<= l8d ; end
			9'd232:  begin tone <=  NOTE_FS5  ; beeplengh<= l8d ; end
			9'd233:  begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end
			9'd234:  begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			9'd235:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd236:  begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			9'd237:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd238:  begin tone <= NOTE_E5  ; beeplengh<= l8d ; end
			9'd239:  begin tone <=  NOTE_E5  ; beeplengh<= l8d ; end
			9'd240:  begin tone <=  NOTE_D5  ; beeplengh<= l8d ; end
			9'd241:  begin tone <=  NOTE_CS5  ; beeplengh<= l16 ; end
			9'd242:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd243:  begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			9'd244:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd245:  begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			9'd246:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd247:  begin tone <= NOTE_D5  ; beeplengh<= l4 ; end
			9'd248:  begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			9'd249:  begin tone <=  NOTE_CS5  ; beeplengh<= l8d ; end
			9'd250:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd251:  begin tone <=  NOTE_A4  ; beeplengh<= l4 ; end
			9'd252:  begin tone <=  NOTE_A4  ; beeplengh<= l8 ; end
			9'd253:  begin tone <= NOTE_E5  ; beeplengh<= l4 ; end
			9'd254:  begin tone <=  NOTE_D5  ; beeplengh<= l2 ; end
			9'd255:  begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			9'd256:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd257:  begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			9'd258:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd259:  begin tone <= NOTE_FS5  ; beeplengh<= l8d ; end
			9'd260:  begin tone <=  NOTE_FS5  ; beeplengh<= l8d ; end
			9'd261:  begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end
			9'd262:  begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			9'd263:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd264:  begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			9'd265:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd266:  begin tone <= NOTE_A5  ; beeplengh<= l4 ; end
			9'd267:  begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			9'd268:  begin tone <=  NOTE_D5  ; beeplengh<= l8d ; end
			9'd269:  begin tone <=  NOTE_CS5  ; beeplengh<= l16 ; end
			9'd270:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd271:  begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			9'd272:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd273:  begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			9'd274:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd275:  begin tone <= NOTE_D5  ; beeplengh<= l4 ; end
			9'd276:  begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			9'd277:  begin tone <=  NOTE_CS5  ; beeplengh<= l8d ; end
			9'd278:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd279:  begin tone <=  NOTE_A4  ; beeplengh<= l4 ; end
			9'd280:  begin tone <=  NOTE_A4  ; beeplengh<= l8 ; end
			9'd281:  begin tone <= NOTE_E5  ; beeplengh<= l4 ; end
			9'd282:  begin tone <=  NOTE_D5  ; beeplengh<= l2 ; end
			9'd283:  begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			9'd284:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd285:  begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			9'd286:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd287:  begin tone <= NOTE_FS5  ; beeplengh<= l8d ; end
			9'd288:  begin tone <=  NOTE_FS5  ; beeplengh<= l8d ; end
			9'd289:  begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end
			9'd290:  begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			9'd291:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd292:  begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			9'd293:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd294:  begin tone <= NOTE_A5  ; beeplengh<= l4 ; end
			9'd295:  begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			9'd296:  begin tone <=  NOTE_D5  ; beeplengh<= l8d ; end
			9'd297:  begin tone <=  NOTE_CS5  ; beeplengh<= l16 ; end
			9'd298:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd299:  begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			9'd300:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd301:  begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			9'd302:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd303:  begin tone <= NOTE_D5  ; beeplengh<= l4 ; end
			9'd304:  begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			9'd305:  begin tone <=  NOTE_CS5  ; beeplengh<= l8d ; end
			9'd306:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd307:  begin tone <=  NOTE_A4  ; beeplengh<= l4 ; end
			9'd308:  begin tone <=  NOTE_A4  ; beeplengh<= l8 ; end
			9'd309:  begin tone <= NOTE_E5  ; beeplengh<= l4 ; end
			9'd310:  begin tone <=  NOTE_D5  ; beeplengh<= l2 ; end
			9'd311:  begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			9'd312:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd313:  begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			9'd314:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd315:  begin tone <= NOTE_FS5  ; beeplengh<= l8d ; end
			9'd316:  begin tone <=  NOTE_FS5  ; beeplengh<= l8d ; end
			9'd317:  begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end
			9'd318:  begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			9'd319:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd320:  begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			9'd321:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd322:  begin tone <= NOTE_A5  ; beeplengh<= l4 ; end
			9'd323:  begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			9'd324:  begin tone <=  NOTE_D5  ; beeplengh<= l8d ; end
			9'd325:  begin tone <=  NOTE_CS5  ; beeplengh<= l16 ; end
			9'd326:  begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			9'd327:  begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			9'd328:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd329:  begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			9'd330:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd331:  begin tone <= NOTE_D5  ; beeplengh<= l4 ; end
			9'd332:  begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			9'd333:  begin tone <=  NOTE_CS5  ; beeplengh<= l8d ; end
			9'd334:  begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			9'd335:  begin tone <=  NOTE_A4  ; beeplengh<= l4 ; end
			9'd336:  begin tone <=  NOTE_A4  ; beeplengh<= l8 ; end
			9'd337:  begin tone <= NOTE_E5  ; beeplengh<= l4 ; end
			9'd338:  begin tone <=  NOTE_D5  ; beeplengh<= l2 ; end
			9'd339:  begin tone <=  REST  ; beeplengh<= l4 ; end
		endcase

	
	always@(posedge clk_khz , negedge enable)begin
		if(~enable)begin
			beep_enable <= 0;
			now <= 0;
			lengh <= 0;
			end
		else begin
			beep_enable <= 1;
			if(lengh > beeplengh)begin
				lengh <= 0;
				if(now < all)now <= now +1;
				end
			else lengh <= lengh+1;
			end
		end
	
	
	always@(posedge Clk) //毫秒計時器
			if(kcnt>25000)begin
				kcnt <= 0;
				clk_khz <= ~clk_khz;
				end
			else
				kcnt <= kcnt +1;
	
	always @(posedge Clk) //藉由蜂鳴器閃爍的頻率改變音調
		begin
			if(tone == 0)beep <= 0;
			else
				if (beep_enable)
					if(count > tone)begin
						count<=0;
						beep=~beep;
					end
					else
						count <= count+1;
				else
					beep <= 0;
		end
	
	

endmodule

module player_wrong(
	output reg beep,
	input Clk,enable
);
	reg [16:0] count,tone; //beep 的計數器、頻率
	reg clk_khz; 				  //ms Clk
	reg [14:0]kcnt;           //ms counter
	reg beep_enable;           
	reg [1:0] now;          //樂譜演奏進度
	reg [12:0] lengh,beeplengh;  //控制beep的長度
	parameter 
		all = 2'd2, //樂譜長度
		NOTE_B0  = 17'hc4e33,
		NOTE_C1  = 17'hb8f47,
		NOTE_CS1 = 17'hae62d,
		NOTE_D1  = 17'ha4f5b,
		NOTE_DS1 = 17'h9c801,
		NOTE_E1  = 17'h94ddc,
		NOTE_F1  = 17'h8ab75,
		NOTE_FS1 = 17'h84af6,
		NOTE_G1  = 17'h7c8fc,
		NOTE_GS1 = 17'h75601,
		NOTE_A1  = 17'h6ef91,
		NOTE_AS1 = 17'h693ba,
		NOTE_B1  = 17'h62719,
		NOTE_C2  = 17'h5de67,
		NOTE_CS2 = 17'h5874e,
		NOTE_D2  = 17'h539c1,
		NOTE_DS2 = 17'h4e400,
		NOTE_E2  = 17'h4a6ee,
		NOTE_F2  = 17'h4627c,
		NOTE_FS2 = 17'h41a11,
		NOTE_G2  = 17'h3e47e,
		NOTE_GS2 = 17'h3ab00,
		NOTE_A2  = 17'h377c8,
		NOTE_AS2 = 17'h342ab,
		NOTE_B2  = 17'h319f4,
		NOTE_C3  = 17'h2e977,
		NOTE_CS3 = 17'h2be90,
		NOTE_D3  = 17'h29854,
		NOTE_DS3 = 17'h27200,
		NOTE_E3  = 17'h24fdb,
		NOTE_F3  = 17'h22e09,
		NOTE_FS3 = 17'h20fdf,
		NOTE_G3  = 17'h1f23f,
		NOTE_GS3 = 17'h1d580,
		NOTE_A3  = 17'h1bbe4,
		NOTE_AS3 = 17'h1a320,
		NOTE_B3  = 17'h18b5e,
		NOTE_C4  = 17'h174bb,
		NOTE_CS4 = 17'h1608c,
		NOTE_D4  = 17'h14c2a,
		NOTE_DS4 = 17'h13a01,
		NOTE_E4  = 17'h127ed,
		NOTE_F4  = 17'h117d1,
		NOTE_FS4 = 17'h107ef,
		NOTE_G4  = 17'hf91f,
		NOTE_GS4 = 17'heb50,
		NOTE_A4  = 17'hddf2,
		NOTE_AS4 = 17'hd190,
		NOTE_B4  = 17'hc5af,
		NOTE_C5  = 17'hbab9,
		NOTE_CS5 = 17'hb046,
		NOTE_D5  = 17'ha65d,
		NOTE_DS5 = 17'h9d00,
		NOTE_E5  = 17'h9430,
		NOTE_F5  = 17'h8be8,
		NOTE_FS5 = 17'h83f7,
		NOTE_G5  = 17'h7c8f,
		NOTE_GS5 = 17'h7584,
		NOTE_A5  = 17'h6ef9,
		NOTE_AS5 = 17'h68c8,
		NOTE_B5  = 17'h62d7,
		NOTE_C6  = 17'h5d45,
		NOTE_CS6 = 17'h580e,
		NOTE_D6  = 17'h531c,
		NOTE_DS6 = 17'h4e70,
		NOTE_E6  = 17'h4a09,
		NOTE_F6  = 17'h45e7,
		NOTE_FS6 = 17'h41fb,
		NOTE_G6  = 17'h3e47,
		NOTE_GS6 = 17'h3acb,
		NOTE_A6  = 17'h377c,
		NOTE_AS6 = 17'h345c,
		NOTE_B6  = 17'h316b,
		NOTE_C7  = 17'h2ea8,
		NOTE_CS7 = 17'h2c0c,
		NOTE_D7  = 17'h2992,
		NOTE_DS7 = 17'h273c,
		NOTE_E7  = 17'h2508,
		NOTE_F7  = 17'h22f3,
		NOTE_FS7 = 17'h20fd,
		NOTE_G7  = 17'h1f23,
		NOTE_GS7 = 17'h1d65,
		NOTE_A7  = 17'h1bbe,
		NOTE_AS7 = 17'h1a30,
		NOTE_B7  = 17'h18b7,
		NOTE_C8  = 17'h1754,
		NOTE_CS8 = 17'h1604,
		NOTE_D8  = 17'h14c8,
		NOTE_DS8 = 17'h139e,
		REST     = 17'h0,
		l2  = 13'd960,
		l4  = 13'd480,
		l4d = 13'd720,
		l8  = 13'd240,
		l8d = 13'd360,
		l16 = 13'd120,
		l16d= 13'd180;
	
	initial begin
		tone <= NOTE_D5;
		beep_enable = 1;
		lengh <= 0;
		now <= 0;
		beeplengh <= l16;
		end
	
	always@(negedge clk_khz)
		case(now)
			2'd0:  begin tone <= NOTE_E5  ; beeplengh<= l16 ; end
			2'd1:  begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end 
			2'd2:  begin tone <=  REST  ; beeplengh<= l4 ; end  
		endcase

	
	always@(posedge clk_khz , negedge enable)begin
		if(~enable)begin
			beep_enable <= 0;
			now <= 0;
			lengh <= 0;
			end
		else begin
			beep_enable <= 1;
			if(lengh > beeplengh)begin
				lengh <= 0;
				if(now < all)now <= now +1;
				end
			else lengh <= lengh+1;
			end
		end
	
	
	always@(posedge Clk) //毫秒計時器
			if(kcnt>25000)begin
				kcnt <= 0;
				clk_khz <= ~clk_khz;
				end
			else
				kcnt <= kcnt +1;
	
	always @(posedge Clk) //藉由蜂鳴器閃爍的頻率改變音調
		begin
			if(tone == 0)beep <= 0;
			else
				if (beep_enable)
					if(count > tone)begin
						count<=0;
						beep=~beep;
					end
					else
						count <= count+1;
				else
					beep <= 0;
		end
	
	

endmodule

module player_correct(
	output reg beep,
	input Clk,enable
);
	reg [16:0] count,tone; //beep 的計數器、頻率
	reg clk_khz; 				  //ms Clk
	reg [14:0]kcnt;           //ms counter
	reg beep_enable;           
	reg [2:0] now;          //樂譜演奏進度
	reg [12:0] lengh,beeplengh;  //控制beep的長度
	parameter 
		all = 3'd7, //樂譜長度
		NOTE_B0  = 17'hc4e33,
		NOTE_C1  = 17'hb8f47,
		NOTE_CS1 = 17'hae62d,
		NOTE_D1  = 17'ha4f5b,
		NOTE_DS1 = 17'h9c801,
		NOTE_E1  = 17'h94ddc,
		NOTE_F1  = 17'h8ab75,
		NOTE_FS1 = 17'h84af6,
		NOTE_G1  = 17'h7c8fc,
		NOTE_GS1 = 17'h75601,
		NOTE_A1  = 17'h6ef91,
		NOTE_AS1 = 17'h693ba,
		NOTE_B1  = 17'h62719,
		NOTE_C2  = 17'h5de67,
		NOTE_CS2 = 17'h5874e,
		NOTE_D2  = 17'h539c1,
		NOTE_DS2 = 17'h4e400,
		NOTE_E2  = 17'h4a6ee,
		NOTE_F2  = 17'h4627c,
		NOTE_FS2 = 17'h41a11,
		NOTE_G2  = 17'h3e47e,
		NOTE_GS2 = 17'h3ab00,
		NOTE_A2  = 17'h377c8,
		NOTE_AS2 = 17'h342ab,
		NOTE_B2  = 17'h319f4,
		NOTE_C3  = 17'h2e977,
		NOTE_CS3 = 17'h2be90,
		NOTE_D3  = 17'h29854,
		NOTE_DS3 = 17'h27200,
		NOTE_E3  = 17'h24fdb,
		NOTE_F3  = 17'h22e09,
		NOTE_FS3 = 17'h20fdf,
		NOTE_G3  = 17'h1f23f,
		NOTE_GS3 = 17'h1d580,
		NOTE_A3  = 17'h1bbe4,
		NOTE_AS3 = 17'h1a320,
		NOTE_B3  = 17'h18b5e,
		NOTE_C4  = 17'h174bb,
		NOTE_CS4 = 17'h1608c,
		NOTE_D4  = 17'h14c2a,
		NOTE_DS4 = 17'h13a01,
		NOTE_E4  = 17'h127ed,
		NOTE_F4  = 17'h117d1,
		NOTE_FS4 = 17'h107ef,
		NOTE_G4  = 17'hf91f,
		NOTE_GS4 = 17'heb50,
		NOTE_A4  = 17'hddf2,
		NOTE_AS4 = 17'hd190,
		NOTE_B4  = 17'hc5af,
		NOTE_C5  = 17'hbab9,
		NOTE_CS5 = 17'hb046,
		NOTE_D5  = 17'ha65d,
		NOTE_DS5 = 17'h9d00,
		NOTE_E5  = 17'h9430,
		NOTE_F5  = 17'h8be8,
		NOTE_FS5 = 17'h83f7,
		NOTE_G5  = 17'h7c8f,
		NOTE_GS5 = 17'h7584,
		NOTE_A5  = 17'h6ef9,
		NOTE_AS5 = 17'h68c8,
		NOTE_B5  = 17'h62d7,
		NOTE_C6  = 17'h5d45,
		NOTE_CS6 = 17'h580e,
		NOTE_D6  = 17'h531c,
		NOTE_DS6 = 17'h4e70,
		NOTE_E6  = 17'h4a09,
		NOTE_F6  = 17'h45e7,
		NOTE_FS6 = 17'h41fb,
		NOTE_G6  = 17'h3e47,
		NOTE_GS6 = 17'h3acb,
		NOTE_A6  = 17'h377c,
		NOTE_AS6 = 17'h345c,
		NOTE_B6  = 17'h316b,
		NOTE_C7  = 17'h2ea8,
		NOTE_CS7 = 17'h2c0c,
		NOTE_D7  = 17'h2992,
		NOTE_DS7 = 17'h273c,
		NOTE_E7  = 17'h2508,
		NOTE_F7  = 17'h22f3,
		NOTE_FS7 = 17'h20fd,
		NOTE_G7  = 17'h1f23,
		NOTE_GS7 = 17'h1d65,
		NOTE_A7  = 17'h1bbe,
		NOTE_AS7 = 17'h1a30,
		NOTE_B7  = 17'h18b7,
		NOTE_C8  = 17'h1754,
		NOTE_CS8 = 17'h1604,
		NOTE_D8  = 17'h14c8,
		NOTE_DS8 = 17'h139e,
		REST     = 17'h0,
		l2  = 13'd960,
		l4  = 13'd480,
		l4d = 13'd720,
		l8  = 13'd240,
		l8d = 13'd360,
		l16 = 13'd120,
		l16d= 13'd180;
	
	initial begin
		tone <= NOTE_D5;
		beep_enable = 1;
		lengh <= 0;
		now <= 0;
		beeplengh <= l16;
		end
	
	always@(negedge clk_khz)
		case(now)
			3'd0:  begin tone <=  NOTE_D4  ; beeplengh<= l16 ; end
			3'd1:  begin tone <=  NOTE_F4  ; beeplengh<= l16 ; end 
			3'd2:  begin tone <=  NOTE_C5  ; beeplengh<= l16 ; end 
			3'd3:  begin tone <=  NOTE_A5  ; beeplengh<= l16 ; end 
			3'd4:  begin tone <=  REST     ; beeplengh<= l8 ; end  
			3'd5:  begin tone <=  NOTE_F5  ; beeplengh<= l16 ; end 
			3'd6:  begin tone <=  NOTE_A5  ; beeplengh<= l4 ; end 
			3'd7:  begin tone <=  REST     ; beeplengh<= l16 ; end 
		endcase

	
	always@(posedge clk_khz , negedge enable)begin
		if(~enable)begin
			beep_enable <= 0;
			now <= 0;
			lengh <= 0;
			end
		else begin
			beep_enable <= 1;
			if(lengh > beeplengh)begin
				lengh <= 0;
				if(now < all)now <= now +1;
				end
			else lengh <= lengh+1;
			end
		end
	
	
	always@(posedge Clk) //毫秒計時器
			if(kcnt>25000)begin
				kcnt <= 0;
				clk_khz <= ~clk_khz;
				end
			else
				kcnt <= kcnt +1;
	
	always @(posedge Clk) //藉由蜂鳴器閃爍的頻率改變音調
		begin
			if(tone == 0)beep <= 0;
			else
				if (beep_enable)
					if(count > tone)begin
						count<=0;
						beep=~beep;
					end
					else
						count <= count+1;
				else
					beep <= 0;
		end
	
	

endmodule

module player_cong(
	output reg beep,
	input Clk,enable
);
	reg [16:0] count,tone; //beep 的計數器、頻率
	reg clk_khz; 				  //ms Clk
	reg [14:0]kcnt;           //ms counter
	reg beep_enable;           
	reg [9:0] now;          //樂譜演奏進度
	reg [12:0] lengh,beeplengh;  //控制beep的長度
	parameter 
		all = 10'd387, //樂譜長度
		NOTE_B0  = 17'hc4e33,
		NOTE_C1  = 17'hb8f47,
		NOTE_CS1 = 17'hae62d,
		NOTE_D1  = 17'ha4f5b,
		NOTE_DS1 = 17'h9c801,
		NOTE_E1  = 17'h94ddc,
		NOTE_F1  = 17'h8ab75,
		NOTE_FS1 = 17'h84af6,
		NOTE_G1  = 17'h7c8fc,
		NOTE_GS1 = 17'h75601,
		NOTE_A1  = 17'h6ef91,
		NOTE_AS1 = 17'h693ba,
		NOTE_B1  = 17'h62719,
		NOTE_C2  = 17'h5de67,
		NOTE_CS2 = 17'h5874e,
		NOTE_D2  = 17'h539c1,
		NOTE_DS2 = 17'h4e400,
		NOTE_E2  = 17'h4a6ee,
		NOTE_F2  = 17'h4627c,
		NOTE_FS2 = 17'h41a11,
		NOTE_G2  = 17'h3e47e,
		NOTE_GS2 = 17'h3ab00,
		NOTE_A2  = 17'h377c8,
		NOTE_AS2 = 17'h342ab,
		NOTE_B2  = 17'h319f4,
		NOTE_C3  = 17'h2e977,
		NOTE_CS3 = 17'h2be90,
		NOTE_D3  = 17'h29854,
		NOTE_DS3 = 17'h27200,
		NOTE_E3  = 17'h24fdb,
		NOTE_F3  = 17'h22e09,
		NOTE_FS3 = 17'h20fdf,
		NOTE_G3  = 17'h1f23f,
		NOTE_GS3 = 17'h1d580,
		NOTE_A3  = 17'h1bbe4,
		NOTE_AS3 = 17'h1a320,
		NOTE_B3  = 17'h18b5e,
		NOTE_C4  = 17'h174bb,
		NOTE_CS4 = 17'h1608c,
		NOTE_D4  = 17'h14c2a,
		NOTE_DS4 = 17'h13a01,
		NOTE_E4  = 17'h127ed,
		NOTE_F4  = 17'h117d1,
		NOTE_FS4 = 17'h107ef,
		NOTE_G4  = 17'hf91f,
		NOTE_GS4 = 17'heb50,
		NOTE_A4  = 17'hddf2,
		NOTE_AS4 = 17'hd190,
		NOTE_B4  = 17'hc5af,
		NOTE_C5  = 17'hbab9,
		NOTE_CS5 = 17'hb046,
		NOTE_D5  = 17'ha65d,
		NOTE_DS5 = 17'h9d00,
		NOTE_E5  = 17'h9430,
		NOTE_F5  = 17'h8be8,
		NOTE_FS5 = 17'h83f7,
		NOTE_G5  = 17'h7c8f,
		NOTE_GS5 = 17'h7584,
		NOTE_A5  = 17'h6ef9,
		NOTE_AS5 = 17'h68c8,
		NOTE_B5  = 17'h62d7,
		NOTE_C6  = 17'h5d45,
		NOTE_CS6 = 17'h580e,
		NOTE_D6  = 17'h531c,
		NOTE_DS6 = 17'h4e70,
		NOTE_E6  = 17'h4a09,
		NOTE_F6  = 17'h45e7,
		NOTE_FS6 = 17'h41fb,
		NOTE_G6  = 17'h3e47,
		NOTE_GS6 = 17'h3acb,
		NOTE_A6  = 17'h377c,
		NOTE_AS6 = 17'h345c,
		NOTE_B6  = 17'h316b,
		NOTE_C7  = 17'h2ea8,
		NOTE_CS7 = 17'h2c0c,
		NOTE_D7  = 17'h2992,
		NOTE_DS7 = 17'h273c,
		NOTE_E7  = 17'h2508,
		NOTE_F7  = 17'h22f3,
		NOTE_FS7 = 17'h20fd,
		NOTE_G7  = 17'h1f23,
		NOTE_GS7 = 17'h1d65,
		NOTE_A7  = 17'h1bbe,
		NOTE_AS7 = 17'h1a30,
		NOTE_B7  = 17'h18b7,
		NOTE_C8  = 17'h1754,
		NOTE_CS8 = 17'h1604,
		NOTE_D8  = 17'h14c8,
		NOTE_DS8 = 17'h139e,
		REST     = 17'h0,
		l2  = 13'd960,
		l4  = 13'd480,
		l4d = 13'd720,
		l8  = 13'd240,
		l8d = 13'd360,
		l16 = 13'd120,
		l16d= 13'd180;
	
	initial begin
		tone <= NOTE_D5;
		beep_enable = 1;
		lengh <= 0;
		now <= 0;
		beeplengh <= l16;
		end
	
	always@(negedge clk_khz)
		case(now)
			10'd0:  begin tone <=  NOTE_G3  ; beeplengh<= l16 ; end
			10'd1:  begin tone <=  NOTE_A3  ; beeplengh<= l16 ; end 
			10'd2:  begin tone <=  NOTE_B3  ; beeplengh<= l16 ; end 
			10'd3:  begin tone <=  NOTE_D4  ; beeplengh<= l16 ; end 
			10'd4:  begin tone <=  REST     ; beeplengh<= l8 ; end  
			10'd5:  begin tone <=  NOTE_C4  ; beeplengh<= l16 ; end 
			10'd6:  begin tone <=  NOTE_D4  ; beeplengh<= l4 ; end 
			10'd7:  begin tone <=  REST     ; beeplengh<= l4 ; end 
			10'd8:  begin tone <=  NOTE_B3  ; beeplengh<= l16 ; end
			10'd9:  begin tone <=  NOTE_C4  ; beeplengh<= l16 ; end 
			10'd10:  begin tone <=  NOTE_D4  ; beeplengh<= l16 ; end 
			10'd11:  begin tone <=  NOTE_F4  ; beeplengh<= l16 ; end 
			10'd12:  begin tone <=  REST     ; beeplengh<= l8 ; end  
			10'd13:  begin tone <=  NOTE_E4  ; beeplengh<= l16 ; end 
			10'd14:  begin tone <=  NOTE_F4  ; beeplengh<= l4 ; end 
			10'd15:  begin tone <=  REST     ; beeplengh<= l4 ; end 
			10'd16:  begin tone <=  NOTE_D4  ; beeplengh<= l16 ; end
			10'd17:  begin tone <=  NOTE_E4  ; beeplengh<= l16 ; end 
			10'd18:  begin tone <=  NOTE_F4  ; beeplengh<= l16 ; end 
			10'd19:  begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end 
			10'd20:  begin tone <=  REST     ; beeplengh<= l8 ; end  
			10'd21:  begin tone <=  NOTE_G4  ; beeplengh<= l16 ; end 
			10'd22:  begin tone <=  NOTE_A4  ; beeplengh<= l4 ; end 
			10'd23:  begin tone <=  REST     ; beeplengh<= l4 ; end 
			10'd24:  begin tone <=  NOTE_B5  ; beeplengh<= l16 ; end 
			10'd25:  begin tone <=  REST     ; beeplengh<= 20 ; end 
			10'd26:  begin tone <=  NOTE_B5  ; beeplengh<= l16 ; end 
			10'd27:  begin tone <=  REST     ; beeplengh<= 20 ; end 
			10'd28:  begin tone <=  NOTE_B5  ; beeplengh<= l16 ; end 
			10'd29:  begin tone <=  REST     ; beeplengh<= 20 ; end 
			10'd30:  begin tone <=  NOTE_E6  ; beeplengh<= 2000 ; end 
			10'd31:  begin tone <=  REST     ; beeplengh<= 50 ; end 
			10'd32:		begin tone <=  NOTE_E6  ; beeplengh<= l16 ; end 
			10'd33:		begin tone <=  REST     ; beeplengh<= 20 ; end 
			10'd34:		begin tone <=  NOTE_E6  ; beeplengh<= l16 ; end 
			10'd35:		begin tone <=  REST     ; beeplengh<= l8 ; end 
			10'd36:		begin tone <=  NOTE_E6  ; beeplengh<= l16 ; end 
			10'd37:		begin tone <=  REST     ; beeplengh<= 20 ; end 
			10'd38:		begin tone <=  NOTE_E6  ; beeplengh<= l16 ; end 
			10'd39:		begin tone <=  REST     ; beeplengh<= 20 ; end 
			10'd40:		begin tone <=  NOTE_E6  ; beeplengh<= l16 ; end 
			10'd41:		begin tone <=  REST     ; beeplengh<= 20 ; end 
			10'd42:		begin tone <=  NOTE_E6  ; beeplengh<= l16 ; end 
			10'd43:		begin tone <=  REST     ; beeplengh<= 20 ; end 
			10'd44:		begin tone <=  NOTE_E6  ; beeplengh<= l16 ; end 
			10'd45:		begin tone <=  REST     ; beeplengh<= 20 ; end 
			10'd46:		begin tone <=  NOTE_E6  ; beeplengh<= l16 ; end 
			10'd47:		begin tone <=  REST     ; beeplengh<= 20 ; end 
			10'd48:	   begin tone <= NOTE_D5  ; beeplengh<= l4d ; end
			10'd49:	   begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end 
			10'd50:	   begin tone <=  NOTE_A4  ; beeplengh<= l4 ; end  
			10'd51:	   begin tone <= NOTE_E5  ; beeplengh<= l4d ; end  
			10'd52:	   begin tone <=  NOTE_FS5  ; beeplengh<= l4d ; end
			10'd53:	   begin tone <=  NOTE_A5  ; beeplengh<= l16 ; end 
			10'd54:	   begin tone <=  NOTE_G5  ; beeplengh<= l16 ; end 
			10'd55:	   begin tone <=  NOTE_FS5  ; beeplengh<= l8 ; end
			10'd56:	   begin tone <= NOTE_D5  ; beeplengh<= l4d ; end
			10'd57:	   begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end
			10'd58:		begin tone <=  NOTE_A4  ; beeplengh<= l2 ; end
			10'd59:		begin tone <= NOTE_A4  ; beeplengh<= l16 ; end
			10'd60:		begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			10'd61:		begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd62:		begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			10'd63:		begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			10'd64:		begin tone <= NOTE_D5  ; beeplengh<= l4d ; end
			10'd65:		begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end
			10'd66:		begin tone <=  NOTE_A4  ; beeplengh<= l4 ; end
			10'd67:		begin tone <= NOTE_E5  ; beeplengh<= l4d ; end
			10'd68:		begin tone <=  NOTE_FS5  ; beeplengh<= l4d ; end
			10'd69:		begin tone <=  NOTE_A5  ; beeplengh<= l16 ; end
			10'd70:		begin tone <=  NOTE_G5  ; beeplengh<= l16 ; end
			10'd71:		begin tone <=  NOTE_FS5  ; beeplengh<= l8 ; end
			10'd72:		begin tone <= NOTE_D5  ; beeplengh<= l4d ; end
			10'd73:		begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end
			10'd74:		begin tone <=  NOTE_A4  ; beeplengh<= l2 ; end
			10'd75:		begin tone <= NOTE_A4  ; beeplengh<= l16 ; end
			10'd76:		begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			10'd77:		begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd78:		begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			10'd79:		begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			10'd80:		begin tone <= REST  ; beeplengh<= l4 ; end
			10'd81:		begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd82:		begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			10'd83:		begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			10'd84:		begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			10'd85:		begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			10'd86:		begin tone <=  NOTE_CS5  ; beeplengh<= l8d ; end
			10'd87:		begin tone <= NOTE_B4  ; beeplengh<= l16 ; end
			10'd88:		begin tone <=  NOTE_A4  ; beeplengh<= l2 ; end
			10'd89:		begin tone <=  REST  ; beeplengh<= l4 ; end
			10'd90:		begin tone <= REST  ; beeplengh<= l8 ; end
			10'd91:		begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd92:		begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd93:		begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			10'd94:		begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			10'd95:		begin tone <=  NOTE_B4  ; beeplengh<= l4 ; end
			10'd96:		begin tone <=  NOTE_A4  ; beeplengh<= l8 ; end
			10'd97:		begin tone <= NOTE_A5  ; beeplengh<= l8 ; end
			10'd98:		begin tone <=  REST  ; beeplengh<= l8 ; end
			10'd99:		begin tone <=  NOTE_A5  ; beeplengh<= l8 ; end
			10'd100:		begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end
			10'd101:		begin tone <=  REST  ; beeplengh<= l4 ; end
			10'd102:		begin tone <= NOTE_B4  ; beeplengh<= l8 ; end
			10'd103:		begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd104:		begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			10'd105:		begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			10'd106:		begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd107:		begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			10'd108:		begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			10'd109:		begin tone <=  REST  ; beeplengh<= l8 ; end
			10'd110:		begin tone <= REST  ; beeplengh<= l8 ; end
			10'd111:		begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			10'd112:		begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd113:		begin tone <=  NOTE_A4  ; beeplengh<= l4d ; end
			10'd114:		begin tone <=  REST  ; beeplengh<= l4 ; end
			10'd115:		begin tone <= REST  ; beeplengh<= l8 ; end
			10'd116:		begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd117:		begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd118:		begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			10'd119:		begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			10'd120:		begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd121:		begin tone <=  NOTE_A4  ; beeplengh<= l4 ; end
			10'd122:		begin tone <= NOTE_E5  ; beeplengh<= l8 ; end
			10'd123:		begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			10'd124:		begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			10'd125:		begin tone <=  NOTE_FS5  ; beeplengh<= l8 ; end
			10'd126:		begin tone <=  NOTE_E5  ; beeplengh<= l4 ; end
			10'd127:		begin tone <=  REST  ; beeplengh<= l4 ; end
			10'd128:		begin tone <= NOTE_D5  ; beeplengh<= l2 ; end
			10'd129:		begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			10'd130:		begin tone <=  NOTE_FS5  ; beeplengh<= l8 ; end
			10'd131:		begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			10'd132:		begin tone <= NOTE_E5  ; beeplengh<= l8 ; end
			10'd133:		begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			10'd134:		begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			10'd135:		begin tone <=  NOTE_FS5  ; beeplengh<= l8 ; end
			10'd136:		begin tone <=  NOTE_E5  ; beeplengh<= l4 ; end
			10'd137:		begin tone <=  NOTE_A4  ; beeplengh<= l4 ; end
			10'd138:		begin tone <= REST  ; beeplengh<= l2 ; end
			10'd139:		begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd140:		begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			10'd141:		begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			10'd142:		begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd143:		begin tone <= REST  ; beeplengh<= l8 ; end
			10'd144:		begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			10'd145:		begin tone <=  NOTE_FS5  ; beeplengh<= l8 ; end
			10'd146:		begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end
			10'd147:		begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			10'd148:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd149:        begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			10'd150:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd151:        begin tone <= NOTE_FS5  ; beeplengh<= l8d ; end
			10'd152:        begin tone <=  NOTE_FS5  ; beeplengh<= l8d ; end
			10'd153:        begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end
			10'd154:        begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			10'd155:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd156:        begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			10'd157:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd158:        begin tone <= NOTE_E5  ; beeplengh<= l8d ; end
			10'd159:        begin tone <=  NOTE_E5  ; beeplengh<= l8d ; end
			10'd160:        begin tone <=  NOTE_D5  ; beeplengh<= l8d ; end
			10'd161:        begin tone <=  NOTE_CS5  ; beeplengh<= l16 ; end
			10'd162:        begin tone <=  NOTE_B4  ; beeplengh<= l8d ; end
			10'd163:        begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			10'd164:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd165:        begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			10'd166:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd167:        begin tone <= NOTE_D5  ; beeplengh<= l4 ; end
			10'd168:        begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			10'd169:        begin tone <=  NOTE_CS5  ; beeplengh<= l8d ; end
			10'd170:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd171:        begin tone <=  NOTE_A4  ; beeplengh<= l8 ; end
			10'd172:        begin tone <=  NOTE_A4  ; beeplengh<= l8 ; end
			10'd173:        begin tone <=  NOTE_A4  ; beeplengh<= l8 ; end
			10'd174:        begin tone <= NOTE_E5  ; beeplengh<= l4 ; end
			10'd175:        begin tone <=  NOTE_D5  ; beeplengh<= l2 ; end
			10'd176:        begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			10'd177:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd178:        begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			10'd179:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd180:        begin tone <= NOTE_FS5  ; beeplengh<= l8d ; end
			10'd181:        begin tone <=  NOTE_FS5  ; beeplengh<= l8d ; end
			10'd182:        begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end
			10'd183:        begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			10'd184:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd185:        begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			10'd186:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd187:        begin tone <= NOTE_A5  ; beeplengh<= l4 ; end
			10'd188:        begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			10'd189:        begin tone <=  NOTE_D5  ; beeplengh<= l8d ; end
			10'd190:        begin tone <=  NOTE_CS5  ; beeplengh<= l16 ; end
			10'd191:        begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd192:        begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			10'd193:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd194:        begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			10'd195:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd196:        begin tone <= NOTE_D5  ; beeplengh<= l4 ; end
			10'd197:        begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			10'd198:        begin tone <=  NOTE_CS5  ; beeplengh<= l8d ; end
			10'd199:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd200:        begin tone <=  NOTE_A4  ; beeplengh<= l4 ; end
			10'd201:        begin tone <=  NOTE_A4  ; beeplengh<= l8 ; end
			10'd202:        begin tone <= NOTE_E5  ; beeplengh<= l4 ; end
			10'd203:        begin tone <=  NOTE_D5  ; beeplengh<= l2 ; end
			10'd204:        begin tone <=  REST  ; beeplengh<= l4 ; end
			10'd205:        begin tone <= REST  ; beeplengh<= l8 ; end
			10'd206:        begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd207:        begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			10'd208:        begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd209:        begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			10'd210:        begin tone <=  NOTE_E5  ; beeplengh<= l4 ; end
			10'd211:        begin tone <=  REST  ; beeplengh<= l8 ; end
			10'd212:        begin tone <= REST  ; beeplengh<= l8 ; end
			10'd213:        begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			10'd214:        begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd215:        begin tone <=  NOTE_A4  ; beeplengh<= l4d ; end
			10'd216:        begin tone <=  REST  ; beeplengh<= l4 ; end
			10'd217:        begin tone <= REST  ; beeplengh<= l8 ; end
			10'd218:        begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd219:        begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd220:        begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			10'd221:        begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			10'd222:        begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd223:        begin tone <=  NOTE_A4  ; beeplengh<= l4 ; end
			10'd224:        begin tone <= REST  ; beeplengh<= l8 ; end
			10'd225:        begin tone <=  NOTE_A5  ; beeplengh<= l8 ; end
			10'd226:        begin tone <=  NOTE_A5  ; beeplengh<= l8 ; end
			10'd227:        begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			10'd228:        begin tone <=  NOTE_FS5  ; beeplengh<= l8 ; end
			10'd229:        begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			10'd230:        begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			10'd231:        begin tone <= REST  ; beeplengh<= l8 ; end
			10'd232:        begin tone <=  NOTE_A4  ; beeplengh<= l8 ; end
			10'd233:        begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd234:        begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			10'd235:        begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			10'd236:        begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd237:        begin tone <= REST  ; beeplengh<= l8 ; end
			10'd238:        begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			10'd239:        begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd240:        begin tone <=  NOTE_A4  ; beeplengh<= l4d ; end
			10'd241:        begin tone <=  REST  ; beeplengh<= l4 ; end
			10'd242:        begin tone <= NOTE_B4  ; beeplengh<= l8 ; end
			10'd243:        begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd244:        begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			10'd245:        begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			10'd246:        begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd247:        begin tone <=  NOTE_A4  ; beeplengh<= l4 ; end
			10'd248:        begin tone <=  REST  ; beeplengh<= l8 ; end
			10'd249:        begin tone <= REST  ; beeplengh<= l8 ; end
			10'd250:        begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			10'd251:        begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			10'd252:        begin tone <=  NOTE_FS5  ; beeplengh<= l4 ; end
			10'd253:        begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end
			10'd254:        begin tone <= NOTE_D5  ; beeplengh<= l2 ; end
			10'd255:        begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			10'd256:        begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			10'd257:        begin tone <=  NOTE_FS5  ; beeplengh<= l8 ; end
			10'd258:        begin tone <=  NOTE_E5  ; beeplengh<= l4 ; end
			10'd259:        begin tone <= NOTE_E5  ; beeplengh<= l8 ; end
			10'd260:        begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			10'd261:        begin tone <=  NOTE_FS5  ; beeplengh<= l8 ; end
			10'd262:        begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			10'd263:        begin tone <=  NOTE_A4  ; beeplengh<= l8 ; end
			10'd264:        begin tone <=  NOTE_A4  ; beeplengh<= l4 ; end
			10'd265:        begin tone <= REST  ; beeplengh<= l4d ; end
			10'd266:        begin tone <=  NOTE_A4  ; beeplengh<= l8 ; end
			10'd267:        begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd268:        begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			10'd269:        begin tone <=  NOTE_D5  ; beeplengh<= l8 ; end
			10'd270:        begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd271:        begin tone <= REST  ; beeplengh<= l8 ; end
			10'd272:        begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			10'd273:        begin tone <=  NOTE_FS5  ; beeplengh<= l8 ; end
			10'd274:        begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end
			10'd275:        begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			10'd276:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd277:        begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			10'd278:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd279:        begin tone <= NOTE_FS5  ; beeplengh<= l8d ; end
			10'd280:        begin tone <=  NOTE_FS5  ; beeplengh<= l8d ; end
			10'd281:        begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end
			10'd282:        begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			10'd283:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd284:        begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			10'd285:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd286:        begin tone <= NOTE_E5  ; beeplengh<= l8d ; end
			10'd287:        begin tone <=  NOTE_E5  ; beeplengh<= l8d ; end
			10'd288:        begin tone <=  NOTE_D5  ; beeplengh<= l8d ; end
			10'd289:        begin tone <=  NOTE_CS5  ; beeplengh<= l16 ; end
			10'd290:        begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd291:        begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			10'd292:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd293:        begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			10'd294:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd295:        begin tone <= NOTE_D5  ; beeplengh<= l4 ; end
			10'd296:        begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			10'd297:        begin tone <=  NOTE_CS5  ; beeplengh<= l8d ; end
			10'd298:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd299:        begin tone <=  NOTE_A4  ; beeplengh<= l4 ; end
			10'd300:        begin tone <=  NOTE_A4  ; beeplengh<= l8 ; end
			10'd301:        begin tone <= NOTE_E5  ; beeplengh<= l4 ; end
			10'd302:        begin tone <=  NOTE_D5  ; beeplengh<= l2 ; end
			10'd303:        begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			10'd304:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd305:        begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			10'd306:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd307:        begin tone <= NOTE_FS5  ; beeplengh<= l8d ; end
			10'd308:        begin tone <=  NOTE_FS5  ; beeplengh<= l8d ; end
			10'd309:        begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end
			10'd310:        begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			10'd311:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd312:        begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			10'd313:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd314:        begin tone <= NOTE_A5  ; beeplengh<= l4 ; end
			10'd315:        begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			10'd316:        begin tone <=  NOTE_D5  ; beeplengh<= l8d ; end
			10'd317:        begin tone <=  NOTE_CS5  ; beeplengh<= l16 ; end
			10'd318:        begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd319:        begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			10'd320:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd321:        begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			10'd322:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd323:        begin tone <= NOTE_D5  ; beeplengh<= l4 ; end
			10'd324:        begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			10'd325:        begin tone <=  NOTE_CS5  ; beeplengh<= l8d ; end
			10'd326:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd327:        begin tone <=  NOTE_A4  ; beeplengh<= l4 ; end
			10'd328:        begin tone <=  NOTE_A4  ; beeplengh<= l8 ; end
			10'd329:        begin tone <= NOTE_E5  ; beeplengh<= l4 ; end
			10'd330:        begin tone <=  NOTE_D5  ; beeplengh<= l2 ; end
			10'd331:        begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			10'd332:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd333:        begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			10'd334:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd335:        begin tone <= NOTE_FS5  ; beeplengh<= l8d ; end
			10'd336:        begin tone <=  NOTE_FS5  ; beeplengh<= l8d ; end
			10'd337:        begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end
			10'd338:        begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			10'd339:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd340:        begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			10'd341:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd342:        begin tone <= NOTE_A5  ; beeplengh<= l4 ; end
			10'd343:        begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			10'd344:        begin tone <=  NOTE_D5  ; beeplengh<= l8d ; end
			10'd345:        begin tone <=  NOTE_CS5  ; beeplengh<= l16 ; end
			10'd346:        begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd347:        begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			10'd348:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd349:        begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			10'd350:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd351:        begin tone <= NOTE_D5  ; beeplengh<= l4 ; end
			10'd352:        begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			10'd353:        begin tone <=  NOTE_CS5  ; beeplengh<= l8d ; end
			10'd354:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd355:        begin tone <=  NOTE_A4  ; beeplengh<= l4 ; end
			10'd356:        begin tone <=  NOTE_A4  ; beeplengh<= l8 ; end
			10'd357:        begin tone <= NOTE_E5  ; beeplengh<= l4 ; end
			10'd358:        begin tone <=  NOTE_D5  ; beeplengh<= l2 ; end
			10'd359:        begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			10'd360:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd361:        begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			10'd362:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd363:        begin tone <= NOTE_FS5  ; beeplengh<= l8d ; end
			10'd364:        begin tone <=  NOTE_FS5  ; beeplengh<= l8d ; end
			10'd365:        begin tone <=  NOTE_E5  ; beeplengh<= l4d ; end
			10'd366:        begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			10'd367:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd368:        begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			10'd369:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd370:        begin tone <= NOTE_A5  ; beeplengh<= l4 ; end
			10'd371:        begin tone <=  NOTE_CS5  ; beeplengh<= l8 ; end
			10'd372:        begin tone <=  NOTE_D5  ; beeplengh<= l8d ; end
			10'd373:        begin tone <=  NOTE_CS5  ; beeplengh<= l16 ; end
			10'd374:        begin tone <=  NOTE_B4  ; beeplengh<= l8 ; end
			10'd375:        begin tone <=  NOTE_A4  ; beeplengh<= l16 ; end
			10'd376:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd377:        begin tone <=  NOTE_D5  ; beeplengh<= l16 ; end
			10'd378:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd379:        begin tone <= NOTE_D5  ; beeplengh<= l4 ; end
			10'd380:        begin tone <=  NOTE_E5  ; beeplengh<= l8 ; end
			10'd381:        begin tone <=  NOTE_CS5  ; beeplengh<= l8d ; end
			10'd382:        begin tone <=  NOTE_B4  ; beeplengh<= l16 ; end
			10'd383:        begin tone <=  NOTE_A4  ; beeplengh<= l4 ; end
			10'd384:        begin tone <=  NOTE_A4  ; beeplengh<= l8 ; end
			10'd385:        begin tone <= NOTE_E5  ; beeplengh<= l4 ; end
			10'd386:        begin tone <=  NOTE_D5  ; beeplengh<= l2 ; end
			10'd387:        begin tone <=  REST  ; beeplengh<= l4 ; end
			endcase

	always@(posedge clk_khz , negedge enable)begin
		if(~enable)begin
			beep_enable <= 0;
			now <= 0;
			lengh <= 0;
			end
		else begin
			beep_enable <= 1;
			if(lengh > beeplengh)begin
				lengh <= 0;
				if(now < all)now <= now +1;
				end
			else lengh <= lengh+1;
			end
		end
	
	
	always@(posedge Clk) //毫秒計時器
			if(kcnt>25000)begin
				kcnt <= 0;
				clk_khz <= ~clk_khz;
				end
			else
				kcnt <= kcnt +1;
	
	always @(posedge Clk) //藉由蜂鳴器閃爍的頻率改變音調
		begin
			if(tone == 0)beep <= 0;
			else
				if (beep_enable)
					if(count > tone)begin
						count<=0;
						beep=~beep;
					end
					else
						count <= count+1;
				else
					beep <= 0;
		end
	
	

endmodule