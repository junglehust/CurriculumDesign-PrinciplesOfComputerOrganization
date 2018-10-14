`timescale 1ns / 1ps
module test_IF_ID( );
	reg clk;
    reg rst;
    reg halt;
    reg [31:0] instru;
    reg [31:0] pc4;
    wire [31:0] instru_out;
    wire [31:0] pc4_out;
    IF_ID test_ifid(
    	clk,rst,halt,instru, pc4,
    	instru_out,pc4_out
    	);
    initial begin
    	clk = 0;
    	rst = 1;
    	halt = 1;
    	instru = 32'h01234567;
    	pc4 = 32'h87654321;
    	#20 rst = 0;
    	#100 rst = 1;
    	#100 rst = 0;
    	#50 halt = 0;
    	instru = 32'h87654321;
    	pc4 = 32'h01234567;
    end
    always begin
    	#5 clk = ~clk;
    end
endmodule
