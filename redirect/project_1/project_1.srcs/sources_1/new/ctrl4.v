module ctrl4(
	jal4,RegDin4,RegWrite4,DMWrite,mode,
	ctrl4
    );
	input [21:0]ctrl4;
	output jal4,RegDin4,RegWrite4,DMWrite;
	output [3:0]mode;
	assign jal4 = ctrl4[1];
	assign RegDin4 = ctrl4[7];
	assign RegWrite4 = ctrl4[8];
	assign DMWrite = ctrl4[9];
	assign mode = ctrl4[16:13];
endmodule
