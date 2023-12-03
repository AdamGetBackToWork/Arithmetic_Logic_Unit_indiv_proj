`timescale 1ps/1ps
`include "./alu.sv"


module testbench;

    parameter test_N = 2;
    parameter test_M = 4;

    
    reg [test_N-1:0] test_op;
    reg [test_M-1:0] test_arg_A;
    reg [test_M-1:0] test_arg_B;
    reg test_clk;
    reg test_reset;
    
    wire [test_M-1:0] simulation_test_result;
    wire [3:0] simulation_test_status;

    //wire [test_M-1:0] synthesis_test_result;
    //wire [3:0] synthesis_test_status;
    
    sync_arith_unit_4 #(.N(s_N), .M(s_M), .K(s_K))
    alu_model_simulation
    					(.i_arg_A(test_arg_A),
    					 .i_arg_B(test_arg_B),
    					 .i_op(test_op),
    					 .i_clk(test_clk),
    				     .i_reset(test_reset),
    				     .o_result(simulation_test_result), 
    			   	     .o_status(simulation_test_status));
	
	/*
	sync_arith_unit_24_syn
    alu_model_synthesis 	
    					(.i_arg_A(s_arg_A),
     					 .i_arg_B(s_arg_B),
      					 .i_op(s_op),
       					 .i_clk(s_clk),
        				 .i_reset(s_reset),
         				 .o_result(synthesis_s_result),
          				 .o_status(synthesis_s_status));
	*/
	
	initial begin
		
		$dumpfile("signals.vcd);
		$dumpvars(0, testbench);
		
		/*---------FIRST OPERATION TEST---------*/
		
		//test_op = 2'b00;
		test_reset = 1'b1;
		
		/*---------SECOND OPERATION TEST---------*/
		
		test_op = 2'b01;
		
		/* A = 3, B = 5 */
		test_clk = 0;
		test_arg_A = 4'b0011;
		test_arg_B = 4'b0101;
		#1
        s_clk = 1;
        #1

		/* A = 7, B = 5 */
		test_clk = 0;
		test_arg_A = 4'b0111;
		test_arg_B = 4'b0101;
		#1
        s_clk = 1;
        #1
        
        /* A = -4, B = 5 */
		test_clk = 0;
		test_arg_A = 4'b1100;
		test_arg_B = 4'b0011;
		#1
        s_clk = 1;
        #1
        
        /* A = -4, B = -3 */
		test_clk = 0;
		test_arg_A = 4'b1100;
		test_arg_B = 4'b1101;
		#1
        s_clk = 1;
        #1
        
        /* A = 4, B = -5 */
		test_clk = 0;
		test_arg_A = 4'b0100;
		test_arg_B = 4'b1011;
		#1
        s_clk = 1;
        #1

		/*---------THIRD OPERATION TEST---------*/
		
		test_op = 2'b10;
		
		/*---------FOURTH OPERATION TEST---------*/
		/*  */
		
		test_op = 2'b11;
		
		/* A = -5*/
		s_clk = 0;
        s_arg_A = 4'b1011;
        #1
        s_clk = 1;
        #1

		/* A = 0 */
        s_clk = 0;
        s_arg_A = 4'b0000;
        #1
        s_clk = 1;
        #1

		/* A = -7 */
		s_clk = 0;
        s_arg_A = 4'b1001;
        #1
        s_clk = 1;
        #1

		/* A = 3 */
        s_clk = 0;
        s_arg_A = 4'b0011;
        #1
        s_clk = 1;
        #1


		
		$finish;
		
	end
	
endmodule
