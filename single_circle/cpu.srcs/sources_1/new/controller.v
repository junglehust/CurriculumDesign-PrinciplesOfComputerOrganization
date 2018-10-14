module controller(
    op, func, alur,equal,  
    jump,branch,ret,RegDst1,jal,RegDin1,
    shift,ALUOP,syscall,RegWrite,sw,
    mode,bat,AluB1
    );
    input [5:0] op; //op字段
    input [5:0] func;//func字段
    input [31:0] alur;  //alu的运算结果
    input equal;        //alu是否相等的判断输出
    output  jump;    //无条件分支
    output  branch;  //有条件分支成功
    output  bat; //有条件分支尝试
    output  ret; //return 返回
    output  RegDst1; //
    output  jal; //函数调用jal
    output  RegDin1; //
    output  shift;   //位移
    output  [3:0]ALUOP;   //alu的操作码
    output  syscall; //停机
    output  RegWrite;  //写寄存器  
    output  sw;      //DMWrite 写数据存储器
    output  [3:0]mode;    //数据存储器访问模式
    output  AluB1;  //alu的b输出的选择信号
    wire r;
    wire addi;
    wire addiu;
    wire andi;
    wire ori;
    wire slti;
    wire xori;
    wire sltiu;
    wire lw;
    wire lbu;
    wire beq;
    wire bne;
    wire blez;
    wire j;
    wire add;
    wire addu;
    wire And;
    wire sll;
    wire sra;
    wire srl;
    wire sub;
    wire Or;
    wire Nor;
    wire slt;
    wire sltu;
    wire tmpsys,tmpbr;
    assign r = (op==6'h00);     //8
    assign addi = (op==6'h08);
    assign addiu = (op==6'h09);
    assign andi = (op==6'h0c);
    assign ori = (op==6'h0d);
    assign slti = (op==6'h0a);
    assign xori = (op==6'h0e);
    assign sltiu = (op==6'h0b);
    assign lw = (op==6'h23);
    assign sw = (op==6'h2b);
    assign lbu = (op==6'h24);
    assign beq = (op==6'h04);
    assign bne = (op==6'h05);
    assign blez = (op==6'h06);
    assign j = (op==6'h02);
    assign jal = (op==6'h03);
    assign add = (func==6'h20)& r;
    assign addu = (func==6'h21)& r;
    assign And = (func==6'h24)& r;
    assign sll = (func==6'h00)& r;
    assign sra = (func==6'h03)& r;
    assign srl = (func==6'h02)& r;
    assign sub = (func==6'h22)& r;
    assign Or = (func==6'h25)& r;
    assign Nor = (func==6'h27)& r;
    assign slt = (func==6'h2a)& r;
    assign sltu = (func==6'h2b)& r;
    assign ret = (func==6'h08)& r;
    assign syscall = (func==6'h0c)& r;
    assign tmpsys = r & (~(ret | syscall));
    assign tmpbr = equal | (alur==32'h00000001);

    assign jump = j|jal;
    assign bat = beq|bne|blez;
    assign RegDst1 = addi|addiu|andi|ori|slti|xori|sltiu|lw|lbu;
    assign RegDin1 = lw|lbu;
    assign AluB1 = addi|addiu|andi|ori|slti|xori|sll|sltiu|lw|sra|sw|lbu|srl;
    assign RegWrite = tmpsys|addi|addiu|andi|ori|slti|xori|sltiu|jal|lw|lbu;
    assign branch = beq & equal | (~equal)& bne | tmpbr & blez;
    assign shift = sll | sra | srl;

    assign mode = lbu ? 4'b0011:
        (sw | lw)? 4'b1111: 4'b0000;
    assign ALUOP = sll ? 4'h00:
                    sra ? 4'h01:
                    srl ? 4'h02:
                    (add|addi|addiu|addu|lw|lbu|sw)? 4'h05:
                    sub? 4'h06:
                    (And|andi)? 4'h07:
                    (Or|ori)? 4'h08:
                    xori? 4'h09:
                    Nor? 4'h0a:
                    (slt|slti|blez)? 4'h0b:
                    (sltu|sltiu)? 4'h0c:4'h00;//最后一种情况？？
endmodule
