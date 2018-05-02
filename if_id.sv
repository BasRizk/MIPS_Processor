module if_id (next_instruction_if_id, supposed_next_address_if_id,		
	next_instruction, supposed_next_address, clk, reset);

output reg [31:0] next_instruction_if_id, supposed_next_address_if_id;

input [31:0] next_instruction, supposed_next_address;
input clk, reset;

always @ (posedge clk or negedge reset)
begin
    if(~reset) begin
        next_instruction_if_id <= 0;
        supposed_next_address_if_id <= 0;
    end
    else begin
        next_instruction_if_id <= next_instruction;
        supposed_next_address_if_id <= supposed_next_address;
    end

end

endmodule