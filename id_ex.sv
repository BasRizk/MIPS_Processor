module id_ex (
	ctrl_regWrite_id_ex, ctrl_memToReg_id_ex, ctrl_branch_id_ex,		// OUTPUTS
	ctrl_memRead_id_ex, ctrl_memWrite_id_ex, ctrl_regDest_id_ex,
	ctrl_aluOp_id_ex, ctrl_aluSrc_id_ex, supposed_next_address_id_ex,
	read_data_1_id_ex, read_data_2_id_ex, extended_branch_offset_id_ex,
	next_instruction_20_16_id_ex, next_instruction_15_11_id_ex,
	ctrl_regWrite, ctrl_memToReg, ctrl_branch, ctrl_memRead,			// INPUTS
	ctrl_memWrite, ctrl_regDest, ctrl_aluOp, ctrl_aluSrc,
	supposed_next_address_if_id, read_data_1, read_data_2,
	extended_branch_offset, next_instruction_20_16_if_id,
	next_instruction_15_11_if_id, clk, reset
	);

output reg ctrl_regWrite_id_ex, ctrl_memToReg_id_ex, ctrl_branch_id_ex,		
	ctrl_memRead_id_ex, ctrl_memWrite_id_ex, ctrl_regDest_id_ex,
    ctrl_aluSrc_id_ex;
output reg [1:0] ctrl_aluOp_id_ex;
output reg [31:0] supposed_next_address_id_ex, read_data_1_id_ex, read_data_2_id_ex,
    extended_branch_offset_id_ex, next_instruction_20_16_id_ex, next_instruction_15_11_id_ex;

input ctrl_regWrite, ctrl_memToReg, ctrl_branch, ctrl_memRead,			
	ctrl_memWrite, ctrl_regDest, ctrl_aluSrc;
input [1:0] ctrl_aluOp;
input [31:0] supposed_next_address_if_id, read_data_1, read_data_2,
	extended_branch_offset, next_instruction_20_16_if_id,
	next_instruction_15_11_if_id;
input clk, reset;

always @(posedge clk or negedge reset)
begin
	if(~reset) begin
		ctrl_regWrite_id_ex <= 0;
	end
	else begin
		ctrl_regWrite_id_ex <= ctrl_regWrite;
	end
end

endmodule
