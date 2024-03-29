module main(next_instruction, alu_result, instruction_mem, clk, reset);

output reg [31:0] alu_result;
output reg [31:0] next_instruction;

input [7:0] instruction_mem [255:0];
input clk, reset;

// Wires to trace their signals easily
wire [4096:0] [7:0] memory;
wire [31:0] [31:0] register_file;
wire [4:0] write_register;
 
// Datapath Wires
wire [31:0] branch_or_not_address, supposed_next_address;
wire [31:0] read_data_1, read_data_2, write_data_into_mem,
		write_data_into_reg, extended_branch_offset;
wire zero;
wire [31:0] mem_address, read_data_from_mem, wb_data;

// Ctrl Wires
wire ctrl_pcSrc;
wire ctrl_regDest, ctrl_branch, ctrl_memRead, ctrl_memToReg,
	 ctrl_memWrite, ctrl_aluSrc, ctrl_regWrite;
wire [1:0] ctrl_aluOp, ctrl_halfWord_signed;

// START PIPELINE REGISTERS WIRES
wire [31:0] next_instruction_if_id, supposed_next_address_if_id,
	supposed_next_address_id_ex;

wire [1:0] ctrl_aluOp_id_ex, ctrl_halfWord_signed_id_ex,
	ctrl_halfWord_signed_ex_mem;
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

assign write_data_into_mem = read_data_2_ex_mem;		// after exec to mem
assign mem_address = alu_result_ex_mem;					// after exec to mem
assign write_data_into_reg = wb_data;					// after wb to regs file


// CONTROLERS
main_control ctrl (ctrl_regDest, ctrl_branch, ctrl_memRead,
	ctrl_memToReg, ctrl_aluOp, ctrl_memWrite, ctrl_aluSrc,
	ctrl_regWrite, ctrl_halfWord_signed, next_instruction[31:26],
	clk, reset);

// DATA PATH
instruction_fetch IF (next_instruction ,supposed_next_address,			// OUTPUTS
	branch_or_not_address_ex_mem,										// INPUTS
	instruction_mem, ctrl_pcSrc, clk, reset);

instruction_decode ID (register_file, read_data_1,						// OUTPUTS
	read_data_2, extended_branch_offset,							
	next_instruction, write_data_into_reg,								// INPUTS
	ctrl_regWrite_mem_wb, write_register_mem_wb, clk, reset);

execute EX (branch_or_not_address, zero, alu_result, write_register,	// OUTPUTS
	read_data_1_id_ex, read_data_2_id_ex,								// INPUTS
	extended_branch_offset_id_ex, supposed_next_address_id_ex,
	ctrl_aluOp_id_ex, ctrl_aluSrc_id_ex,
	next_instruction_20_16_id_ex, next_instruction_15_11_id_ex,
	ctrl_regDest_id_ex, clk, reset);

memory_access MEM(memory, ctrl_pcSrc, read_data_from_mem,				// OUTPUTS
	mem_address, write_data_into_mem,									// INPUTS
	ctrl_branch_ex_mem, zero_ex_mem, ctrl_memRead_ex_mem,
	ctrl_memWrite_ex_mem, ctrl_halfWord_signed_ex_mem, clk, reset);

write_back WB (wb_data,													// OUTPUTS						
	read_data_from_mem_mem_wb, alu_result_mem_wb,						// INPUTS
	ctrl_memToReg_mem_wb, clk, reset);

// PIPELINE REGISTERS
if_id IF_ID (next_instruction_if_id, supposed_next_address_if_id,		// OUTPUTS
	//next_instruction[31:26], //Next_Opcode to be used for lh, & lhu
	next_instruction, supposed_next_address,							// INPUTS
	clk, reset);

id_ex ID_EX (
	ctrl_regWrite_id_ex, ctrl_memToReg_id_ex, ctrl_branch_id_ex,		// OUTPUTS
	ctrl_memRead_id_ex, ctrl_memWrite_id_ex, ctrl_regDest_id_ex,
	ctrl_aluOp_id_ex, ctrl_aluSrc_id_ex, ctrl_halfWord_signed_id_ex,
	supposed_next_address_id_ex, read_data_1_id_ex, read_data_2_id_ex,
	extended_branch_offset_id_ex,
	next_instruction_20_16_id_ex, next_instruction_15_11_id_ex,
	ctrl_regWrite, ctrl_memToReg, ctrl_branch, ctrl_memRead,			// INPUTS
	ctrl_memWrite, ctrl_regDest, ctrl_aluOp, ctrl_aluSrc, ctrl_halfWord_signed,
	supposed_next_address_if_id, read_data_1, read_data_2,
	extended_branch_offset, next_instruction_if_id[20:16],
	next_instruction_if_id[15:11],
	clk, reset);

ex_mem EX_MEM (
	ctrl_regWrite_ex_mem, ctrl_memToReg_ex_mem, ctrl_branch_ex_mem,		// OUTPUTS
	ctrl_memRead_ex_mem, ctrl_memWrite_ex_mem, ctrl_halfWord_signed_ex_mem,
	branch_or_not_address_ex_mem, zero_ex_mem, alu_result_ex_mem,
	read_data_2_ex_mem, write_register_ex_mem,
	ctrl_regWrite_id_ex, ctrl_memToReg_id_ex, ctrl_branch_id_ex,		// INPUTS
	ctrl_memRead_id_ex, ctrl_memWrite_id_ex, ctrl_halfWord_signed_id_ex,
	branch_or_not_address, zero, alu_result, read_data_2_id_ex, write_register,
	clk, reset);

mem_wb MEM_WB (
	ctrl_regWrite_mem_wb, ctrl_memToReg_mem_wb,							// OUTPUTS
	read_data_from_mem_mem_wb, alu_result_mem_wb, write_register_mem_wb,
	ctrl_regWrite_ex_mem, ctrl_memToReg_ex_mem, read_data_from_mem,		// INPUTS
	alu_result_ex_mem, write_register_ex_mem,
	clk, reset);


endmodule