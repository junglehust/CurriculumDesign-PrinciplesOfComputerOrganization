module IF_ID(
    clk,rst,halt,instru, pc4,
    instru_out,pc4_out
    );
    input clk;
    input rst;
    input halt;
    input [31:0] instru;
    input [31:0] pc4;
    output reg [31:0] instru_out;
    output reg [31:0] pc4_out;
    always @(posedge clk) begin
        if(halt) begin
            if(rst) begin
                instru_out <= 0;
                pc4_out <= 0;
            end
            else begin
                instru_out <= instru;
                pc4_out <= pc4;
            end
        end
        else begin
            instru_out <= instru_out;
            pc4_out <= pc4_out;
        end
    end
endmodule
