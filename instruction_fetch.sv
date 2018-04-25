module instruction_fetch (next_instruction ,next_address, basic_address, jump_address, jump, clk);

output reg [31:0] next_instruction, next_address;
input [31:0] new_basic_address, new_branch_address;
input clk, jump;

reg [7:0] mem [27:0];
reg [31:0] selected_address;

always @(clk)
begin    
    next_instruction <= {{mem[selected_address]}},
                        {{mem[selected_address + 8'b0000_0001]}},
                        {{mem[selected_address + 8'b0000_0010]}},
                        {{mem[selected_address + 8'b0000_0011]}};
    next_address <= selected_address + 4;
end

always @(jump || basic_address || jump_address)
begin
    selected_address = jump? basic_address : jump_address;
end

endmodule
