`timescale 1ns / 1ps
module simu_npc(
    );
    reg jump,ret,branch;
    reg [25:0]imm26;
    reg [31:0]c16_32;
    reg [31:0]reg1;
    reg [31:0]pc4;
    output reg [31:0]pcout;
    npc test_npc(
        .jump(jump),.ret(ret),.branch(branch),.imm26(imm26),
        .c16_32(c16_32),.reg2(reg2),.pc4(pc4),.pcout(pcout)
        );
    initial begin
        
    end
endmodule
