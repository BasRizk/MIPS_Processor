module main(clk);

input clk;

// Datapath Wires
wire [31:0] new_address, next_address, next_instruction;
wire [31:0] read_data_1, read_data_2, write_data, extended_address;
wire zero;
wire [31:0] alu_result, address_mem, read_data, wb_data;

// Ctrl Wires
wire ctrl_regDest, ctrl_jump, ctrl_branch, ctrl_memRead, ctr_memToReg,
	ctrl_aluOp, ctr_memWrite, ctrl_aluSrc, ctrl_regWrite;


assign write_data = read_data_2;
assign address_mem = alu_result;



// DATA PATH
instruction_fetch IF (next_instruction ,next_address, new_address, clk);

instruction_decode ID (read_data_1, read_data_2, extended_address, next_instruction,
	 write_data, ctrl_regDest, ctrl_regWrite, clk);

execute EX (new_address, zero, alu_result, next_address, read_data_1, read_data_2,
	 extended_address, clk);

memory_access MEM(read_data, new_address, zero, address_mem, write_data, clk);


//write_data = read_data_2 && address_mem = alu_result //for the sake of meaningfullness
write_back WB (wb_data, read_data, alu_result, clk);


// CONTROLERS
main_control ctrl (regDest, jump, memToRead, memToReg,
	aluOp, memWrite, aluSrc, regWrite, next_instruction[31:26], clk);



endmodule