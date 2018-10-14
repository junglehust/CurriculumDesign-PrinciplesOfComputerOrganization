`timescale 1ns / 1ps
module IM(pc,data);
    input [31:0] pc;
    output [31:0] data;
    
    reg [31:0] memory [0:255];
    wire [7:0] pc1;
    
    initial begin
        $readmemh("F:/benchmark.hex",memory);
    end
    
    assign pc1[7:0]=pc[9:2];
    assign data[31:0]=memory[pc1][31:0];
endmodule
