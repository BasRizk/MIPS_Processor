module main(alu_result, instruction_mem, clk, reset);

output reg [31:0] alu_result;
input [7:0] instruction_mem [255:0];
input clk, reset;

// Datapath Wires
wire [31:0] branch_or_not_address, supposed_next_address,
	next_instruction;
wire [31:0] read_data_1, read_data_2, write_data_into_mem,
		write_data_into_reg, extended_branch_offset;
wire zero;
wire [31:0] mem_address, read_data_from_mem, wb_data;

// Ctrl Wires
wire ctrl_pcSrc;
wire ctrl_regDest, ctrl_branch, ctrl_memRead, ctr_memToReg,
	 ctr_memWrite, ctrl_aluSrc, ctrl_regWrite;
wire [1:0] ctrl_aluOp;


assign write_data_into_mem = read_data_2;			// after exec to mem
assign mem_address = alu_result;					// after exec to mem
assign write_data_into_reg = wb_data;				// after wb to regs file


// CONTROLERS
main_control ctrl (ctrl_regDest, ctrl_branch, ctrl_memRead,
	ctrl_memToReg, ctrl_aluOp, ctrl_memWrite, ctrl_aluSrc,
	ctrl_regWrite, next_instruction[31:26], reset);

// DATA PATH
instruction_fetch IF (next_instruction ,supposed_next_address,
	branch_or_not_address, instruction_mem, ctrl_pcSrc, clk, reset);

instruction_decode ID (read_data_1, read_data_2, extended_branch_offset,
	next_instruction, write_data_into_reg, ctrl_regDest, ctrl_regWrite,
	clk, reset);

execute EX (branch_or_not_address, zero, alu_result, read_data_1,
	read_data_2, extended_branch_offset, supposed_next_address,
	ctrl_aluOp, ctrl_aluSrc, clk, reset);

memory_access MEM(ctrl_pcSrc,
	read_data_from_mem, mem_address, write_data_into_mem,
	ctrl_branch, zero, ctrl_memRead, ctrl_memWrite, clk, reset);

write_back WB (wb_data, read_data_from_mem, alu_result,
	ctrl_memToReg, clk, reset);



endmodule