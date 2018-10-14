`timescale 1ns / 1ps
module counter( clk,rst,branch,bat,jump,return1,syscall,equal,
                total,uncon,con,con_suc);
   input clk;
   input rst;
   input branch;
   input bat;
   input jump;
   input return1;
   input syscall;
   input equal;
   output reg[15:0] total;
   output reg[15:0] uncon;
   output reg[15:0] con;
   output reg[15:0] con_suc;
   wire halt;
   reg reg_halt;
   wire or_jump_return1;
   assign or_jump_return1 = jump | return1;
   assign halt = ~(syscall & equal);
   initial begin
           uncon <=0;
           con <=0;
           total <=0;
           con_suc <=0;
   end
   always @(posedge clk) begin
     reg_halt <= halt;
   end
   always @ (posedge clk or posedge rst) begin
     if(rst) begin
        total = 0;
        uncon = 0;
        con = 0;
        con_suc = 0;
     end
     else begin
     //无条件分支
        if(or_jump_return1)
            uncon <= uncon +1;
        else
            uncon <= uncon;
     //有条件分支
        if(bat)
            con <= con+1;
        else
            con <= con;
     //总周期
        if(halt | reg_halt)
            total <= total +1;
        else
            total <= total;
     //有条件分支成功跳转
        if(branch)
            con_suc <= con_suc +1;
        else
            con_suc <= con_suc;
     end
   end
         
endmodule
