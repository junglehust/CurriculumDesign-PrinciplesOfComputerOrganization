module buffer(
    Rst,
    rst
    );
    input Rst;
    output rst;
    assign rst = ~Rst;
endmodule
