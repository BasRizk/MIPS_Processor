module mem_wb (
    ctrl_regWrite_mem_wb, ctrl_memToReg_mem_wb,							// OUTPUTS
	read_data_from_mem_mem_wb, alu_result_mem_wb, write_register_mem_wb,
	ctrl_regWrite_ex_mem, ctrl_memToReg_ex_mem, read_data_from_mem,		// INPUTS
	alu_result_ex_mem, write_register_ex_mem,
	clk, reset
    );

output ctrl_regWrite_mem_wb, ctrl_memToReg_mem_wb;
output [31:0] read_data_from_mem_mem_wb, alu_result_mem_wb;
output [4:0] write_register_mem_wb;

input ctrl_regWrite_ex_mem, ctrl_memToReg_ex_mem;
input [31:0] read_data_from_mem, alu_result_ex_mem;
input [4:0] write_register_ex_mem;
input clk, reset;

always @ (posedge clk or negedge reset)
begin
    
end

endmodule