//rst==0 ?? rst == 1?? check every module
module TopLayer(
    RST,CLK,mem_addr,dis_mode,
    swi_halt,swi_freq,seg,an,
    swi_go
    );
    input RST;
    input CLK;
    input [3:0] mem_addr;
    input [2:0] dis_mode;
    input swi_halt,swi_go;
    input [1:0]swi_freq;
    output [7:0] seg;       //Æß¶ÎÏÔÊ¾Êä³ö
    output [7:0] an;        //Æ¬Ñ¡ÐÅºÅ

    wire clk,clk_dis,rst;
    wire [31:0] mem_dis;
    wire branch,bat,jump,ret;
    wire stall,halt,halt3_5;
    wire [15:0]total,uncon,con,con_suc,loaduse;
    wire syscall5,equal5,j_rst;
    wire rst2,rst3,enable1_2;
    wire [31:0]pc,pcout;
    wire [31:0]pc4,pc4_2,pc4_3,pc4_4,pc4_5;
    wire [31:0]instru,instru_2;
    wire [5:0]op,func;
    wire [4:0]rs,rt,rd;
    wire [31:0]ins16_32,ins,ins16_32_3,ins_3;
    wire [25:0]ins26,ins26_3;
    wire [4:0]ra,rb, ra_3,rb_3;
    wire ra_r,rb_r, ra_r_3,rb_r_3;
    wire [4:0]rw_3,rw_4,rw_5;
    wire [20:0]ctrl,ctrl_3;
    wire [21:0]ctrl_4,ctrl_5;
    wire jump2,jal2,ret2,beq2,bne2,blez2,unsign2;
    wire regdst2,regdin2,regwrite2,dmwrite2,alub2;
    wire shift2,syscall2;
    wire [3:0]mode2,aluop2;
    wire [31:0]regdata,syscallout;
    wire beq3,bne3,blez3,regdin3,alub,shift3,syscall3;
    wire [3:0]aluop, sel;
    wire equal,equal_5;
    wire [31:0]realreg1,realreg2,aluX,aluY;
    wire [31:0]aluR,aluR_4,aluR_5;
    wire jal4,regdin4,regwrite4,dmwrite;
    wire [3:0]mode;
    wire [31:0]DMout,DMout_5;
    wire jal5,regdin5,regwrite5;
    wire [31:0]reg1,reg2, reg1_3,reg2_3,reg2_4;

    buffer _buf(
        .Rst(RST),.rst(rst)
        );
    display2 _dis2(
        .clk_N(clk_dis),.SysCallOut(syscallout),.Total(total),
        .Uncon(uncon),.Con(con),.Con_suc(con_suc),.Pc(pc[11:2]),
        .pop(loaduse),.Mode(dis_mode),.MemDisPlay(mem_dis),
        .seg(seg),.an(an)
        );
    DM _dm(
        .clk(clk),.DMwrite(dmwrite),.addr(reg2_4),
        .Din(aluR_4),.visin(mem_addr),.mode(mode),.Dout(DMout),
        .visout(mem_dis)
        );
    MEM_WB _mem_wb(
        .clk(clk),.rst(rst),.halt(halt3_5),.ctrl(ctrl_4),
        .rw(rw_4),.DMout(DMout),.pc4(pc4_4),.aluR(aluR_4),
        .rw_out(rw_5),.ctrl_out(ctrl_5),.DMout_out(DMout_5),
        .pc4_out(pc4_5),.aluR_out(aluR_5)
        );
    ctrl5 _ctrl5(
        .ctrl5(ctrl_5),.jal5(jal5),.RegDin5(regdin5),
        .RegWrite5(regwrite5),.syscall5(syscall5),.equal5(equal5)
        );
    ctrl4 _ctrl4(
        .ctrl4(ctrl_4),.jal4(jal4),.RegDin4(regdin4),
        .RegWrite4(regwrite4),.DMWrite(dmwrite),.mode(mode)
        );
    EX_MEM _ex_mem(
        .clk(clk),.rst(rst),.halt(halt3_5),.rw(rw_3),
        .ctrl({equal,ctrl_3}),.aluR(aluR),.reg2(realreg2),
        .pc4(pc4_3),.aluR_out(aluR_4),.reg2_out(reg2_4),
        .pc4_out(pc4_4),.rw_out(rw_4),.ctrl_out(ctrl_4)
        );
    syscall _sys(
        .clk(clk),.rst(rst),.syscall(syscall3),
        .equal(equal),.reg2(realreg2),.syscallout(syscallout)
        );
    RegFiletoALU _regtoalu(
        .reg1(reg1_3),.reg2(reg2_3),.ins(ins_3),
        .regDatain(regdata),.aluR4(aluR_4),
        .syscall3(syscall3),.shift3(shift3),.AluB(alub),
        .sel(sel),.aluX(aluX),.aluY(aluY),
        .realreg1(realreg1),.realreg2(realreg2)
        );
    ALU _alu(
        .X(aluX),.Y(aluY),.S(aluop),
        .Result1(aluR),.Equal(equal)
        );
    branch_halt _branch(
        .beq(beq3),.bne(bne3),.blez(blez3),.syscall(syscall3),
        .equal(equal),.alur(aluR),.branch(branch),.bat(bat)
        );
    redirect _redirect(
        .ra_r(ra_r_3),.rb_r(rb_r_3),.regWrite4(regwrite4),
        .regWrite5(regwrite5),.regDin4(regdin4),.jal4(jal4),
        .ra(ra_3),.rb(rb_3),.rw4(rw_4),.rw5(rw_5),.sel(sel)
        );
    ctrl3 _ctrl3(
        .ctrl3(ctrl_3),.jump(jump),.ret(ret),
        .beq(beq3),.bne(bne3),.blez(blez3),
        .RegDin3(regdin3),.aluB(alub),.shift3(shift3),
        .syscall3(syscall3),.aluop(aluop)
        );
    halt _halt(
        .rst(rst),.stall(stall),.j_rst(j_rst),.swi_go(swi_go),
        .halt3_5(halt3_5),
        .syscall(syscall5),.equal(equal5),.halt(halt),
        .enable1_2(enable1_2),.rst2(rst2),.rst3(rst3)
        );
    pc _pc(
        .clk(clk),.rst(rst),.enable(enable1_2),
        .pcout(pcout),.pc(pc),.pc4(pc4)
        );
    npc _npc(
        .jump(jump),.branch(branch),.ret(ret),
        .pc4(pc4),.pc4_3(pc4_3),.ins16_32(ins16_32_3),
        .reg1(realreg1),.ins26(ins26_3),.pcout(pcout)
        );
    IM _IM(
        .pc(pc),.instru(instru)
        );
    counter _counter(//halt?????
        .clk(clk),.rst(rst),.branch(branch),.bat(bat),
        .jump(jump),.ret(ret),.halt(halt),.stall(stall),
        .total(total),.uncon(uncon),.con(con),
        .con_suc(con_suc),.pop(loaduse)
        );
    IF_ID _IF_ID(
        .clk(clk),.rst(rst2),.halt(enable1_2),.instru(instru),
        .pc4(pc4),.instru_out(instru_2),.pc4_out(pc4_2)
        );
    regfile _regfile(
        .clk(clk),.rA(ra),.rB(rb),.w(regdata),.rw(rw_5),
        .WE(regwrite5),.A(reg1),.B(reg2)
        );
    IR_Extern _ir_ext(
        .instru(instru_2),.shift(shift2),.unsign(unsign2),
        .op(op),.func(func),.rs(rs),.rt(rt),.rd(rd),
        .ins16_32(ins16_32),.ins(ins),.ins26(ins26)
    );
    ID_EX _ID_EX(
        .clk(clk),.rst(rst3),.halt(halt3_5),
        .rd(rd),.rt(rt),.ra(ra),.rb(rb),
        .ra_r(ra_r),.rb_r(rb_r),.reg1(reg1),.reg2(reg2),
        .ins(ins),.pc4(pc4_2),.ins16_32(ins16_32),.ctrl(ctrl),
        .ins26(ins26),.reg1_out(reg1_3),.reg2_out(reg2_3),
        .ins_out(ins_3),.pc4_out(pc4_3),.ins16_32_out(ins16_32_3),
        .ctrl_out(ctrl_3),.ins26_out(ins26_3),.ra_out(ra_3),
        .rb_out(rb_3),.rw_out(rw_3),
        .ra_r_out(ra_r_3),.rb_r_out(rb_r_3)
        );
    control _control(
        .op(op),.func(func),.jump(jump2),.jal(jal2),
        .jr(ret2),.beq(beq2),.bne(bne2),.blez(blez2),
        .unsign(unsign2),.RegDst(regdst2),.RegDin(regdin2),
        .RegWrite(regwrite2),.sw(dmwrite2),.AluB(alub2),
        .shift(shift2),.syscall(syscall2),.ra_r(ra_r),
        .rb_r(rb_r),.mode(mode2),.aluop(aluop2)
        );
    ctrl2 _ctrl2(
        .jump(jump2),.jal(jal2),.ret(ret2),.beq(beq2),
        .bne(bne2),.blez(blez2),.RegDst(regdst2),
        .RegDin(regdin2),.RegWrite(regwrite2),
        .DMWrite(dmwrite2),.aluB(alub2),.shift(shift2),
        .syscall(syscall2),.mode(mode2),.aluop(aluop2),
        .ctrl2(ctrl)
        );
    RegFileRead _regread(
        .syscall(syscall2),.rs(rs),.rt(rt),
        .ra(ra),.rb(rb)
        );
    RegFileWrite _regwrite(
        .RegDin5(regdin5),.jal5(jal5),.aluR5(aluR_5),
        .DMout5(DMout_5),.pc4_5(pc4_5),.RegW_out(regdata)
        );
    loaduse _loaduse(
        .ra_r(ra_r),.rb_r(rb_r),.RegDin3(regdin3),
        .jump(jump),.branch(branch),.ret(ret),
        .ra(ra),.rb(rb),.rw3(rw_3),
        .stall(stall),.j_rst(j_rst)
        );
     divider #(100000)  divider_dis(
        .clk(CLK),.clk_N(clk_dis)
        );
     SwitchFreq _swifreq(
        .select(swi_freq),.clk(clk),.CLK(CLK)
        );
endmodule
