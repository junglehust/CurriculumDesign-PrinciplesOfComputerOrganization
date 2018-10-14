module RegFileWrite(
    RegDin5,jal5,aluR5,DMout5,pc4_5,RegW_out
  );
    input RegDin5,jal5;
    input [31:0]aluR5,DMout5,pc4_5;
    output [31:0]RegW_out;
    assign RegW_out = jal5 ? pc4_5 :
      RegDin5 ? DMout5 : aluR5;
endmodule