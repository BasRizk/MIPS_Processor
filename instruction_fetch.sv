module instruction_fetch (next_instruction ,supposed_next_address,
    branch_or_not_address, i_mem, ctrl_pcSrc, clk, reset);

output reg [31:0] next_instruction, supposed_next_address;
input [31:0] branch_or_not_address;
input ctrl_pcSrc; // == 1 then to use branch address
input clk, reset;
input reg [7:0] i_mem [255:0];  // The size of the memory is based on 2^28. 28 are the bits PC[27:0] used as address index
                                // The 2^28 does not work, so 255 is used for now

reg [31:0] target_address;

always @(posedge clk)
begin
    target_address <= (ctrl_pcSrc)? branch_or_not_address : supposed_next_address;
    
    next_instruction <= {{i_mem[target_address[27:0]]},
                        {i_mem[target_address[27:0] + 1]},
                        {i_mem[target_address[27:0] + 1]},
                        {i_mem[target_address[27:0] + 1]}};

    supposed_next_address <= target_address + 4;
end

endmodule
