`timescale 1ps/1ps

module basic_mips_testbench();

reg clk, reset;
reg input_program;

initial begin
    clk <= 1'b0;
	reset <= 1'b1;
	forever #10 clk <= ~clk;
end

endmodule