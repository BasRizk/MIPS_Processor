`timescale 1ps/1ps

module basic_mips_testbench();

reg clk, reset;
reg [7:0] instruction_mem [255:0];

wire [31:0] next_instruction;
wire [31:0] alu_result;


initial
begin
    clk = 1'b0;
	reset = 1'b1;
	instruction_mem = '{default:0};
	
	// addi $10, $0, 10 expected $10 = 10
	$display("addi $10, $0, 10 expected $10 = 10");
	instruction_mem[3:0] = '{8'h20, 8'h0a, 8'h00, 8'h0a};
	$display("instruction entered = %h%h%h%h ", instruction_mem[3],
	instruction_mem[2], instruction_mem[1],instruction_mem[0]);

	// add $11, $11, $10 expected $11 = 10
	$display("add $11, $11, $10 expected $11 = 10");
	instruction_mem[7:4] = '{8'h01, 8'h6a, 8'h58, 8'h20};
	$display("instruction entered = %h%h%h%h ", instruction_mem[7],
	instruction_mem[6], instruction_mem[5],instruction_mem[4]);

	// addi $10, $0, 13 expected  $10 = 13
	$display("addi $10, $0, 13 expected  $10 = 13");
	instruction_mem[11:8] = '{8'h20, 8'h0a, 8'h00, 8'h0d};
	$display("instruction entered = %h%h%h%h ", instruction_mem[11],
	instruction_mem[10], instruction_mem[9],instruction_mem[8]);

	// sub $12, $10, $11 expected $12 = 3
	$display("sub $12, $11, $0 expected $12 = 3");
	instruction_mem[15:12] = '{8'h01, 8'h4b, 8'h60, 8'h22};
	$display("instruction entered = %h%h%h%h ", instruction_mem[15],
	instruction_mem[14], instruction_mem[13],instruction_mem[12]);

	// sw $12, 0($10) expected memory[(0*4) + 10] = 3
	$display("sw $12, 0($10) expected memory[10] = 3");
	instruction_mem[19:16] = '{8'had, 8'h4c, 8'h00, 8'h00};
	$display("instruction entered = %h%h%h%h ", instruction_mem[19],
	instruction_mem[18], instruction_mem[17],instruction_mem[16]);

	// lw $13, 0($10) expected $13 = memory[(0*4) + 10]
	$display("lw $13, 0($10) expected $13 = memory[(0*4) + 10]");
	instruction_mem[23:20] = '{8'h8d, 8'h4d, 8'h00, 8'h00};
	$display("instruction entered = %h%h%h%h ", instruction_mem[23],
	instruction_mem[22], instruction_mem[21],instruction_mem[20]);


	forever #100 clk = ~clk;
end

main MIPS (next_instruction, alu_result, instruction_mem, clk, reset);

always @ (clk or next_instruction or alu_result)
begin
	//if(reset == 1'b0) begin reset = 1'b1; end
	$display("time", $time," next_instuction = %b, alu_result = %b",
	next_instruction, alu_result);

	if(next_instruction == 32'b0000_0000_0000_0000_0000_0000_0000)
	begin
		#600 $finish;
		// terminate after 3 clk cycles once 
		// reading a nop instuction
	end
end


endmodule