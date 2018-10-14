module SwitchFreq(select,CLK,clk);
    input [1:0]select;
    input CLK;
    output clk;
    wire clk1,clk2,clk3;
    divider #(100000000)  divider1
     (
        .clk(CLK),.clk_N(clk1)
        );
    divider #(10000000)  divider2
           (
              .clk(CLK),.clk_N(clk2)
              );
    divider #(1000000)  divider3
           (
              .clk(CLK),.clk_N(clk3)
              );
    assign clk = (select==0) ? clk1 :
      (select==1) ? clk2 :
      (select==2) ? clk3 :
      (select==3) ? CLK : 0;
endmodule
