module ALU(
    input  [31:0] X,
    input  [31:0] Y,
    input  [3:0] S,
    output reg [31:0] Result1,
    output reg [31:0] Result2,
    output reg OF,
    output reg UOF,
    output reg Equal
    );
    integer  i;
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
                 0:    begin
                           Result1 = X<<Y;
                        end 
                 1:     begin      //ËãÊýÓÒÒÆ
                                            Result1=X;
                 for( i=0;i < Y&&i<=31;i=i+1)
                     begin
                           Result1 = {Result1[31],Result1[31:1]};
                    end
                        end 
                 2:     begin  //Âß¼­ÓÒÒÆ

                         Result1 = X>>Y;
                        end 
                 3:     begin       //³Ë·¨ÔËËã
                            X64={32'b00000000000000000000000000000000,X};   //À©Õ¹³É64Î»
                            Y64={32'b00000000000000000000000000000000,Y};
                            X64=X64*Y64;                                    //±£´æÔÚ64Î»¼Ä´æÆ÷ÖÐ
                            Result1=X64[31:0];                              //·Ö½âÇóÖµ
                            Result2=X64[63:32];
                        end 
                 4: begin
                        Result1=X/Y;
                        Result2=X%Y;
                      end 
                 5:begin            //¼Ó·¨
                        Result1=X+Y;
                        OF=(X[31]^Result1[31])&(Y[31]^Result1[31]);     //ÅÐ¶Ï·ûºÅÐÔÒç³ö
                        UOF=Result1<X||Result1<Y;                 //ÅÐ¶ÏÎÞ·ûºÅ¼Ó·¨Òç³ö
                       end 
                 6:begin        //¼õ·¨
                        Result1=X-Y;
                        OF=(X[31]^Result1[31])&(!Y[31]^Result1[31]);     //ÅÐ¶Ï·ûºÅÐÔÒç³ö
                        UOF=Result1>X||Result1>Y;                  //ÅÐ¶ÏÎÞ·ûºÅ¼Ó·¨Òç³ö
                       
                       end 
                 7:begin        //°´Î»Óë
                        Result1=X&Y;
                      end 
                 8:begin        //°´Î»»ò
                        Result1=X|Y;
                     end 
                 9:begin        //°´Î»Òì»ò
                        Result1=X^Y;
                    end 
                 10:begin       //°´Î»»ò·Ç
                        Result1=~(X|Y);
                       end 
                 11:begin       //·ûºÅ±È½Ï£¬xÐ¡ÓÚy·µ»Ø1
                        Result1=((X<Y)&(!X[31])&(!Y[31]))|((X>Y)&X[31]&Y[31])|((X[31]^Y[31])&X[31]);
                     end 
                 12:begin       //ÎÞ·ûºÅ±È½Ï£¬xÐ¡ÓÚy·µ»Ø1
                        Result1=X<Y;
                  end 
                 default: ;
                 endcase
             end
endmodule
