module regfile(clk,rA,rB,w,rw,WE,A,B);
    input clk;
    input [4:0]rA;
    input [4:0]rB;
    input [31:0]w;
    input [4:0]rw;
    input WE;
    output reg [31:0]A;
    output reg [31:0]B;
    reg [31:0]memory[31:0];;
    always @(posedge clk) begin 
        memory[0]=0;
        
        if(WE==1)begin 
            
             memory[rw]=w;
        end
    end
    always @(*) begin
         A=memory[rA];
         B=memory[rB];
    end
endmodule
