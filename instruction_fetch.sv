module instruction_fetch (next_instruction ,next_address, new_address, clk);

output reg [31:0] next_instruction, next_address;
input [31:0] new_address;
input clk;

always @(new_address)
begin
    next_instruction <= new_address;
    next_address <= new_address + 1;
end

endmodule
