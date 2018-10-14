module ctrl5(
	jal5,RegDin5,RegWrite5,
	syscall5,equal5,
	ctrl5
    );
	input [21:0]ctrl5;
	output jal5,RegDin5,RegWrite5,syscall5,equal5;
	assign jal5 = ctrl5[1];
	assign RegDin5 = ctrl5[7];
	assign RegWrite5 = ctrl5[8];
	assign syscall5 = ctrl5[12];
	assign equal5 = ctrl5[21];
endmodule
