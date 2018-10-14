module display(clk,rst,syscall,equal,reg2,syscallout);
    input clk,rst,syscall,equal;
    input [31:0]reg2;
    output [31:0]syscallout;
    reg [31:0]mem;
    reg enable;
    
    always @(posedge clk)begin
       
        enable=syscall&&(~equal);
        if(rst==0)begin mem=0;end
     if(enable==1)begin
         mem=reg2;
     end
      
    end
    assign syscallout=mem;
endmodule
