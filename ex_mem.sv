module ex_mem(
    ctrl_regWrite_ex_mem, ctrl_memToReg_ex_mem, ctrl_branch_ex_mem,		// OUTPUTS
	ctrl_memRead_ex_mem, ctrl_memWrite_ex_mem,
	branch_or_not_address_ex_mem, zero_ex_mem, alu_result_ex_mem,
	read_data_2_ex_mem, write_register_ex_mem,
	ctrl_regWrite_id_ex, ctrl_memToReg_id_ex, ctrl_branch_id_ex,		// INPUTS
	ctrl_memRead_id_ex, ctrl_memWrite_id_ex, branch_or_not_address,
	zero, alu_result, read_data_2_id_ex, write_register,
    clk, reset);

output ctrl_regWrite_ex_mem, ctrl_memToReg_ex_mem, ctrl_branch_ex_mem,
	ctrl_memRead_ex_mem, ctrl_memWrite_ex_mem, zero_ex_mem;
output [31:0] branch_or_not_address_ex_mem, alu_result_ex_mem,
    read_data_2_ex_mem, write_register_ex_mem;

input ctrl_regWrite_id_ex, ctrl_memToReg_id_ex, ctrl_branch_id_ex,
	ctrl_memRead_id_ex, ctrl_memWrite_id_ex, zero;
input [31:0] branch_or_not_address, alu_result, read_data_2_id_ex;
input [4:0] write_register;
input clk, reset;

always @ (posedge clk or negedge reset)
begin
    
end

endmodule
