module branch_halt(
	beq,bne,blez,syscall,equal,alur,
	branch,bat
    );
	input beq,bne,blez,syscall,equal;
	input [31:0]alur;
	output branch,bat;
	assign bat = beq|bne|blez;
	assign branch = (equal&beq)|(bne&(~equal))|
		(blez&(equal|(alur==1)));
endmodule
