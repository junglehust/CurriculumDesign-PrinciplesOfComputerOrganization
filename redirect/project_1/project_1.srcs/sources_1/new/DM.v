module DM(
	clk,addr,DMwrite,mode,Din,visin,
	Dout,visout
	);
	input clk,DMwrite;
	input [31:0]addr,Din;
	input [3:0] visin;
	input [3:0]mode;
	output [31:0]Dout;
	output [31:0] visout;
    
    reg [31:0] memory [0:1023];
    wire [9:0] addr1;//字地址
    wire [31:0]data;
    wire [7:0]bytes;
    wire [15:0]half;

    always @(posedge clk) begin
    	if(DMwrite) begin
    		memory[addr1] <= Din;
    	end
    	else begin
    		memory[addr1] <= memory[addr1];
    	end
    end
    assign addr1 = addr[11:2];
    assign visout = memory[visin];
    assign data = memory[addr1];
    assign bytes = (addr[1:0]==0) ? data[7:0] :
        (addr[1:0]==1) ? data[15:8] :
        (addr[1:0]==2) ? data[23:16]:
        (addr[1:0]==3) ? data[31:24] : 0;
    assign half = (addr[1]) ? data[31:16] :
        (addr[1]==0) ? data[15:0] : 0;
    assign Dout = (mode==0) ? data :
    	(mode==1) ? {24'h000000, bytes} :
    	(mode==2) ? {16'h0000, half} : 0;
endmodule
