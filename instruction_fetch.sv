module instruction_fetch (next_instruction ,next_address, new_address);

output reg [31:0] next_instruction, next_address;
input [31:0] new_address;

always @(new_address)
begin
    next_instruction <= new_address;
    next_address = new_address + 1;
end

endmodule
