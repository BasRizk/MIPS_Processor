module instruction_fetch (next_instruction ,next_address, new_address, clk);

output reg [31:0] next_instruction, next_address;
input [31:0] new_address;
input clk;
reg [31:0] mem [67108863:0];

always @(clk)
begin    
    next_instruction <= mem[new_address];
    next_address <= new_address + 4;
end

endmodule
