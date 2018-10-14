module RegFileRead(jal,RegDst1,rd,rs,rt,syscall,rW,rA,rB);
   input jal,RegDst1,syscall;
   input [4:0] rd;
   input [4:0] rs;
   input [4:0] rt;
   output [4:0] rW;
   output [4:0] rA;
   output [4:0] rB;
   reg [4:0] rW;
   reg [4:0] rA;
   reg [4:0] rB;
   always @(jal,RegDst1,syscall,rd,rs,rt)
   begin
   case (jal)
   0:
   begin
   	if(RegDst1==0)
   	begin
   	  rW=rd;	
   	end
   	else begin
   	  rW=rt;
   	end
   end
   1:
   begin
   	rW=5'b11111;
   end
   default:begin
   	 rW=0;
   end
   endcase
   
   case (syscall)
   0:begin
   	 rA=rs;
   	 rB=rt;
   end
   1:begin
   	 rA=5'b00010;
   	 rB=5'b00100;
   end
   default:begin
   	 rA=0;
   	 rB=0;
   end
   endcase
   
   end
endmodule