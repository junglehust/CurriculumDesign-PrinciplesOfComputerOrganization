module divider
#(parameter N = 100_000)
 (clk,clk_N);
    input clk;
    output reg clk_N;
    reg [31:0] counter;
initial begin
   counter = 0; 
   clk_N = 0;
end
always @(posedge clk) begin
    if(counter == N/2 - 1)begin 
    	counter <= 0;
    	clk_N <= ~clk_N;
    end
    else 	counter <= counter + 1;
end                           
endmodule
