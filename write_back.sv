module write_back (wb_data, read_data_from_mem, alu_result,
    ctrl_memToReg, clk, reset);

output reg [31:0] wb_data;
input [31:0] read_data_from_mem, alu_result;
input ctrl_memToReg, clk, reset;

// neg edge clk as the same time instruction_decode at posedge clk
always@(negedge clk or negedge reset)
begin
    wb_data <= ctrl_memToReg ? read_data_from_mem : alu_result;
end

endmodule