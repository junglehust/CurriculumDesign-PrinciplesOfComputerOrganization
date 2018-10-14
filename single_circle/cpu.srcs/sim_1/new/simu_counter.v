`timescale 1ns / 1ps
module simu_counter( );
   reg clk;
reg rst;
reg branch;
reg bat;
reg jump;
reg return1;
reg syscall;
reg equal;
wire [15:0] total;
wire [15:0] uncon;
wire [15:0] con;
wire [15:0] con_suc;
    counter test_counter(
        .clk(clk),.rst(rst),.branch(branch),.bat(bat),
        .jump(jump),.return1(return1),.syscall(syscall),
        .total(total),.uncon(uncon),.con(con),.con_suc(con_suc) 
        );
    always begin
        #15 clk <= ~clk;
    end
    initial begin
        clk <= 0;
        rst <=0;
        branch <= 0;
        bat <=0;
        jump <= 0;
        return1 <=0;
        syscall <=0;
        equal <= 0;
        #200 bat = 1;
        #20 branch = 1;
        #50 jump = 1;
        syscall <=1;
        #50 return1<=1;
        #50 jump = 0;
        //equal <= 1;
        #20 return1 =0;
        equal = 1;
        #100 rst = 1;
        #100 rst = 0;
        syscall =0;
    end
endmodule
