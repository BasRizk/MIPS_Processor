module write_back (wb_data, read_data, alu_result, MemtoReg, clk);

output reg [31:0] wb_data;
input [31:0] read_data, alu_result;
input clk, MemtoReg;

// neg edge clk as the same time instruction_decode at posedge clk
always@(negedge clk)
begin
    wb_data <= MemtoReg ? read_data : alu_result;
end

endmodule