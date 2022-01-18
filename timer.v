module timer(
	output reg [3:0] num [3:0],
	output over,
	input reset,enable,Clk  //reset為0重制  enable為1啟動   Clk 1hz
);

	assign over = (reset)?(num[3]==0 && num[2]==0 && num[1]==0 && num[0]==0):0;
	
	always@(posedge Clk or negedge reset)
		if(~reset)
			num[0] <= 4'd0;
		else if(enable)
			if(num[0]==0)num[0]<=9;
			else num[0] <= num[0] -1;
			
			
	always@(posedge num[0][3]or negedge reset)
		if(~reset)
			num[1] <= 4'd0;
		else
			if(num[1]==0)num[1] <= 5;
			else num[1] <= num[1]-1;
	
	always@(posedge num[1][2]or negedge reset)
		if(~reset)
			num[2] <= 4'd5;
		else
			if(num[2]==0)num[2] <= 9;
			else num[2] <= num[2]-1;
	
	always@(posedge num[2][3]or negedge reset)
		if(~reset)
			num[3] <= 4'd0;
		else
			if(num[3]==0)num[3] <= 5;
			else num[3] <= num[3]-1;
		
endmodule

module segshow(
	output reg [7:0]ag,		//對應A-G、dot
	output reg [3:0]com,		//com1-4
	input [3:0] num [3:0],  //4個數字
	input Clk,					//1KHz
	input dot
); 
	reg [1:0]state;
	wire [6:0]n3,n2,n1,n0;
	
	bcd7 N3(n3,num[3]),
		  N2(n2,num[2]),
		  N1(n1,num[1]),
		  N0(n0,num[0]);
		  
	initial begin
		com <= 4'b1110;
	end
	
	always@(posedge Clk)
		state <= state +1;

	
	always@(posedge Clk)
		case(state)
			2'd0:begin com <= 4'b0111; ag <= {n3,dot}; end
			2'd1:begin com <= 4'b1011; ag <= {n2,dot}; end
			2'd2:begin com <= 4'b1101; ag <= {n1,dot}; end
			2'd3:begin com <= 4'b1110; ag <= {n0,dot}; end
		endcase
		
endmodule

module bcd7(output reg [6:0]s, input [3:0] bcd);

	always@(bcd)
		case(bcd)
			4'b0000: s <= 7'b0000001;
			4'b0001: s <= 7'b1001111;
			4'b0010: s <= 7'b0010010;
			4'b0011: s <= 7'b0000110;
			4'b0100: s <= 7'b1001100;
			4'b0101: s <= 7'b0100100;
			4'b0110: s <= 7'b0100000;
			4'b0111: s <= 7'b0001111;
			4'b1000: s <= 7'b0000000;
			4'b1001: s <= 7'b0000100;
			default: s <= 7'b1111111;
		endcase
endmodule