module ArithmeticLogicUnit #(parameter N=8, M=4)(
    input logic [1:0] i_op,
    input logic [N-1:0] i_arg_A,
    input logic [N-1:0] i_arg_B,
    input logic i_clk,
    input logic i_reset,
    output logic [N-1:0] o_result,
    output logic [3:0] o_status
);

    logic [N-1:0] result;
    logic [3:0] status;

    always_ff @(posedge i_clk or posedge i_reset) begin
        if (i_reset)
            result <= 0;
        else begin
            case (i_op)
                2'b00: result <= i_arg_A - (2 * i_arg_B);
                2'b01: result <= (i_arg_A < i_arg_B) ? N'bx : 0;
                2'b10: result <= (i_arg_B >= N) ? N'bx : (i_arg_A + i_arg_B);
                2'b11: begin
                            if (i_arg_B[0] || (i_arg_B >= N) || (i_arg_B < 0))
                                status <= 4'b1000; // Error
                            else
                                result <= i_arg_A + i_arg_B;
                        end
            endcase
        end
    end

    always_comb begin
        status[0] = (status == 4'b1000) ? 1'b1 : 1'b0; // ERROR bit
        status[1] = (result % 2 == 0) ? 1'b1 : 1'b0; // EVEN1 bit
        status[2] = (&result) ? 1'b1 : 1'b0; // ONES bit
        status[3] = (result[N-1] && (result >> (N-1))) ? 1'b1 : 1'b0; // OVERFLOW bit
    end

    assign o_result = result;
    assign o_status = status;

endmodule

