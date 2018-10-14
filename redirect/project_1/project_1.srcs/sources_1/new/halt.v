module halt(
	rst,halt,swi_go,
	stall,j_rst,
    syscall,equal,
    enable1_2,rst2,rst3,halt3_5
    );
	input rst,swi_go;
	input stall,j_rst,syscall;
	input equal;
	output halt,halt3_5;
	output enable1_2,rst2,rst3;
	assign halt = ~(syscall & equal );
	assign halt3_5 = halt | swi_go;
	assign rst2 = rst | j_rst;
	assign rst3 = rst | j_rst | stall;
	assign enable1_2 = halt3_5 & (~stall);
endmodule
