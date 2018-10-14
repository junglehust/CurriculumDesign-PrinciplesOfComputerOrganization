`timescale 1ns / 1ps
module simu_top( );
    reg rst,clk;
    reg [3:0]mem_addr;
    reg [2:0] dis_mode;
    reg swi_halt;
    reg swi_freq;
    wire [7:0] seg;       //七段显示输出
    wire [7:0] an;        //片选信号
    TopLayer _top(
        .rst(rst),.CLK(clk),.mem_addr(mem_addr),.dis_mode(dis_mode),
        .swi_halt(swi_halt),.swi_freq(swi_freq),.seg(seg),.an(an)
        );
    initial begin
        clk <=0;
        dis_mode = 0;
        swi_halt = 1;
        swi_freq = 0;
        mem_addr = 0;
        rst = 0;
        #200 rst=1;
    end
    always begin
        #15 clk <= ~clk;
    end
    
endmodule
