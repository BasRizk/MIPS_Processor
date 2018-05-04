`timescale 1ps/1ps

module basic_mips_testbench();

reg clk, reset;
reg [7:0] instruction_mem [255:0];

wire [31:0] next_instruction;
wire [31:0] alu_result;

reg [1:0] countNOP;


initial
begin
	countNOP = 0;	//ZERO CONSECUTIVE NOP INSTRUCTIONS SEEN 
    clk = 1'b0;
	reset = 1'b1;
	instruction_mem = '{default:0};
	
	// addi $10, $0, 10 expected $10 = 10
	$display("addi $10, $0, 10 expected $10 = 10");
	instruction_mem[3:0] = '{8'h20, 8'h0a, 8'h00, 8'h0a};

	// addi $12, $0, 11 expected $12 = 11
	$display("addi $12, $0, 11 expected $12 = 11");
	instruction_mem[7:4] = '{8'h20, 8'h0c, 8'h00, 8'h0b};
	
	$display("NOP");
	instruction_mem[11:8] = '{8'h00, 8'h00, 8'h00, 8'h00};
	
	$display("NOP");
	instruction_mem[15:12] = '{8'h00, 8'h00, 8'h00, 8'h00};

	$display("NOP");
	instruction_mem[19:16] = '{8'h00, 8'h00, 8'h00, 8'h00};
	/*
	// sw $10, 0($10) expected memory[(0*4) + 10] = 21
	$display("sw $10, 0($10) expected memory[10] = 21");
	instruction_mem[23:20] = '{8'had, 8'h4a, 8'h00, 8'h00};

	$display("NOP");
	instruction_mem[27:24] = '{8'h00, 8'h00, 8'h00, 8'h00};
	
	$display("NOP");
	instruction_mem[31:28] = '{8'h00, 8'h00, 8'h00, 8'h00};

	$display("NOP");
	instruction_mem[35:32] = '{8'h00, 8'h00, 8'h00, 8'h00};

	// lw $16, 0($10) expected $16 = memory[(0*4) + 10]
	$display("lw $16, 0($10) expected $16 = memory[(0*4) + 10]");
	instruction_mem[39:36] = '{8'h8d, 8'h50, 8'h00, 8'h00};
*/
	
	// add $11, $12, $10 expected $11 = 21
	$display("add $11, $11, $10 expected $11 = 21");
	instruction_mem[23:20] = '{8'h01, 8'h8a, 8'h58, 8'h20};
	
	// sub $13, $12, $10 expected $13 = 1
	$display("sub $13, $12, $10 expected $13 = 1");
	instruction_mem[27:24] = '{8'h01, 8'h8a, 8'h68, 8'h22};

	// and $14, $10, $12 expected $14 = 10
	$display("and $14, $10, $12 expected $14 = 10");
	instruction_mem[31:28] = '{8'h01, 8'h4c, 8'h70, 8'h24};

	// or $15, $12, $10 expected $15 = 11
	$display("or $15, $12, $10 expected $15 = 11");
	instruction_mem[31:28] = '{8'h01, 8'h8a, 8'h78, 8'h25};

	// sw $11, 0($10) expected memory[(0*4) + 10] = 21
	$display("sw $11, 0($10) expected memory[10] = 21");
	instruction_mem[35:32] = '{8'had, 8'h4b, 8'h00, 8'h00};

	$display("NOP");
	instruction_mem[39:36] = '{8'h00, 8'h00, 8'h00, 8'h00};
	
	$display("NOP");
	instruction_mem[43:40] = '{8'h00, 8'h00, 8'h00, 8'h00};

	$display("NOP");
	instruction_mem[47:44] = '{8'h00, 8'h00, 8'h00, 8'h00};

	// lw $16, 0($10) expected $16 = memory[(0*4) + 10]
	$display("lw $16, 0($10) expected $16 = memory[(0*4) + 10]");
	instruction_mem[51:48] = '{8'h8d, 8'h50, 8'h00, 8'h00};
	
	forever #100 clk = ~clk;
end

main MIPS (next_instruction, alu_result, instruction_mem, clk, reset);

always @ (clk)
begin
	//if(reset == 1'b0) begin reset = 1'b1; end
	$display("time", $time," next_instuction = %h, alu_result = %d",
	next_instruction, alu_result);

	/*
	if(next_instruction == 32'b0000_0000_0000_0000_0000_0000_0000) begin
		countNOP = countNOP + 1;
	end
	else begin
		countNOP = 0;
	end
	
	if(countNOP == 4) begin

		#200 $finish;
		// terminate after 1 clk cycle 
		// once reading a nop instuction
	end
	*/
end

//initial #3000 $finish;
initial #3800 $finish;

endmodule