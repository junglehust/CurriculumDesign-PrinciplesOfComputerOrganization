`timescale 1ns / 1ps
module DM(clk,addr,visin,Din,mode,we,clr,Dout,visout);
    input clk,we,clr;
    input [31:0] addr;
    input [3:0] visin;
    input [31:0] Din;
    input [3:0] mode;
    output reg [31:0] Dout;
    output [31:0] visout;
    
    reg [7:0] memory3 [0:1023];
    reg [7:0] memory2 [0:1023];
    reg [7:0] memory1 [0:1023];
    reg [7:0] memory0 [0:1023];
    reg [10:0] i;
    wire str1,str2,str3,str4;
    wire [9:0] addr1;
    
    initial begin
        for(i=0;i<1024;i=i+1)
            memory3[i]=8'b00000000;
        for(i=0;i<1024;i=i+1)
            memory2[i]=8'b00000000;
        for(i=0;i<1024;i=i+1)
            memory1[i]=8'b00000000;
        for(i=0;i<1024;i=i+1)
            memory0[i]=8'b00000000;
    end
    
    always @(posedge clk) begin
        if(clr) begin
            for(i=0;i<1024;i=i+1)
                memory3[i]=8'b00000000;
            for(i=0;i<1024;i=i+1)
                memory2[i]=8'b00000000;
            for(i=0;i<1024;i=i+1)
                memory1[i]=8'b00000000;
            for(i=0;i<1024;i=i+1)
                memory0[i]=8'b00000000;
        end
        if(str4) memory3[addr1][7:0]=Din[31:24];
        if(str3) memory2[addr1][7:0]=Din[23:16];
        if(str2) memory1[addr1][7:0]=Din[15:8];
        if(str1) memory0[addr1][7:0]=Din[7:0];
        if(mode[3])  Dout[31:24]=memory3[addr1][7:0];
        else Dout[31:24]=8'b00000000;
        if(mode[2])  Dout[23:16]=memory2[addr1][7:0];
        else Dout[23:16]=8'b00000000;
        if(mode[1])  Dout[15:8]=memory1[addr1][7:0];
        else Dout[15:8]=8'b00000000;
        if(mode[0])  Dout[7:0]=memory0[addr1][7:0];
        else Dout[7:0]=8'b00000000;
    end
    
    assign str4=we&mode[3];
    assign str3=we&mode[2];
    assign str2=we&mode[1];
    assign str1=we&mode[0];
    assign addr1[9:0]=addr[11:2];
    assign visout[31:24]=memory3[visin][7:0];
    assign visout[23:16]=memory2[visin][7:0];
    assign visout[15:8]=memory1[visin][7:0];
    assign visout[7:0]=memory0[visin][7:0];
endmodule
