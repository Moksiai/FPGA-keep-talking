module spin(
	output reg [2:0]color,
	input Clk,
	input iclk
);
	reg [7:0]cnt;
	reg [9:0] divcount;
	reg divclk;
	
	initial cnt <= 8'b0;
	
	always@(posedge Clk)//600 是測出來效果最好的
		if(divcount>600)begin
			divclk <= ~divclk;
			divcount <= 0;
		end
		else
			divcount <= divcount + 1;
	
	always@(posedge divclk)
		if(~iclk)
			cnt <= cnt+1'b1;
		else
			cnt <= 0;
	
	always@(posedge iclk)
		color <= cnt[7:5];
		
endmodule
		