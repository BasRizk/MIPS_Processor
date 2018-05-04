module memory_access (
    memory_out, ctrl_pcSrc, read_data_from_mem,                         // OUTPUTS
	mem_address, write_data_into_mem,                               // INPUTS
	ctrl_branch_ex_mem, zero_ex_mem, ctrl_memRead_ex_mem,
	ctrl_memWrite_ex_mem, clk, reset);
    
output reg [1023:0] [31:0] memory_out;
output reg ctrl_pcSrc = 0;
output reg [31:0] read_data_from_mem;

input ctrl_branch_ex_mem, zero_ex_mem , ctrl_memRead_ex_mem , ctrl_memWrite_ex_mem;
input [31:0] mem_address, write_data_into_mem;
input clk, reset;

reg [1023:0] [31:0] memory = 0;

assign memory_out = memory;

always@ (posedge clk or negedge reset)
begin

    if(~reset)
    begin
        memory = 0;
    end
    else begin
        ctrl_pcSrc = (ctrl_branch_ex_mem && zero_ex_mem) ? 1 : 0; 
        
        read_data_from_mem = (ctrl_memRead_ex_mem) ?
            memory[mem_address] : read_data_from_mem;

        memory[mem_address] = (ctrl_memWrite_ex_mem) ?
            write_data_into_mem : memory[mem_address];
    end


end

endmodule