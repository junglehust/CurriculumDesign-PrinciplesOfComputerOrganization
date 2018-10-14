`timescale 1ns / 1ps
module pc(
    clk,rst,halt,pcout,pc,pc4
    );
    input clk,rst,halt;
    input [31:0] pcout;
    output reg[31:0] pc;
    output [31:0] pc4;
    assign pc4 = pc + 4;
    initial begin
        pc <= 0;
    end
    always@(posedge clk) begin
        if(0==rst) begin
            pc <= 0;
        end
        else begin
            if(halt) begin
                pc <= pcout;
            end
            //µÍµçÆ½Í£»ú
            else begin
                pc <= pc;
            end 
        end
    end
endmodule
