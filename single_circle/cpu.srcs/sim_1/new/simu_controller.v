`timescale 1ns / 1ps
module simu_controller( );
    reg [5:0] op; //op字段
    reg [5:0] func;//func字段
    reg [31:0] alur;  //alu的运算结果
    reg equal;        //alu是否相等的判断输出
    wire  jump;    //无条件分支
    wire  branch;  //有条件分支成功
    wire  bat; //有条件分支尝试
    wire  ret; //return 返回
    wire  RegDst1; //
    wire  jal; //函数调用jal
    wire  RegDin1; //
    wire  shift;   //位移
    wire  [3:0]ALUOP;   //alu的操作码
    wire  syscall; //停机
    wire  RegWrite;  //写寄存器  
    wire  sw;      //DMWrite 写数据存储器
    wire  [3:0]mode;    //数据存储器访问模式
    wire  AluB1;  //alu的b输出的选择信号
    controller test_controller(
        .op(op),.func(func),.alur(alur),.equal(equal),
        .jump(jump),.branch(branch),.bat(bat),.ret(ret),
        .RegDst1(RegDst1),.jal(jal),.RegDin1(RegDin1),
        .shift(shift),.ALUOP(ALUOP),.syscall(syscall),
        .RegWrite(RegWrite),.sw(sw),.mode(mode),.AluB1(AluB1)
        );  
    initial begin
        op = 6'b001000;
       // func = 6'b;
        alur = 0;
        equal = 0;
    end
endmodule
