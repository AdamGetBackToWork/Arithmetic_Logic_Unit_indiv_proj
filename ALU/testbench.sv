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
    
    sync_arith_unit_4 #(.N(test_N), .M(test_M))
    alu_model_simulation
    					(.i_arg_A(test_arg_A),
    					 .i_arg_B(test_arg_B),
    					 .i_op(test_op),
    					 .i_clk(test_clk),
    				     .i_reset(test_reset),
    				     .o_result(simulation_test_result), 
    			   	     .o_status(simulation_test_status));
	
	initial begin
		
		$dumpfile("signals.vcd");
		$dumpvars(0, testbench);
		
		
		
	/*---------FIRST OPERATION TEST---------*/

	test_op = 2'b00;
	test_reset = 1'b1;

		// Test Case 1: A = 3, B = 1
		test_clk = 0; test_arg_A = 4'b0011; test_arg_B = 4'b0001;	
		#1 test_clk = 1; #1
		// Expected output: 0001

		// Test Case 2: A = 3, B = -1
		test_clk = 0; test_arg_A = 4'b0011; test_arg_B = 4'b1111;
		#1 test_clk = 1; #1
		// Expected output: 0101

		// Test Case 3: A = 4, B = 2
		test_clk = 0; test_arg_A = 4'b0100; test_arg_B = 4'b0010;
		#1 test_clk = 1; #1
		// Expected output: 0000

		// Test Case 4: A = 7, B = 2
		test_clk = 0; test_arg_A = 4'b0111; test_arg_B = 4'b0010;
		#1 test_clk = 1; #1
		// Expected output: 0011

		// Test Case 5: A = 4, B = 3
		test_clk = 0; test_arg_A = 4'b0100; test_arg_B = 4'b0011;
		#1 test_clk = 1; #1
		// Expected output: 1110

		// Test Case 6: A = -4, B = -2
		test_clk = 0; test_arg_A = 4'b1100; test_arg_B = 4'b1110;
		#1 test_clk = 1; #1
		// Expected output: 0000

		// Test Case 7: A = 2, B = 3
		test_clk = 0; test_arg_A = 4'b0010; test_arg_B = 4'b0011;
		#1 test_clk = 1; #1
		// Expected output: 1101

		// Test Case 8: A = 2, B = -2
		test_clk = 0; test_arg_A = 4'b0010; test_arg_B = 4'b0010;
		#1 test_clk = 1; #1
		// Expected output: 1101

		// Test Case 9: A = 3, B = 3
		test_clk = 0; test_arg_A = 4'b0011; test_arg_B = 4'b0011;
		#1 test_clk = 1; #1
		// Expected output: 1101

		// Test Case 10: A = 0, B = 5
		test_clk = 0; test_arg_A = 4'b0000; test_arg_B = 4'b0101;
		#1 test_clk = 1; #1
		// Expected output: 1101



	/*---------SECOND OPERATION TEST---------*/

	test_op = 2'b01;

		// Test Case 1: A = 3, B = 5
		test_clk = 0; test_arg_A = 4'b0011; test_arg_B = 4'b0101;
		#1 test_clk = 1; #1
		// Expected output: 1
		// Expected status: 0000

		// Test Case 2: A = 7, B = 4
		test_clk = 0; test_arg_A = 4'b0111; test_arg_B = 4'b0100;
		#1 test_clk = 1; #1
		// Expected output: 0
		// Expected status: 0100

		// Test Case 3: A = -4, B = 3
		test_clk = 0; test_arg_A = 4'b1100; test_arg_B = 4'b0011;
		#1 test_clk = 1; #1
		// Expected output: 1
		// Expected status: 0000

		// Test Case 4: A = -3, B = -3
		test_clk = 0; test_arg_A = 4'b1101; test_arg_B = 4'b1101;
		#1 test_clk = 1; #1
		// Expected output: 0
		// Expected status: 0100

		// Test Case 5: A = 4, B = -5
		test_clk = 0; test_arg_A = 4'b0100; test_arg_B = 4'b1011;
		#1 test_clk = 1; #1
		// Expected output: 0
		// Expected status: 0100

		// Test Case 6: A = 0, B = 5
		test_clk = 0; test_arg_A = 4'b0000; test_arg_B = 4'b0101;
		#1 test_clk = 1; #1
		// Expected output: 1
		// Expected status: 0000



	/*---------THIRD OPERATION TEST---------*/

	test_op = 2'b10;

		// Test Case 1: A = 2, B = 3
		test_clk = 0; test_arg_A = 4'b0010; test_arg_B = 4'b0011;
		#1 test_clk = 1; #1
		// Expected output: 0101

		// Test Case 2: A = 2, B = 5
		test_clk = 0; test_arg_A = 4'b0010; test_arg_B = 4'b0101;
		#1 test_clk = 1; #1
		// Expected output: 0

		// Test Case 3: A = 1, B = 1
		test_clk = 0; test_arg_A = 4'b0001; test_arg_B = 4'b0001;
		#1 test_clk = 1; #1
		// Expected output: 0010

		// Test Case 4: A = 6, B = 1
		test_clk = 0; test_arg_A = 4'b0110; test_arg_B = 4'b0001;
		#1 test_clk = 1; #1
		// Expected output: 0110

		// Test Case 5: A = 7, B = 0
		test_clk = 0; test_arg_A = 4'b0111; test_arg_B = 4'b0000;
		#1 test_clk = 1; #1
		// Expected output: 0110



	/*---------FOURTH OPERATION TEST---------*/

	test_op = 2'b11;

		// Test Case 1: A = 3
		test_clk = 0; test_arg_A = 4'b0011;
		#1 test_clk = 1; #1
		// Expected output: 0011
		// Expected status: 0100

		// Test Case 2: A = 7
		test_clk = 0; test_arg_A = 4'b0111;
		#1 test_clk = 1; #1
		// Expected output: 0111
		// Expected status: 0000

		// Test Case 3: A = 0
		test_clk = 0; test_arg_A = 4'b0000;
        #1 test_clk = 1; #1
        /* expected output: 0000 */
		/* expected status: 0100 */
		
		// Test Case 3: A = -5
		test_clk = 0; test_arg_A = 4'b1011;
        #1 test_clk = 1; #1
        /* expected output: 1101 */
		/* expected status: 0000 */

		// Test Case 3: A = -7
		test_clk = 0; test_arg_A = 4'b1001;
        #1 test_clk = 1; #1
        /* expected output: 1111 */
		/* expected status: 0S0 */
		
		$finish;
	
	end
		
endmodule
