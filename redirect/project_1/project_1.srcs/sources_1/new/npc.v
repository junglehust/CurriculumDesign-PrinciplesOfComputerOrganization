module npc(
	jump,branch,ret,pc4,pc4_3,
	ins26,ins16_32,reg1,
	pcout
    );
	input jump,branch,ret;
	input [31:0]pc4,pc4_3,ins16_32,reg1;
	input [25:0]ins26;
	output [31:0]pcout;
    wire [31:0] pc4_ins26;
    assign pc4_ins26 = { pc4[31:28] , ins26 , 2'b00 };
    assign pcout = ret? reg1:
        jump? pc4_ins26:
        branch? (pc4_3+(ins16_32<<2)): pc4;
endmodule
