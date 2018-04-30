module memory_access (
    ctrl_pcSrc, read_data_from_mem, mem_address, write_data_into_mem,
    ctrl_branch, zero, ctrl_memRead, ctrl_memWrite, clk, reset);

output reg ctrl_pcSrc = 0;
output reg [31:0] read_data_from_mem = 0;

input ctrl_branch, zero , ctrl_memRead , ctrl_memWrite;
input [31:0] mem_address, write_data_into_mem;
input clk, reset;


reg [1023:0] [31:0] memory;

always@ (posedge clk or negedge reset)
begin

    if(~reset)
    begin
        memory <= 0;
    end

    ctrl_pcSrc <= (ctrl_branch && zero) ? 1 : 0; 
    
    if (ctrl_memRead == 1)
    begin
        read_data_from_mem <= memory[mem_address];
    end
    
    if (ctrl_memWrite == 1)
    begin
        memory[mem_address] <= write_data_into_mem;
    end


end

endmodule