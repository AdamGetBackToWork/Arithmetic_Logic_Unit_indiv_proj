`timescale 1ps/1ps
`include "./ALU.sv"


module testbench_ALU;

    parameter s_N = 2;
    parameter s_M = 8;


    reg [s_N-1:0] s_op;
    reg [s_M-1:0] s_arg_A;
    reg [s_M-1:0] s_arg_B;
    reg s_clk;
    reg s_reset;

    wire [s_M-1:0] sim_result;
    wire [3:0] sim_status;

    wire [s_M-1:0] syn_result;
    wire [3:0] syn_status;


    ALU #(.N(s_N), .M(s_M)) 
    	alu_model_simulation (
    		.i_arg_A(s_arg_A), 
 		.i_arg_B(s_arg_B), 
 		.i_op(s_op), 
 		.i_clk(s_clk), 
 		.i_reset(s_reset), 
 		.o_result(sim_result), 
 		.o_status(sim_status)
 	);	
 	
    ALU
    	alu_model_synthesis (
    		.i_arg_A(s_arg_A), 
    		.i_arg_B(s_arg_B), 
    		.i_op(s_op), 
    		.i_clk(s_clk), 
    		.i_reset(s_reset), 
    		.o_result(syn_result), 
    		.o_status(syn_status));    

    initial begin
        $dumpfile("signals.vcd");
        $dumpvars(0, testbench_ALU);

        s_reset = 1'b1;
    	s_op = 2'b00;
        
        /*Y = 2 + 3 */
        s_clk = 0;
        s_arg_A = 8'b00000010;
        s_arg_B = 8'b11111100;
        #1
        s_clk = 1;
        #1
        
        /*Y = 126 + 1 */
        s_clk = 0;
        s_arg_A = 8'b01111110;
        s_arg_B = 8'b11111110;
        #1
        s_clk = 1;
        #1
        
        /*Y = 126 + 2 */
        s_clk = 0;
        s_arg_A = 8'b01111110;
        s_arg_B = 8'b11111100;
        #1
        s_clk = 1;
        #1
        
        /*Y = -126 + 3 */
        s_clk = 0;
        s_arg_A = 8'b11111110;
        s_arg_B = 8'b11111100;
        #1
        s_clk = 1;
        #1
        
        $finish;
    end
endmodule

