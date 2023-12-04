`define ALU_SUB 2'b00
`define ALU_COMP 2'b01
`define ALU_SUM 2'b10
`define ALU_CONV 2'b11

module sync_arith_unit_4 (i_op, i_arg_A, i_arg_B, i_clk, i_reset, o_result, o_status);

	parameter N = 2;
	parameter M = 4;

	input logic [N-1:0] i_op;
	input logic [M-1:0] i_arg_A;
	input logic [M-1:0] i_arg_B;
	input logic i_clk;
	input logic i_reset;

	output logic [M-1:0] o_result;
	output logic [3:0] o_status;
	
	logic [M-1:0] temp_B;
	logic [M-1:0] comp_A;
	logic [M-1:0] comp_B;
	logic carry;
	
	/* Positive edge changes */
	
	always @(posedge i_clk) begin
    	
    		/* Zeroing the status output */
    		
    		o_status = 4'b0000; 
    		
    		/* starting the switch case for all operation options */
    		
    		case (i_op)
    			
    			/*------------FIRST OPERATION------------*/
    			/*
    			`ALU_SUB:  begin // A-2*B
    					
    					
    					
    					temp_B = (i_arg_B << 1)
    					
    					
    					if (i_arg_A => temp_B) begin    					
    						carry = 0;   						
    					end 
    					
    					else begin   					
    						carry = 1;   					
    					end
    					
    					if (carry == 0) begin
    						
    					end
 						else begin
 							
 						end   					
    					
    				   end
    			*/			
            		
            		
            			
            	/*------------SECOND OPERATION------------*/
            			
            	/* Operation of comparing input A with input B */
            	
            		`ALU_COMP: begin
                    	 
                    	/* if A is smaller than B then the output is NOT 0 */ 
                    	/* ZAMIENIC WARUNKI POROWNYWANIA ZAMIAST i_A < i_B TO DAC ZE PRZYROWNUJEMY ZNAK A DOPIERO POTEM SPRAWDZAMY CZY LICZBY SA WIEKSZE/ JESLI ICH ZNAK JEST TAKI SAM, AKA PIERWSZY BIT = 0  */
                    	
                		if ((i_arg_A < i_arg_B) || ((i_arg_A[M-1] == 1) && (i_arg_B[M-1] == 0))) begin
                		
                    			o_result = 2'b01; 
                    			
                		end 
                		
                		/* if A is bigger than B then the output is 0 */ 
                		
                		else if ((i_arg_A > i_arg_B) || ((i_arg_A[M-1] == 0) && (i_arg_B[M-1] == 1)) || (i_arg_A == i_arg_B)) begin
                		
                    			o_result = 0; // Output 0 if A >= B
                    			
                		end
                		
                		else if ((i_arg_A[M-1] == 1) && (i_arg_B[M-1] == 1)) begin
                			comp_A = i_arg_A;
                			comp_B = i_arg_B;
                			
                			comp_A[M-1] = 0;
                			comp_B[M-1] = 0;
                			
                			if (comp_A > comp_B) begin
                			
                				o_result = 1;
                			
                			end 
                			else begin
                			
                				o_result = 0;
                			
                			end
                		
                		end

            		end 
            	
            	
            	
            	/*------------THIRD OPERATION------------*/ 
            	
            	/*  */
            			
        			
        			//`ALU_SUM   : // (A+B)[B] = 0	
                    	
                    	
                    	
               	/*------------FOURTH OPERATION------------*/		
               		
                	/* Fourth operation, conversion from Two's compliment into sign magnitude (U2 into ZM)*/
                    			
               		`ALU_CONV: begin
    				
    					/* if the number is negative, we invert all but first bits, then add 1 */
    				
    					if(i_arg_A[M-1] == 1) begin
    				
        					o_result = {1'b1, ~(i_arg_A[M-2:0]) + 1'b1};
        				
    					end 
    				
    					/* if the number is positive, then the output is the number itself*/
    				
    					else begin
    				
        					o_result = i_arg_A;
        				
    					end
    					
					end
    			
                    //default:
                    
			endcase
    	end
endmodule

