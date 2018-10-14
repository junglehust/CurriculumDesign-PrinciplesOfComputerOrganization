`timescale 1ns / 1ps
module npc(jump,ret,branch,imm26,c16_32,reg1,pc4,pcout);
    input jump,ret,branch;
    input [25:0]imm26;
    input [31:0]c16_32;
    input [31:0]reg1;
    input [31:0]pc4;
    output  [31:0]pcout;
    wire [31:0] pc4_ins26;
    //reg [2:0] flag;
    assign pc4_ins26 = { pc4[31:28] , imm26 , 2'b00 };
    assign pcout = ret? reg1:
        jump? pc4_ins26:
        branch? (pc4+(c16_32<<2)): pc4;
endmodule
