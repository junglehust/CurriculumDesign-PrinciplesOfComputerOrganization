module MEM_WB(
	clk,rst,halt,
	rw,ctrl,DMout,pc4,aluR,
	DMout_out,pc4_out,aluR_out,ctrl_out,rw_out
    );
	input clk,rst,halt;
	input [21:0]ctrl;
	input [4:0]rw;
	input [31:0]DMout,pc4,aluR;
	output reg [4:0]rw_out;
	output reg [21:0]ctrl_out;
	output reg [31:0]DMout_out,pc4_out,aluR_out;
	always @(posedge clk) begin
		if(halt) begin//停机信号为0时忽略时钟
			if(rst) begin
				rw_out <= 0;
				ctrl_out <= 0;
				pc4_out <= 0;
				aluR_out <= 0;
				DMout_out <= 0;
			end
			else begin
				rw_out <= rw;
				ctrl_out <= ctrl;
				pc4_out <= pc4;
				aluR_out <= aluR;
				DMout_out <= DMout;
			end
		end
		else begin
			rw_out <= rw_out;
			ctrl_out <= ctrl_out;
			pc4_out <= pc4_out;
			aluR_out <= aluR_out;
			DMout_out <= DMout_out;
		end
	end
endmodule
