module led8x8(
	output reg [7:0]R,G,B,
	output [3:0]sele,
	input [2:0] show[7:0][7:0],
	input kclk,
	input enable
);

	reg [2:0]state;

	integer i;
	
	assign sele = {enable,state};
	
	always@(posedge kclk)
		state <= state+1;
	
	always@(posedge kclk)begin
		for(i=0;i<8;i=i+1)begin
			R[i] = show[state+1][i][2];
			G[i] = show[state+1][i][1];
			B[i] = show[state+1][i][0];
		end
	end
	
endmodule