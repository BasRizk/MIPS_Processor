module ex_mem(
    ctrl_regWrite_ex_mem, ctrl_memToReg_ex_mem, ctrl_branch_ex_mem,		// OUTPUTS
	ctrl_memRead_ex_mem, ctrl_memWrite_ex_mem, ctrl_halfWord_signed_ex_mem,
	branch_or_not_address_ex_mem, zero_ex_mem, alu_result_ex_mem,
	read_data_2_ex_mem, write_register_ex_mem,
	ctrl_regWrite_id_ex, ctrl_memToReg_id_ex, ctrl_branch_id_ex,		// INPUTS
	ctrl_memRead_id_ex, ctrl_memWrite_id_ex, ctrl_halfWord_signed_id_ex,
	branch_or_not_address,
	zero, alu_result, read_data_2_id_ex, write_register,
    clk, reset);

output reg ctrl_regWrite_ex_mem, ctrl_memToReg_ex_mem, ctrl_branch_ex_mem,
	ctrl_memRead_ex_mem, ctrl_memWrite_ex_mem, zero_ex_mem;
output reg [31:0] branch_or_not_address_ex_mem, alu_result_ex_mem,
    read_data_2_ex_mem;
output reg [4:0] write_register_ex_mem;
output reg [1:0] ctrl_halfWord_signed_ex_mem;

input ctrl_regWrite_id_ex, ctrl_memToReg_id_ex, ctrl_branch_id_ex,
	ctrl_memRead_id_ex, ctrl_memWrite_id_ex, zero;
input [31:0] branch_or_not_address, alu_result, read_data_2_id_ex;
input [4:0] write_register;
input [1:0] ctrl_halfWord_signed_id_ex;
input clk, reset;

/*
always @ (negedge reset or
	ctrl_regWrite_id_ex or ctrl_memToReg_id_ex or ctrl_branch_id_ex or
	ctrl_memRead_id_ex or ctrl_memWrite_id_ex or branch_or_not_address or
	zero, alu_result or read_data_2_id_ex or write_register)
	*/
always @ (posedge clk or negedge reset)
begin
	if(~reset) begin
		ctrl_regWrite_ex_mem = 0;
		ctrl_memToReg_ex_mem = 0;
		ctrl_branch_ex_mem = 0;
		ctrl_memRead_ex_mem = 0;
		ctrl_memWrite_ex_mem = 0;
		ctrl_halfWord_signed_ex_mem = 0;

		read_data_2_ex_mem = 0;
		
	end
	else begin
		ctrl_regWrite_ex_mem = ctrl_regWrite_id_ex;
		ctrl_memToReg_ex_mem = ctrl_memToReg_id_ex;
		ctrl_branch_ex_mem = ctrl_branch_id_ex;
		ctrl_memRead_ex_mem = ctrl_memRead_id_ex;
		ctrl_memWrite_ex_mem = ctrl_memWrite_id_ex;
		ctrl_halfWord_signed_ex_mem = ctrl_halfWord_signed_id_ex;
		
		read_data_2_ex_mem = read_data_2_id_ex;
		
	end
    
end

always @ (*)
begin
	if(~reset) begin
		zero_ex_mem = 0;
		branch_or_not_address_ex_mem = 0;
		alu_result_ex_mem = 0;
				
		write_register_ex_mem = 0;
	end
	else begin
		zero_ex_mem = zero;
		branch_or_not_address_ex_mem = branch_or_not_address;
		alu_result_ex_mem = alu_result;
				
		write_register_ex_mem = write_register;
	end
    
end

endmodule
