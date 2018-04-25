module main(clk);

input clk;

// Datapath Wires
wire [31:0] branch_or_not_address, supposed_next_address, next_instruction;
wire [31:0] read_data_1, read_data_2, write_data_into_mem,
		write_data_into_reg, extended_branch_offset;
wire zero;
wire [31:0] alu_result, mem_address, read_data_from_mem, wb_data;

// Ctrl Wires
wire ctrl_regDest, ctrl_branch, ctrl_memRead, ctr_memToReg,
	ctrl_aluOp, ctr_memWrite, ctrl_aluSrc, ctrl_regWrite;


assign write_data_into_mem = read_data_2;			// after exec to mem
assign mem_address = alu_result;					// after exec to mem
assign write_data_into_reg = wb_data;		// after wb to regs file


// DATA PATH
instruction_fetch IF (next_instruction ,supposed_next_address, branch_or_not_address, clk);

instruction_decode ID (read_data_1, read_data_2, extended_branch_offset, next_instruction,
	 write_data_into_reg, ctrl_regDest, ctrl_regWrite, clk);

execute EX (branch_or_not_address, zero, alu_result, supposed_next_address, read_data_1, read_data_2,
	 extended_branch_offset,next_instruction,ctrl_aluOp,ctrl_aluSrc,clk);

memory_access MEM(read_data_from_mem, branch_or_not_address, zero, mem_address, write_data_into_mem, clk);

write_back WB (wb_data, read_data_from_mem, alu_result, clk);


// CONTROLERS
main_control ctrl (ctrl_regDest, ctrl_memToRead, ctrl_memToReg,
	ctrl_aluOp, ctrl_memWrite, ctrl_aluSrc, ctrl_regWrite,
	next_instruction[31:26]);



endmodule