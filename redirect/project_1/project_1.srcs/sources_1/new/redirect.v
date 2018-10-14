module redirect(
	ra_r,rb_r,regWrite4,regWrite5,
	regDin4,jal4,ra,rb,rw4,rw5,
	sel
    );
	input ra_r,rb_r,regWrite4,regWrite5;
	input regDin4,jal4;
	input [4:0]ra,rb,rw4,rw5;
	output [3:0]sel;
	assign sel[0] = ra_r & (rw4==ra) & (rw4!=0) & (~regDin4)
					& (~jal4) & regWrite4;
	assign sel[1] = rb_r & (rw4==rb) & (rw4!=0) & (~regDin4)
					& (~jal4) & regWrite4;
	assign sel[2] = ra_r & (rw5==ra) & regWrite5;
	assign sel[3] = rb_r & (rw5==rb) & regWrite5;
endmodule
