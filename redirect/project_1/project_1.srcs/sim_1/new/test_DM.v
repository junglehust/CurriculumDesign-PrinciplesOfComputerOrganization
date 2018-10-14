`timescale 1ns / 1ps
module test_DM(    );
	reg clk,DMwrite;
	reg [31:0]addr,Din;
	reg [3:0] visin;
	reg [3:0]mode;
	wire [31:0]Dout;
	wire [31:0] visout;
	DM test_dm(
		clk,addr,DMwrite,mode,Din,visin,
		Dout,visout
	);
	initial begin
		clk = 0;
		DMwrite = 1;
		mode = 0;
		Din = 32'h12345678;
		addr = 32'h00000000;
		visin = 0;
		#50 Din = 32'h11223344;
		addr = 32'h00000004;
		visin = 1;
		#50 Din = 32'h55667788;
		addr = 32'h00000008;
		visin = 2;
		#50 Din = 32'h9abcdeff;
		addr = 32'h0000000c;
		#20 mode = 1;
		DMwrite = 0;
		addr = 0;
		#20 addr = 1;
		#20 addr = 2;
		#20 addr = 32'h0000000d;
		#20 visin = 0;
		#20 visin = 1;
		#20 visin = 2;
		#20 visin = 3;
	end
	always begin
		#5 clk = ~clk;
	end
endmodule
