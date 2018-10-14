`timescale 1ns / 1ps
module test_branch(

    );
	reg beq,bne,blez,syscall,equal;
	reg [31:0]alur;
	wire branch,bat;
	branch_halt _test_branch(
		beq,bne,blez,syscall,equal,alur,
		branch,bat
    );
	initial begin
		beq = 0;
		bne = 0;
		blez = 0;
		equal = 0;
		alur = 0;
		#20 beq = 1;
		#20 equal = 1;
		#20 bne = 1;
		beq = 0;
		#20 equal = 0;
		#20 bne = 0;
		blez = 1;
		#20 equal = 1;
		#20 alur = 1;
		#20 equal = 0;
		#20 alur = 0;
	end
endmodule
