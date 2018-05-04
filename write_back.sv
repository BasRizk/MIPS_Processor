module write_back (
    wb_data,													// OUTPUTS						
	read_data_from_mem_mem_wb, alu_result_mem_wb,				// INPUTS
	ctrl_memToReg_mem_wb, clk, reset);

output reg [31:0] wb_data;

input [31:0] read_data_from_mem_mem_wb, alu_result_mem_wb;
input ctrl_memToReg_mem_wb;
input clk, reset;

// neg edge clk as the same time instruction_decode at posedge clk
always@(negedge clk or negedge reset)
begin
    if(~reset) begin
        wb_data = 0;
    end
    else begin
        wb_data = ctrl_memToReg_mem_wb ? read_data_from_mem_mem_wb : alu_result_mem_wb;
    end
end

endmodule