module DM(clk,addr,visin,Din,mode,we,Dout,visout);
    input clk,we;
    input [31:0] addr;
    input [3:0] visin;
    input [31:0] Din;
    input [3:0] mode;
    output reg [31:0] Dout;
    output [31:0] visout;
    
    reg [31:0] memory [0:1023];
    integer i;
    wire str1,str2,str3,str4;
    wire [9:0] addr1;

    always @(posedge clk) begin
        if(str4) memory[addr1][31:24]=Din[31:24];
        else memory[addr1][31:24] = memory[addr1][31:24];
        if(str3) memory[addr1][23:16]=Din[23:16];
        else  memory[addr1][23:16] =  memory[addr1][23:16];
        if(str2) memory[addr1][15:8]=Din[15:8];
        else  memory[addr1][15:8] =  memory[addr1][15:8];
        if(str1) memory[addr1][7:0]=Din[7:0];
        else  memory[addr1][7:0] =  memory[addr1][7:0];

       
    end 
    
     always @(*) begin
            if(mode[3])  Dout[31:24]=memory[addr1][31:24];
            else Dout[31:24]=8'b00000000;
            if(mode[2])  Dout[23:16]=memory[addr1][23:16];
            else Dout[23:16]=8'b00000000;
            if(mode[1])  Dout[15:8]=memory[addr1][15:8];
            else Dout[15:8]=8'b00000000;
            if(mode[0])  Dout[7:0]=memory[addr1][7:0];
            else Dout[7:0]=8'b00000000;
     end
    assign str4=we & mode[3];
    assign str3=we & mode[2];
    assign str2=we & mode[1];
    assign str1=we & mode[0];
    assign addr1[9:0]=addr[11:2];
    assign visout=memory[visin];
endmodule
