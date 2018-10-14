`timescale 1ns / 1ps
module simu_decoder(
    );
        reg [31:0]instru; //ЦёБо
    wire  [5:0] op;
    wire  [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [4:0] shamt;
    wire [5:0] func;
    wire [15:0] ins16;
    wire [25:0] ins26;
         instruDecoder _instruDecoder(
       .instru(instru),.op(op),.rs(rs),.rt(rt),.rd(rd),.shamt(shamt),.func(func)
       ,.ins16(ins16), .ins26(ins26)
       );
    initial begin
        instru <= 32'h20110001;
        #50 instru <= 32'h08000c05;
        #50 instru <= 32'h20110001;
        #50 instru <= 32'h20120002;
    end
    
endmodule
