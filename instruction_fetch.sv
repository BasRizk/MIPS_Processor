module instruction_fetch (next_instruction ,next_address, current_address, clk);

output reg [31:0] next_instruction, next_address;
input [31:0] current_address;
input clk;

reg [7:0] i_mem [268435455:0];  // The size of the memory is based on 2^28. 28 are the bits PC[27:0] used as address index

always @(clk)
begin    
    next_instruction <= {{i_mem[current_address[27:0]]},
                        {i_mem[current_address[27:0] + 8'b0000_0001]},
                        {i_mem[current_address[27:0] + 8'b0000_0010]},
                        {i_mem[current_address[27:0] + 8'b0000_0011]}};
    next_address <= current_address + 4;
end

endmodule
