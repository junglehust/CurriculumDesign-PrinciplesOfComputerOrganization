module counter(
	clk,rst,branch,bat,jump,ret,
	halt,stall,
    total,uncon,con,con_suc,pop
    );
    input clk,rst,branch,bat,jump,ret;
    input halt,stall;
    output reg[15:0] total,uncon,con,con_suc,pop;
    reg reg_halt;
    initial begin
        uncon <=0;
        con <=0;
        total <=0;
        con_suc <=0;
        pop <= 0;
    end
   always @ (posedge clk) begin
     if(rst) begin
        total <= 0;
        uncon <= 0;
        con <= 0;
        con_suc <= 0;
        pop <= 0;
     end
     else begin
        reg_halt <= halt;
        if(jump|ret) begin
            uncon <= uncon +1;
        end
        else begin
            uncon <= uncon;
        end
        if(bat) begin
            con <= con+1;
        end
        else begin
            con <= con;
        end
        if(halt | reg_halt) begin
            total <= total +1;
        end
        else begin
            total <= total;
        end
        if(branch) begin
            con_suc <= con_suc +1;
        end
        else begin
            con_suc <= con_suc;
        end
        if(stall) begin
        	pop <= pop + 1;
        end
        else begin
        	pop <= pop;
        end
     end
   end
         
endmodule
