module halt(
    syscall,equal,swi_halt,halt
    );
    input syscall,equal,swi_halt;
    output halt;
    assign halt = (~(syscall & equal )) & swi_halt;
endmodule
