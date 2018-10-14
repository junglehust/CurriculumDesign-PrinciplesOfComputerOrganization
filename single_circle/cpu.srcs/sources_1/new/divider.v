`timescale 1ns / 1ps
/*
    对系统时钟进行分频，参数N可以任意改变，将时钟降到不同频率 
*/
module divider
#(parameter N = 100_000)
 (clk,parameterN,clk_N);
    input clk;                      // 系统时钟
    input [3:0] parameterN;              //分频参数
    output reg clk_N;               // 分频后的时钟
    reg [31:0] counter;             /* 计数器变量，通过计数实现分频。
                                   当计数器从0计数到(N/2-1)时，
                                   输出时钟翻转，计数器清零 */
initial begin
   counter = 0; 
   clk_N = 0;
end
always @(posedge clk)  begin    // 时钟上升沿
    if(counter == N*parameterN/2 - 1)begin 
    	counter = 0;
    	clk_N = ~clk_N;
    end
    else 	counter = counter + 1;
end                           
endmodule
