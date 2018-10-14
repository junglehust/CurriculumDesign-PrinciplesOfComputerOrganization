`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module instruDecoder(
    instru, op,rs,rt,rd,shamt,func,ins16,ins26
    );
    input [31:0]instru; //Ö¸Áî
    output  [5:0] op;
    output  [4:0] rs;
    output [4:0] rt;
    output [4:0] rd;
    output [4:0] shamt;
    output [5:0] func;
    output [15:0] ins16;
    output [25:0] ins26;
    assign op = instru[31:26];
    assign rs = instru[25:21];
    assign rt = instru[20:16];
    assign rd = instru[15:11];
    assign shamt = instru[10:6];
    assign func = instru[5:0];
    assign ins16 = instru[15:0];
    assign ins26 = instru[25:0];
endmodule
