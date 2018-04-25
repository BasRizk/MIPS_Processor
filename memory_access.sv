module memory_access (read_data, new_address, address_mem, write_data zero, MemRead, MemWrite, clk);

output reg [31:0] read_data;
input zero , MemRead , MemWrite;
input [31:0] new_address, address_mem, write_data;
input clk;


reg [31:0] [31:0] memory;

always@ (posedge clk)
begin

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