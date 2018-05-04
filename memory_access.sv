module memory_access (
    memory_out, ctrl_pcSrc, read_data_from_mem,                         // OUTPUTS
	mem_address, write_data_into_mem,                               // INPUTS
	ctrl_branch_ex_mem, zero_ex_mem, ctrl_memRead_ex_mem,
	ctrl_memWrite_ex_mem, ctrl_halfword_signed_ex_mem,
    clk, reset);
    
output reg [4096:0] [7:0] memory_out;
output reg ctrl_pcSrc = 0;
output reg [31:0] read_data_from_mem;

input ctrl_branch_ex_mem, zero_ex_mem , ctrl_memRead_ex_mem , ctrl_memWrite_ex_mem;
input [31:0] mem_address, write_data_into_mem;
input [1:0] ctrl_halfword_signed_ex_mem;
input clk, reset;

reg [4096:0] [7:0] memory = 0;

assign memory_out = memory;

always@ (posedge clk or negedge reset)
begin

    if(~reset)
    begin
        memory = 0;
    end
    else begin
        ctrl_pcSrc = (ctrl_branch_ex_mem && zero_ex_mem) ? 1 : 0; 
        
        if(ctrl_memRead_ex_mem && ctrl_halfword_signed_ex_mem == 2'b11) begin
            read_data_from_mem =
                {{8{memory[mem_address + 1]}},
                 {8{memory[mem_address + 1]}},
                      memory[mem_address + 1],
                      memory[mem_address + 0]};            
        end
        else
        if (ctrl_memRead_ex_mem && ctrl_halfword_signed_ex_mem == 2'b10) begin
            read_data_from_mem =
                {{8{0}}, {8{0}},
                      memory[mem_address + 1],
                      memory[mem_address + 0]};
        end
        else begin
            read_data_from_mem = (ctrl_memRead_ex_mem && ctrl_halfword_signed_ex_mem == 2'b00) ?
                {memory[mem_address + 3],
                memory[mem_address + 2],
                memory[mem_address + 1],
                memory[mem_address + 0]} : read_data_from_mem;
        end

        memory[mem_address + 3] = (ctrl_memWrite_ex_mem) ?
            write_data_into_mem[31:24] : memory[mem_address + 3];

        memory[mem_address + 2] = (ctrl_memWrite_ex_mem) ?
            write_data_into_mem[23:16] : memory[mem_address + 2];

        memory[mem_address + 1] = (ctrl_memWrite_ex_mem) ?
            write_data_into_mem[15:8] : memory[mem_address + 1];
        
        memory[mem_address + 0] = (ctrl_memWrite_ex_mem) ?
            write_data_into_mem[7:0] : memory[mem_address + 0];


    end


end

endmodule