module main(next_instruction, alu_result, instruction_mem, clk, reset);

output reg [31:0] alu_result;
output reg [31:0] next_instruction;

input [7:0] instruction_mem [255:0];
input clk, reset;

// Wires to trace their signals easily
wire [31:0] [31:0] register_file;
wire [4:0] write_register;
wire [1023:0] [31:0] memory;
 
// Datapath Wires
wire [31:0] branch_or_not_address, supposed_next_address,
	supposed_next_address_pass;
wire [31:0] read_data_1, read_data_2, write_data_into_mem,
		write_data_into_reg, extended_branch_offset;
wire zero;
wire [31:0] mem_address, read_data_from_mem, wb_data;

// Ctrl Wires
wire ctrl_pcSrc;
wire ctrl_regDest, ctrl_branch, ctrl_memRead, ctr_memToReg,
	 ctr_memWrite, ctrl_aluSrc, ctrl_regWrite;
wire [1:0] ctrl_aluOp;

// START PIPELINE REGISTERS WIRES
wire [31:0] next_instruction_if_id, supposed_next_address_if_id,
	supposed_next_address_id_ex;

wire [1:0] ctrl_aluOp_id_ex;
wire ctrl_regWrite_id_ex, ctrl_memToReg_id_ex, ctrl_branch_id_ex,		//ID/EX CTRL OUTPUT WIRES
	ctrl_memRead_id_ex, ctrl_memWrite_id_ex, ctrl_regDest_id_ex,
	ctrl_aluSrc_id_ex,
	ctrl_regWrite_ex_mem, ctrl_memToReg_ex_mem, ctrl_branch_ex_mem,		//EX/MEM CTRL OUTPUT WIRES
	ctrl_memRead_ex_mem, ctrl_memWrite_ex_mem, zero_ex_mem,
	ctrl_regWrite_mem_wb, ctrl_memToReg_mem_wb;							//MEM/WB CTRL OUTPUT WIRES

wire [31:0] read_data_1_id_ex, read_data_2_id_ex,						
	read_data_2_ex_mem, extended_branch_offset_id_ex,
	branch_or_not_address_ex_mem, alu_result_ex_mem,
	alu_result_mem_wb, read_data_from_mem_mem_wb;

wire [4:0] next_instruction_15_11_id_ex, next_instruction_20_16_id_ex,
	write_register_ex_mem, write_register_mem_wb;
// END OF PIPELINE REGISTERS WIRES

assign write_data_into_mem = read_data_2;		// after exec to mem
assign mem_address = alu_result;				// after exec to mem
assign write_data_into_reg = wb_data;			// after wb to regs file


// CONTROLERS
main_control ctrl (ctrl_regDest, ctrl_branch, ctrl_memRead,
	ctrl_memToReg, ctrl_aluOp, ctrl_memWrite, ctrl_aluSrc,
	ctrl_regWrite, next_instruction[31:26], reset);

// DATA PATH
instruction_fetch IF (next_instruction ,supposed_next_address,
	branch_or_not_address, supposed_next_address_pass,
	instruction_mem, ctrl_pcSrc, clk, reset);

instruction_decode ID (register_file, write_register, read_data_1,
	read_data_2, extended_branch_offset, next_instruction,
	write_data_into_reg, ctrl_regDest, ctrl_regWrite,
	clk, reset);

execute EX (branch_or_not_address, supposed_next_address_pass,
	zero, alu_result, read_data_1, read_data_2,
	extended_branch_offset, supposed_next_address,
	ctrl_aluOp, ctrl_aluSrc, clk, reset);

memory_access MEM(memory, ctrl_pcSrc,
	read_data_from_mem, mem_address, write_data_into_mem,
	ctrl_branch, zero, ctrl_memRead, ctrl_memWrite, clk, reset);

write_back WB (wb_data, read_data_from_mem, alu_result,
	ctrl_memToReg, clk, reset);

// PIPELINE REGISTERS
if_id IF_ID (next_instruction_if_id, supposed_next_address_if_id,		// OUTPUTS
	next_instruction, supposed_next_address_id_ex,						// INPUTS
	clk, reset);

id_ex ID_EX (
	ctrl_regWrite_id_ex, ctrl_memToReg_id_ex, ctrl_branch_id_ex,		// OUTPUTS
	ctrl_memRead_id_ex, ctrl_memWrite_id_ex, ctrl_regDest_id_ex,
	ctrl_aluOp_id_ex, ctrl_aluSrc_id_ex, supposed_next_address_id_ex,
	read_data_1_id_ex, read_data_2_id_ex, extended_branch_offset_id_ex,
	next_instruction_20_16_id_ex, next_instruction_15_11_id_ex,
	ctrl_regWrite, ctrl_memToReg, ctrl_branch, ctrl_memRead,			// INPUTS
	ctrl_memWrite, ctrl_regDest, ctrl_aluOp, ctrl_aluSrc,
	supposed_next_address_if_id, read_data_1, read_data_2,
	extended_branch_offset, next_instruction_if_id[20:16],
	next_instruction_if_id[15:11],
	clk, reset);

ex_mem EX_MEM (
	ctrl_regWrite_ex_mem, ctrl_memToReg_ex_mem, ctrl_branch_ex_mem,		// OUTPUTS
	ctrl_memRead_ex_mem, ctrl_memWrite_ex_mem,
	branch_or_not_address_ex_mem, zero_ex_mem, alu_result_ex_mem,
	read_data_2_ex_mem, write_register_ex_mem,
	ctrl_regWrite_id_ex, ctrl_memToReg_id_ex, ctrl_branch_id_ex,		// INPUTS
	ctrl_memRead_id_ex, ctrl_memWrite_id_ex, branch_or_not_address,
	zero, alu_result, read_data_2_id_ex, write_register,
	clk, reset);

mem_wb MEM_WB (
	ctrl_regWrite_mem_wb, ctrl_memToReg_mem_wb,							// OUTPUTS
	read_data_from_mem_mem_wb, alu_result_mem_wb, write_register_mem_wb,
	ctrl_regWrite_ex_mem, ctrl_memToReg_ex_mem, read_data_from_mem,		// INPUTS
	alu_result_ex_mem, write_register_ex_mem,
	clk, reset);


endmodule