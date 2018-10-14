module RegFileRead(
   syscall,rs,rt,
   ra,rb
   );
   input syscall;
   input [4:0]rs,rt;
   output [4:0]ra,rb;
   assign ra = syscall ? 2 : rs;
   assign rb = syscall ? 4 : rt;
endmodule