module instruction_fetch (
    next_instruction ,supposed_next_address,			// OUTPUTS
	branch_or_not_address_ex_mem,           		    // INPUTS
	i_mem, ctrl_pcSrc, clk, reset);
    
output reg [31:0] next_instruction;
output reg [31:0] supposed_next_address = 0;

input [31:0] branch_or_not_address_ex_mem;
input ctrl_pcSrc; // == 1 then to use branch address
input clk, reset;

input reg [7:0] i_mem [255:0]; 
// The size of the memory is based on 2^28. 28 are the bits PC[27:0] used as address index
// The 2^28 does not work, so 255 is used for now


wire [31:0] supposed_next_address_pass;
reg [31:0] target_address = 0;

assign supposed_next_address_pass = supposed_next_address;

always @(posedge clk or negedge reset)
begin
    if(~reset) begin
        next_instruction <= 0;
        supposed_next_address <= 0;
    end
    else begin
        target_address <= (ctrl_pcSrc)? branch_or_not_address_ex_mem : supposed_next_address_pass;

        next_instruction <= {{i_mem[target_address[27:0] + 3]},
                        {i_mem[target_address[27:0] + 2]},
                        {i_mem[target_address[27:0] + 1]},
                        {i_mem[target_address[27:0] + 0]}};

        supposed_next_address <= target_address + 4;
    end
 
end

endmodule
