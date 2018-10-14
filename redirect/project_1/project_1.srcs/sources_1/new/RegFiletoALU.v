module RegFiletoALU(
   reg1,reg2,ins,syscall3,shift3,AluB,sel,
   regDatain,aluR4,
   aluX,aluY,realreg1,realreg2
   );
   //sel array????
   input [31:0]reg1,reg2,ins,regDatain,aluR4;
   input syscall3,shift3,AluB;
   input [3:0]sel;
   output [31:0]aluX,aluY;
   output [31:0]realreg1,realreg2;
   wire [31:0]reg1_sel,reg2_sel;
   assign reg1_sel = sel[0] ? aluR4 :
      sel[2] ? regDatain : reg1;
   assign reg2_sel = sel[1] ? aluR4 :
      sel[3] ? regDatain : reg2;
   assign aluX = shift3 ? reg2_sel : reg1_sel;
   assign aluY = syscall3 ? 32'h0000000a : 
      AluB ? ins : reg2_sel;
   assign realreg1 = reg1_sel;
   assign realreg2 = reg2_sel;
endmodule