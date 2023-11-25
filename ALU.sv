`include "alu_defines.vh"

module ALU (i_op, i_arg_A, i_arg_B, i_clk, i_reset, o_result, o_status);

	parameter N = 2;
	parameter M = 8;
	
    	input logic [N-1:0] i_op;
    	input logic [M-1:0] i_arg_A;
    	input logic [M-1:0] i_arg_B;
    	input logic i_clk;
    	input logic i_reset;
    	output logic [M-1:0] o_result;
    	output logic [3:0] o_status;
	

    	always @(posedge i_clk) begin
    	
    		o_status = 4'b0000; 
    		
    		case (i_op)
    			
    			
    			`ALU_SUB : // A-2*B
    				
    					o_result = i_arg_A - (2 * i_arg_B);
    				
                    	//`ALU_LESS   : // A < B
				
				//if (i_arg_A < i_arg_B) begin
    				//	o_status[0] = 1;
    				//end
    				//if ((i_arg_A + i_arg_B)[$unsigned(i_arg_B)] == 0) begin
                    		//	o_status[1] = 1;
                    		//end
				                    	
                    	//`ALU_INDB   : // (A+B)[B] = 0	
                    			
                    	//`ALU_CHANGE : // U2(A) => ZM(A)
			                    			
                    	//default:
		endcase
    	end
endmodule

