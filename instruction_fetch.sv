module instruction_fetch (next_instruction ,next_address, current_address, clk);

output reg [31:0] next_instruction, next_address;
input [31:0] new_basic_address, new_branch_address;
input clk, jump;

reg [7:0] mem [27:0];

always @(clk)
begin    
    next_instruction <= {{mem[current_address]}},
                        {{mem[current_address + 8'b0000_0001]}},
                        {{mem[current_address + 8'b0000_0010]}},
                        {{mem[current_address + 8'b0000_0011]}};
    next_address <= selected_address + 4;
end

endmodule
