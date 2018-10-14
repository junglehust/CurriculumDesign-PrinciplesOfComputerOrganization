module pc(
    clk,rst,enable,pcout,pc,pc4
    );
    input clk,rst,enable;
    input [31:0] pcout;
    output reg[31:0] pc;
    output [31:0] pc4;
    assign pc4 = pc + 4;
    initial begin
        pc <= 0;
    end
    always@(posedge clk) begin
        if(rst) begin
            pc <= 0;
        end
        else begin
            if(0==enable)begin
                pc <= pc;
            end
            else begin
                pc <= pcout;
            end
        end
    end
endmodule
