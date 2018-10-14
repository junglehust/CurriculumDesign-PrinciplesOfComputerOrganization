module ctrl3(
	jump,ret,beq,bne,blez,
	RegDin3,aluB,shift3,
	syscall3,aluop,
	ctrl3
    );
	input [20:0]ctrl3;
	output jump,ret,beq,bne,blez;
	output RegDin3,aluB,shift3;
	output syscall3;
	output [3:0]aluop;
	assign jump = ctrl3[0];
	assign ret = ctrl3[2];
	assign beq = ctrl3[3];
	assign bne = ctrl3[4];
	assign blez = ctrl3[5];
	assign RegDin3 = ctrl3[7];
	assign aluB = ctrl3[10];
	assign shift3 = ctrl3[11];
	assign syscall3 = ctrl3[12];
	assign aluop = ctrl3[20:17];
endmodule
