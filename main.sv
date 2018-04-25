module main();

wire [31:0] new_address, next_address, next_instruction;
wire [31:0] read_data_1, read_data_2, write_data, extended_address;
wire zero;
wire [31:0] alu_result, address_mem, read_data, wb_data;

assign write_data = read_data_2;
assign address_mem = alu_result;

instruction_fetch IE (next_instruction ,next_address, new_address);
instruction_decode ID (read_data_1, read_data_2, extended_address, next_instruction, write_data);
execute EX (new_address, zero, alu_result, next_address, read_data_1, read_data_2, extended_address);
memory_access MEM(read_data, new_address, zero, address_mem, write_data);
//write_data = read_data_2 && address_mem = alu_result //for the sake of meaningfullness
write_back WB (wb_data, read_data, alu_result);


endmodule