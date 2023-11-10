module testbench;

    logic [1:0] op;
    logic [7:0] arg_A, arg_B;
    logic clk, reset;
    logic [7:0] result;
    logic [3:0] status;

    ArithmeticLogicUnit #(.N(8), .M(4)) ALU (
        .i_op(op),
        .i_arg_A(arg_A),
        .i_arg_B(arg_B),
        .i_clk(clk),
        .i_reset(reset),
        .o_result(result),
        .o_status(status)
    );

    // Your testbench logic here

endmodule

