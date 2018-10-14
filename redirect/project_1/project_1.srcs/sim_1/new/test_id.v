`timescale 1ns / 1ps
module test_id(

    );
    reg [31:0]instru;
    reg shift,unsign;
    wire [5:0] op,func;
    wire [4:0] rs,rt,rd;
    wire [31:0] ins16_32,ins;
    wire [25:0] ins26;
	IR_Extern test_IR(
		instru,shift,unsign,
		rs,rt,rd,op,func,
		ins16_32,ins26,ins
    );
	initial begin
		instru = 32'h00005678;
		shift = 0;
		unsign = 0;
		#20 unsign = 1;
		#20 shift = 1;
		#20 unsign =0;
		shift = 0;
		instru = 32'h00008765;
		#20 unsign = 1;
		#20 shift = 1;
	end
endmodule
