module ALU(
    input  [31:0] X,
    input  [31:0] Y,
    input  [3:0] S,    //选择信号4位
    output reg [31:0] Result1,   //输出1 32位
    output reg [31:0] Result2,   //输出信号2 32位
    output reg OF,
    output reg UOF,
    output reg Equal
    );
    integer  i;//i要在外面定义，不过一般不要用循环，循环是仿真的时候常用的，综合的时候不要用
    //reg [63:0] mul;
    reg [63:0] X64;
    reg [63:0] Y64;
    
    initial begin
        Result1=0;
        Result2=0;
        OF=0;
        UOF=0;
        Equal=0;
    end
    always@(*) begin
        Equal=!(X^Y);
     case(S)
                 0:    begin   //左移运算
                           Result1 = X<<Y;
                        end 
                 1:     begin      //算数右移
                                            Result1=X;
                 for( i=0;i < Y&&i<=31;i=i+1)
                     begin
                           Result1 = {Result1[31],Result1[31:1]};
                    end
                        end 
                 2:     begin  //逻辑右移

                         Result1 = X>>Y;
                        end 
                 3:     begin       //乘法运算
                            X64={32'b00000000000000000000000000000000,X};   //扩展成64位
                            Y64={32'b00000000000000000000000000000000,Y};
                            X64=X64*Y64;                                    //保存在64位寄存器中
                            Result1=X64[31:0];                              //分解求值
                            Result2=X64[63:32];
                        end 
                 4: begin
                        Result1=X/Y;
                        Result2=X%Y;
                      end 
                 5:begin            //加法
                        Result1=X+Y;
                        OF=(X[31]^Result1[31])&(Y[31]^Result1[31]);     //判断符号性溢出
                        UOF=Result1<X||Result1<Y;                 //判断无符号加法溢出
                       end 
                 6:begin        //减法
                        Result1=X-Y;
                        OF=(X[31]^Result1[31])&(!Y[31]^Result1[31]);     //判断符号性溢出
                        UOF=Result1>X||Result1>Y;                  //判断无符号加法溢出
                       
                       end 
                 7:begin        //按位与
                        Result1=X&Y;
                      end 
                 8:begin        //按位或
                        Result1=X|Y;
                     end 
                 9:begin        //按位异或
                        Result1=X^Y;
                    end 
                 10:begin       //按位或非
                        Result1=~(X|Y);
                       end 
                 11:begin       //符号比较，x小于y返回1
                        Result1=((X<Y)&(!X[31])&(!Y[31]))|((X>Y)&X[31]&Y[31])|((X[31]^Y[31])&X[31]);
                     end 
                 12:begin       //无符号比较，x小于y返回1
                        Result1=X<Y;
                  end 
                 default: ;
                 endcase
             end
endmodule
