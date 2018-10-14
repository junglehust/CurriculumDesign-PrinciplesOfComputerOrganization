module extend(_16,sha,shift,out1,out2);
  input [15:0] _16;
  input [4:0] sha;
  input shift;
  output [31:0] out1;
  output [31:0] out2;
  reg [31:0] out1;
  reg [31:0] out2;
  reg [31:0] temp;
  always @(_16,sha,shift) begin
  	////////////////////////有符号扩�?
  	case (_16[15])
  	1:begin
  		out1={16'b1111111111111111,_16[15:0]};
  		temp={16'b1111111111111111,_16[15:0]};
  	end
  	0:begin
  		out1={16'b0000000000000000,_16[15:0]};
  		temp={16'b0000000000000000,_16[15:0]};
  	end
  	default:begin
  		out1=0;
  		temp=0;
  	end
  	endcase
    /////////////////////
    case (shift)
    1:begin
    	out2={27'b000000000000000000000000000,sha[4:0]};
    end
    0:begin
    	out2=temp;
    end
    default:begin
    	out2=0;
    end
    endcase
  end
endmodule
