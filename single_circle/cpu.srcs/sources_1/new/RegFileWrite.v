module RegFileWrite(RegDin1,jal,aluR,DMout,pc4,RegW_out);
  input RegDin1,jal;
  input [31:0] aluR;
  input [31:0] DMout;
  input [31:0] pc4;
  output [31:0] RegW_out;
  reg [31:0] RegW_out;
  always @(RegDin1,jal,aluR,DMout,pc4) begin
    if(jal) begin
        RegW_out <= pc4;
    end
    else if(RegDin1) begin
        RegW_out <= DMout;
    end
    else begin
        RegW_out <= aluR;
    end
  end
endmodule