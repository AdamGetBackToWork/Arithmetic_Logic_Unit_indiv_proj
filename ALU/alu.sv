`define ALU_SUB 2'b00
`define ALU_COMP 2'b01
`define ALU_SUM 2'b10
`define ALU_CONV 2'b11

module sync_arith_unit_4 (i_op, 
						i_arg_A, 
						i_arg_B, 
						i_clk, 
						i_reset, 
						o_result, 
						o_status);

	/* parameters used to keep the code easy to modify */
	parameter N = 2, M = 4, J = 5;

	/* logical inputs, specified in documentation */
	input logic [N-1:0] i_op;
	input logic [M-1:0] i_arg_A, i_arg_B;
	input logic i_clk;
	input logic i_reset;

	/* logical outputs, specified in documentation */
	output logic [M-1:0] o_result;
	output logic [3:0] o_status;
	
	/* logical vectors, to keep temporary values inside of them
	   this way, im not modyfing the output over and over again, 
	   but instead perform operation on temporary vars
	*/
	logic [M-1:0] temp_B;
	logic [M-1:0] comp_A, comp_B;
	logic [M-1:0] sum;
	logic [J-1:0] overflow_check;
	
	/* temporary result and status to keep a track of em in combination part of module */
	logic [3:0] temp_status; 
	logic [M-1:0] temp_result;
	
	logic signed [M-1:0] s_A, s_B;
	
	/* Combination part of the module */
	always_comb begin
    	
    		/* Zeroing the status output */
    		
    		
    		/* assigning zero-values to temporary result and status*/
    		temp_status = 4'b0000; 
    		temp_result = 4'b0;
    		
    		/* assigning zero-values to temporary vars*/
    		temp_B = 4'b0;
    		comp_A = 4'b0; comp_B = 4'b0;
    		sum = 4'b0;
    		overflow_check = 5'b0;
    		
    		/* starting the switch case for all operation options */
    		
    		case (i_op)
    		
    		
    			/*------------FIRST OPERATION------------*/
    			
    			/* Operation of subtracting the double of B from A */
    			
    			`ALU_SUB:  begin // A-2*B
    					/*	
    					temp_B = (i_arg_B << 1);
    					
    					s_B = $signed(temp_B);
    					s_A = $signed(i_arg_A);
    					
    					if ((s_A - s_B) > ((2**(M-1)) - 1)) 
    					begin
        					temp_status = 4'b1001;
    						temp_result = 4'bx;
        				end 
        				else if ((s_A - s_B) < ((2**(M-1)) - 1)) 
        				begin
        					temp_status = 4'b1001;
    						temp_result = 4'bx;
        				end else 
        				begin
        					temp_result = s_A - s_B;
        				end
    					*/
    					/* addressing the problem with overflow and goind out of bounds */
    					/*
    					overflow_check = i_arg_A - temp_B;
    					
    					if ((overflow_check[J-1] == 0) && (overflow_check[J-2] == 1)) 
    					begin
    					
    						temp_status = 4'b1001;
    						temp_result = 4'bx;
    						
    					end 
    					else if ((overflow_check[J-1] == 1) && (overflow_check[J-2] == 0))  
    					begin
    					
    						temp_status = 4'b1001;
    						temp_result = 4'bx;
    						
    					end else 
    					begin 
    					
    						temp_result = i_arg_A - temp_B;
    					
    					end
    					*/
    					temp_B = (i_arg_B << 1);
    					
            			s_A = $signed(i_arg_A);
        			 	s_B = $signed(temp_B);
        				
  
        				if ((s_A - s_B) > ((2**(M-1)) - 1)) begin
        					temp_status = 4'b1001;
    						temp_result = 4'bx;
        				end 
        				else if ((s_A - s_B) < -(2**(M-1))) begin
        					temp_status = 4'b1001;
    						temp_result = 4'bx;
        				end else begin
        				
        				sum = s_A - s_B;
        				temp_result = sum;

        				end
        				
                    end
      
            		
            			
            	/*------------SECOND OPERATION------------*/
            			
            	/* Operation of comparing input A with input B */
            	
            	`ALU_COMP: begin // A < B
                    	 
                    	/* if A is smaller than B then the output is NOT 0 */ 
                    	
                		if ((i_arg_A[M-1] == 1) && (i_arg_B[M-1] == 0)) 
                		begin
                		
                    			temp_result = 2'b01; 
                    			
                		end else 
                		
                		/* if A is bigger than B then the output is 0 */ 
                		
                		if (((i_arg_A[M-1] == 0) && (i_arg_B[M-1] == 1)) || (i_arg_A == i_arg_B)) 
                		begin
                		
                    			temp_result = 0; // Output 0 if A >= B
                    			
                		end else if ((i_arg_A[M-1] == 0) && (i_arg_B[M-1] == 0)) 
                		begin
                		
                			if (i_arg_A < i_arg_B) 
                			begin
                			
                				temp_result = 2'b01; 
                				
                			end else 
                			begin 
                			
                				temp_result = 0;
                				
                			end
                			
                		end else if ((i_arg_A[M-1] == 1) && (i_arg_B[M-1] == 1)) 
                		begin
                			comp_A = i_arg_A;
                			comp_B = i_arg_B;
                			
                			comp_A[M-1] = 0;
                			comp_B[M-1] = 0;
                			
                			if (comp_A > comp_B) 
                			begin
                			
                				temp_result = 1;
                			
                			end else 
                			begin
                			
                				temp_result = 0;
                			
                			end
                		
                		end

            		end 
            	
            	
            	
            	/*------------THIRD OPERATION------------*/ 
            	
            	/* Operation of changing the B-index bit of the sum ofg  */
   
        		`ALU_SUM : begin // (A+B)[B] = 0

        			 	/* Adding up both input vectors, A and B */
        			 	
        			 	s_A = $signed(i_arg_A);
        			 	s_B = $signed(i_arg_B);
        			 	
        				//sum = i_arg_A + i_arg_B;
        				//overflow_check = sum;
        				
        				
        				
        				/*
        				if ((overflow_check[J-1] == 0) && ((overflow_check[J-2] == 1)))
    					begin
    					
    						temp_status = 4'b1001;
    						temp_result = 4'bx;
    						
    						
    					end else if ((overflow_check[J-1] == 1) && ((overflow_check[J-2] == 0)))
    					begin
    					
    						temp_status = 4'b1001;
    						temp_result = 4'bx;
    						
    					end else
        				begin
        				*/
        				/*  
        					Changing the corresponded to B value bit in sum to 0 
        					keep in mind the bits are 0 indexed, so if B = 0001 then 
        					in "sum" the bit changed will be the 2^1 one.
        				*/ 
        				if ((s_A + s_B) > ((2**(M-1)) - 1)) begin
        					temp_status = 4'b1001;
    						temp_result = 4'bx;
        				end 
        				else if ((s_A + s_B) < -(2**(M-1))) begin
        					temp_status = 4'b1001;
    						temp_result = 4'bx;
        				end else begin
        				
        				sum = s_A + s_B;
        				sum = (sum & ~(1 << s_B));

        				
        				/* Assigning the sum to the result output */
        				
        				temp_result = sum;
        				end
        				
                    end
                    	
                    	
                    	
                    	
               	/*------------FOURTH OPERATION------------*/		
               		
                /*  Fourth operation, conversion from Two's compliment into sign magnitude (U2 into ZM)*/
                    			
                    			
               	`ALU_CONV: begin // U2(A) => ZM(A)
    				
    					/* if the number is negative, we invert all but first bits, then add 1 */
    				
    					if(i_arg_A[M-1] == 1) 
    					begin
    				
        					temp_result = {1'b1, ~(i_arg_A[M-2:0]) + 1'b1};
        				
    					end 
    				
    					/* if the number is positive, then the output is the number itself*/
    				
    					else begin
    				
        					temp_result = i_arg_A;
        				
    					end
    					
					end
    			
    			
                    //default - not used
                    
			endcase
				
			/* After exiting switch case, assigning bits of the temp_status */
				
				if (~(temp_status == 4'b1001))
				begin 
					
				/* If there is an even number of ones in result, switch bit no.2 to 1 */
					
					if(~(^temp_result == 1'b1)) 
					begin
						temp_status[2] = 1'b1;
					end
				
				/* If result is made of ones entirely, switch bit no.1 to 1 */
				
					if(temp_result == 4'b1111) 
					begin
						temp_status[1] = 1'b1; 
					end
					
				end	
				
			/* reseting the entire module */
				if(i_reset == 1'b0) 
				begin
				    temp_status = 4'b0000;
    				temp_result = 4'b0000;
				end

    	end
		
		/* assigning the temporary result and status to their outputs */
    	always_ff @(posedge i_clk) begin
    		o_result <= temp_result;
    		o_status <= temp_status;
   		end

endmodule

