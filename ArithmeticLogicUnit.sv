module ArithmeticLogicUnit (i_op, i_arg_A, i_ar_B);

	parameter N = 2;
	parameter M = 8;
	
    	input logic [N-1:0] i_op;
    	input logic [M-1:0] i_arg_A;
    	input logic [M-1:0] i_arg_B;
    	input logic i_clk;
    	input logic i_reset;
    	output logic [M-1:0] o_result;
    	output logic [3:0] o_statu;

    	logic [N:0] result;
    	logic [3:0] status;
	

    	always @(posedge i_clk) begin
    	begin
    	
    		case (i_op)
    			2'b00: // A-2*B
    				result = i_arg - (2 * i_arg_B);
    				status = 4'b0000; //Reset
    				
    				if (i_arg_A < i_arg_B)
    					status[0] = 1;
    				
    				if ((i_arg_A + i_arg_B)[$unsigned(i_arg_B)] == 0)
                    			status[1] = 1;
                    	2'b01: // A < B
				
				
				                    	
                    	2'b10: // (A+B)[B] = 0
                    		
				                    		
                    			
                    	2'b11: // U2(A) => ZM(A)


			
			                    			
                    	default:
		endcase
    	end

    assign o_result = result;
    assign o_status = status;

endmodule

