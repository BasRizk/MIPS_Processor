`timescale 1ps/1ps

module basic_mips_testbench();

reg clk, reset;
reg [7:0] instruction_mem [255:0];

wire [31:0] alu_result;


initial
begin
    clk = 1'b0;
	reset = 1'b1;
	instruction_mem[3:0] = '{8'h20, 8'h0a, 8'h00, 8'h0a};
	$display("instruction_mem[3:0] = %p ", instruction_mem[3:0]);
	forever #100 clk = ~clk;
end

main MIPS (alu_result, instruction_mem, clk, reset);

always @ (clk)
begin
	$monitor("time", $time, " alu_result = %b", alu_result);
end

initial #10000 $finish;


endmodule