module loaduse(
	ra_r,rb_r,RegDin3,
	jump,branch,ret,
	ra,rb,rw3,stall,j_rst
    );
	input ra_r,rb_r,RegDin3,jump,branch,ret;
	input [4:0]ra,rb,rw3;
	output stall,j_rst;
	wire and1,and2;
	assign j_rst = jump|ret|branch;
	assign and1 = ra_r & (ra==rw3);
	assign and2 = rb_r & (rb==rw3);
	assign stall = RegDin3 & (and1|and2);
endmodule
