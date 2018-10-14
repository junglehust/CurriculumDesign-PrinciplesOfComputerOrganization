module RegFiletoALU(A,B,shift,AluB_1,ins,syscall,aluX,aluY);
   input [31:0] A;
   input [31:0] B;
   input [31:0] ins;
   input AluB_1,shift,syscall;
   output reg[31:0] aluX;
   output reg[31:0] aluY;
   reg [31:0] X;
   reg [31:0] Y;
   always @(A,B,ins,AluB_1,shift,syscall) begin
   ////////////////////////////////////////
   case(shift)
   0:begin
   	aluX=A;
   	end
   1:begin
   	aluX=B;
    end
   default:begin
   	aluX=0;
   end
   endcase
   ///////////////////////////////////////
   case(syscall)
   0:begin
   	  if(AluB_1==0) begin
   	  	aluY=B;
   	  end
   	  else begin
   	  	aluY=ins;
   	  end
    end
   1:begin
   	 aluY=32'ha;
   end
   default:begin
   	 aluY=0;
   end
   endcase
  end
endmodule