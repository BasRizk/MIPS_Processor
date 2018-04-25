module instruction_fetch (next_instruction ,next_address, new_basic_address, new_branch_address, jump, clk);

output reg [31:0] next_instruction, next_address;
input [31:0] new_basic_address, new_branch_address;
input clk, jump;
reg [7:0] mem [268435455:0];

always @(clk)
begin    
    next_instruction <= {{mem[new_address]}},
                        {{mem[new_address + 8'b0000_0001]}},
                        {{mem[new_address + 8'b0000_0010]}},
                        {{mem[new_address + 8'b0000_0011]}};
    case(jump)
        1'b0 : next_address <= new_address + 8'b0000_0100;
        1'b1 : next_address <= new_branch_address;
    endcase
end

endmodule
