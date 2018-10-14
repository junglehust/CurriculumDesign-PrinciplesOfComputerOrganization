`timescale 1ns / 1ps
module test_top( );
    reg RST;
    reg CLK;
    reg [3:0] mem_addr;
    reg [2:0] dis_mode;
    reg swi_halt,swi_go;
    reg [1:0]swi_freq;
    wire [7:0] seg;
    wire [7:0] an;
    TopLayer test_toplayer(
    	.RST(RST),.CLK(CLK),.mem_addr(mem_addr),
    	.dis_mode(dis_mode),.swi_halt(swi_halt),
    	.swi_go(swi_go),.swi_freq(swi_freq),
    	.seg(seg),.an(an)
    	);
    always begin
    	#5 CLK <= ~CLK;
    end
    initial begin
    	swi_freq = 3;
    	RST = 1;
    	CLK = 0;
    	mem_addr = 0;
    	dis_mode = 0;
    	swi_halt = 1;
    	swi_go = 0;
    	#15 RST = 0;
    	#60 RST = 1;
    end
endmodule
