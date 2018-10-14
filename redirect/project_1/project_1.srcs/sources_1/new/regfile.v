module regfile(clk,rA,rB,w,rw,WE,A,B);
    input clk;
    input [4:0]rA;
    input [4:0]rB;
    input [31:0]w;
    input [4:0]rw;
    input WE;
    output reg [31:0]A;
    output reg [31:0]B;
    reg [31:0]memory[31:0];
    always @(negedge clk) begin//下降沿
        memory[0]=0;
        if(WE==1)begin
            memory[rw]=w;
        end
        else begin
        	memory[rw] = memory[rw];
        end
    end
    always @(*) begin
        A=memory[rA];
        B=memory[rB];
    end
endmodule
