module memory_access (read_data, new_address, address_mem, write_data,
    branch, zero, MemRead, MemWrite, clk, reset);

output reg [31:0] read_data;
input zero , MemRead , MemWrite, branch;
input [31:0] new_address, address_mem, write_data;
input clk, reset;


reg [31:0] [31:0] memory;
reg [31:0] selected_address;

always@ (posedge clk)
begin

    selected_address <= (zero & branch) ? new_address : address_mem; 
    if (MemRead == 1)
    begin
        read_data <= memory[new_address];
    end
    
    if (MemWrite == 1)
    begin
        memory[new_address] <= write_data;
    end


end

endmodule