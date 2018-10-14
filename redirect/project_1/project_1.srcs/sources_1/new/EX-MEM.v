module EX_MEM(
	clk,rst,halt,
	rw,ctrl,aluR,reg2,pc4,
	aluR_out,reg2_out,pc4_out,
	rw_out,ctrl_out
    );
	input clk,rst,halt;
	input [4:0]rw;
	input [21:0]ctrl;
	input [31:0]aluR,reg2,pc4;
	output reg [31:0]aluR_out,reg2_out,pc4_out;
	output reg [4:0]rw_out;
	output reg [21:0]ctrl_out;
	always @(posedge clk) begin
		if(halt) begin//停机信号�?0时忽略时�?
			if(rst) begin
				aluR_out <= 0;
				reg2_out <= 0;
				pc4_out <= 0;
				rw_out <= 0;
				ctrl_out <= 0;
			end
			else begin
				aluR_out <= aluR;
				reg2_out <= reg2;
				pc4_out <= pc4;
				rw_out <= rw;
				ctrl_out <= ctrl;
			end
		end
		else begin
			aluR_out <= aluR_out;
			reg2_out <= reg2_out;
			pc4_out <= pc4_out;
			rw_out <= rw_out;
			ctrl_out <= ctrl_out;
		end
	end
endmodule
