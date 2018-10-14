`timescale 1ns / 1ps
module show_display(value,
    clk_N,  seg, an
    );
    input clk_N;            // 时钟
    input [31:0] value;
    output reg[7:0] seg;   // 分别对应CA、CB、CC、CD、CE、CF、CG和DP
    output reg [7:0] an;   // 8位数码管片选信号
    reg [3:0]code;         //待显示数字二进制码
    reg [2:0]num;          //计数器输出
    reg [2:0]num_t;         //计数器输出的旧值
initial begin
     an <= 8'b10111111;
     num <= 3'b110;
     seg <= 8'b11111111;
     code <= 4'b1111;
     num_t <= 3'b000;
end
always @( posedge clk_N)begin
    num_t = num;
    if(num[2:0] == 3'b111)  num[2:0] = 3'b000;// 计时器
    else      num[2:0] = num[2:0] + 1;
    
    //片选信号发生改变时触发
    if( num[2:0] != num_t[2:0] ) begin
        case(num)
            3'b000: begin an[7:0] = 8'b11111110;code[3:0]=value[3:0]; end
            3'b001: begin an[7:0] = 8'b11111101;code[3:0]=value[7:4]; end
            3'b010: begin an[7:0] = 8'b11111011;code[3:0]=value[11:8]; end
            3'b011: begin an[7:0] = 8'b11110111;code[3:0]=value[15:12]; end
            3'b100: begin an[7:0] = 8'b11101111;code[3:0]=value[19:16]; end
            3'b101: begin an[7:0] = 8'b11011111;code[3:0]=value[23:20]; end
            3'b110: begin an[7:0] = 8'b10111111;code[3:0]=value[27:24]; end
            3'b111: begin an[7:0] = 8'b01111111;code[3:0]=value[31:28]; end
        endcase
    end
    else   an = an;


    //将待显示数字的二进制代码转换为七段数码管编码
    case(code[3:0])
             4'b0000: seg[7:0] = 8'b11000000;
             4'b0001: seg[7:0] = 8'b11111001;
             4'b0010: seg[7:0] = 8'b10100100;
             4'b0011: seg[7:0] = 8'b10110000;
             4'b0100: seg[7:0] = 8'b10011001;
             4'b0101: seg[7:0] = 8'b10010010;
             4'b0110: seg[7:0] = 8'b10000010;
             4'b0111: seg[7:0] = 8'b11111000;
             4'b1000: seg[7:0] = 8'b10000000;
             4'b1001: seg[7:0] = 8'b10010000;
             4'b1010: seg[7:0] = 8'b10001000;  //A
             4'b1011: seg[7:0] = 8'b10000011;  //B
             4'b1100: seg[7:0] = 8'b11000110;  //C
             4'b1101: seg[7:0] = 8'b10100001;  //D
             4'b1110: seg[7:0] = 8'b10000110;  //E
             4'b1111: seg[7:0] = 8'b10001110;  //F
             default: seg[7:0] = 8'b11111111;  //全灭
    endcase
end
endmodule