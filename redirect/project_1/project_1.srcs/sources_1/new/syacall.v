module syscall(
	clk,rst,syscall,equal,reg2,
	syscallout
	);
    input clk,rst,syscall,equal;
    input [31:0]reg2;
    output reg[31:0]syscallout;
    wire enable;
    assign enable = syscall&(~equal);
    always @(posedge clk)begin
        if(rst)begin
        	syscallout <= 0;
        end
        else begin
        	if(enable==1)begin
        		syscallout <= reg2;
        	end
        	else begin
        		syscallout <= syscallout;
        	end
        end
    end
endmodule
