module mem_wb (
    ctrl_regWrite_mem_wb, ctrl_memToReg_mem_wb,							// OUTPUTS
	read_data_from_mem_mem_wb, alu_result_mem_wb, write_register_mem_wb,
	ctrl_regWrite_ex_mem, ctrl_memToReg_ex_mem, read_data_from_mem,		// INPUTS
	alu_result_ex_mem, write_register_ex_mem,
	clk, reset
    );

output reg ctrl_regWrite_mem_wb, ctrl_memToReg_mem_wb;
output reg [31:0] read_data_from_mem_mem_wb, alu_result_mem_wb;
output reg [4:0] write_register_mem_wb;

input ctrl_regWrite_ex_mem, ctrl_memToReg_ex_mem;
input [31:0] read_data_from_mem, alu_result_ex_mem;
input [4:0] write_register_ex_mem;
input clk, reset;

/*
always @ (negedge reset or
	ctrl_regWrite_ex_mem or ctrl_memToReg_ex_mem or read_data_from_mem or		
	alu_result_ex_mem or write_register_ex_mem)
	*/

always @ (*)
begin
	if(~reset) begin
		ctrl_regWrite_mem_wb = 0;
		ctrl_memToReg_mem_wb = 0;	
		read_data_from_mem_mem_wb = 0;
		alu_result_mem_wb = 0;
		ctrl_regWrite_mem_wb = 0;
		write_register_mem_wb = 0;
	end
	else begin
		ctrl_regWrite_mem_wb = ctrl_regWrite_ex_mem;
		ctrl_memToReg_mem_wb = ctrl_memToReg_ex_mem;
		read_data_from_mem_mem_wb = read_data_from_mem;
		alu_result_mem_wb = alu_result_ex_mem;
		ctrl_regWrite_mem_wb = ctrl_regWrite_ex_mem;
		write_register_mem_wb = write_register_ex_mem;
	end
    
end

endmodule