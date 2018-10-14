module TopLayer(
    rst,CLK,mem_addr,dis_mode,swi_halt,swi_freq,seg,an
     );
     input rst;
     input CLK;
     input [3:0] mem_addr;
     input [2:0] dis_mode;
     input swi_halt;
     input swi_freq;
     output [7:0] seg;       //七段显示输出
     output [7:0] an;        //片选信号
     wire clk,clk_dis;
     wire [31:0] mem_dis;
     //操作控制器
     wire jump;
     wire branch;
     wire return1;
     wire RegDst1;
     wire jal;
     wire RegDin1;
     wire shift;
     wire AluB1;
     wire syscall;
     wire RegWrite;
     wire [3:0]ALUOP;
     wire DMWrite;
     wire [3:0]mode;
     wire bat;
     //寄存器文件
     wire [31:0] regin;
     wire [4:0]rW;
     wire [4:0]rA,rB;
     wire [31:0]reg1,reg2;
     //指令解析器
     wire [31:0] instru;
     wire [4:0]rd,rs,rt;
     wire [5:0]op,func;
     wire [25:0]ins26;
     wire [15:0]ins16;
     wire [4:0]shamt;
     //扩展器
     wire [31:0]ins16_32;
     wire [31:0]ins;
     //npc
     wire [31:0]pcout, pc4,pc;
     //计数器
     wire [15:0]total,uncon,con,con_suc;
     //alu
     wire [31:0]aluX,aluY;
     wire equal;
     wire [31:0]aluR;
     //数据存储器
     wire [31:0] DMout;
     //display
     wire [31:0]SyscallOut;;
    
     wire halt;
     halt _halt(
        .syscall(syscall),.equal(equal),.swi_halt(swi_halt),.halt(halt)
        );
     display2 _display2(
        .Mode(dis_mode),.Pc(pc[17:2]),.SysCallOut(SyscallOut),
        .Total(total),.Uncon(uncon),.Con(con),.Con_suc(con_suc),
        .clk_N(clk_dis),.seg(seg),.an(an),.MemDisPlay(mem_dis)
        );
     divider #(100000)  divider_dis(
        .clk(CLK),.parameterN(1),.clk_N(clk_dis)
        );
     SwitchFreq _swifreq(
        .select(swi_freq),.clk(clk),.CLK(CLK)
        );
     controller _controller(
        .op(op),.func(func),.alur(aluR),.equal(equal),.jump(jump),.branch(branch),
        .ret(return1),.RegDst1(RegDst1),.jal(jal),.RegDin1(RegDin1),.shift(shift),
        .ALUOP(ALUOP),.syscall(syscall),.RegWrite(RegWrite),.sw(DMWrite),
        .mode(mode),.bat(bat),.AluB1(AluB1)
        );
     regfile _regfile(
        .clk(clk),.rA(rA),.rB(rB),.w(regin),.rw(rW),.WE(RegWrite),.A(reg1),.B(reg2)
        );
     instruDecoder _instruDecoder(
        .instru(instru),.op(op),.rs(rs),.rt(rt),.rd(rd),.shamt(shamt),.func(func)
        ,.ins16(ins16), .ins26(ins26)
        );
     ALU _alu(
        .X(aluX),.Y(aluY),.S(ALUOP),.Result1(aluR),.Equal(equal)
        );
     npc _npc(
        .jump(jump),.ret(return1),.branch(branch),.imm26(ins26),.c16_32(ins16_32),.reg1(reg1),
        .pc4(pc4),.pcout(pcout)
        );
     pc _pc(
        .clk(clk),.rst(rst),.halt(halt),.pcout(pcout),.pc(pc),.pc4(pc4)
        );
     counter _counter(
        .clk(clk),.rst(rst),.branch(branch),.bat(bat),.jump(jump),.return1(return1),
       .total(total),.uncon(uncon),.con(con),.con_suc(con_suc)
        ,.halt(halt)
        );
     display _display(
        .clk(clk),.rst(rst),.syscall(syscall),.equal(equal),
        .reg2(reg2),.syscallout(SyscallOut)
        );
     RegFileRead _regfileread (
        .jal(jal),.RegDst1(RegDst1),.syscall(syscall),.rd(rd),.rs(rs),.rt(rt),
        .rW(rW),.rA(rA),.rB(rB)
        );
     RegFileWrite _regfilewrite(
        .RegDin1(RegDin1),.jal(jal),.aluR(aluR),.DMout(DMout),
        .pc4(pc4),.RegW_out(regin)
        );
     RegFiletoALU _regfiletoalu(
        .A(reg1),.B(reg2),.ins(ins),.AluB_1(AluB1),.shift(shift),
        .syscall(syscall),.aluX(aluX),.aluY(aluY)
        );
     extend _entend(
        ._16(ins16),.sha(shamt),.out1(ins16_32),.out2(ins),.shift(shift)
        );
     IM _IM(
        .pc(pc),.data(instru)
        );
        
     DM _DM(
        .clk(clk),.we(DMWrite),.addr(aluR),.Din(reg2),.mode(mode),
        .Dout(DMout),.visin(mem_addr),.visout(mem_dis)
        );
        
endmodule
