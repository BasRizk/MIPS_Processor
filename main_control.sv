module main_control(ctrl_regDest, ctrl_branch, ctrl_memRead, ctrl_memToReg,
	ctrl_aluOp, ctrl_memWrite, ctrl_aluSrc, ctrl_regWrite,
	next_opCode, reset);

output reg ctrl_regDest = 0, ctrl_branch = 0, ctrl_memRead = 0,
	ctrl_memToReg = 0, ctrl_memWrite = 0, ctrl_aluSrc = 0,
	ctrl_regWrite = 0;
output reg [1:0] ctrl_aluOp = 0;
input [5:0] next_opCode;
input reset;

wire [7:0] opcode_extended;
assign opcode_extended = {{{2'b00}}, next_opCode };

always @ (opcode_extended or negedge reset)
begin

	// Set next_opCode to a value that goes to default, and reset parameters
	if(~reset) begin
		ctrl_regDest = 0;
		ctrl_branch = 0;  //TODO this everywhere, or maybe somewhere else
		ctrl_memRead = 0;
		ctrl_memToReg = 0 ;
		ctrl_aluOp = 0;
		ctrl_memWrite = 0;
		ctrl_aluSrc = 0;
		ctrl_regWrite = 0;
	end
	else begin

		case(opcode_extended)

			// Arithmetic: add, sub
			// Logic: and, or, sll, srl, and, or
			// Comparison: slt, sltu
			'h0:
			begin
				ctrl_regDest = 1;
				ctrl_memRead = 0;
				ctrl_memToReg = 0;
				ctrl_aluOp = 2'b10;
				ctrl_memWrite = 0;
				ctrl_aluSrc = 0;
				ctrl_regWrite = 1;
			end

			// Arithmetic: addi
			'h8:
			begin
				ctrl_regDest = 0;
				ctrl_memRead = 0;
				ctrl_memToReg = 0;
				ctrl_aluOp = 2'b10;
				ctrl_memWrite = 0;
				ctrl_aluSrc = 1;
				ctrl_regWrite = 1;
			end
			// Load: lw
			'h23:
			begin
				ctrl_regDest = 0;
				ctrl_memRead = 1;
				ctrl_memToReg = 1;
				ctrl_aluOp = 2'b00; 
				ctrl_memWrite = 0;
				ctrl_aluSrc = 1;
				ctrl_regWrite = 1;
			end

			// Store: sw
			'h2B:
			begin
				//ctrl_regDest = 1;
				ctrl_memRead = 0;
				//ctrl_memToReg = X;
				ctrl_aluOp = 2'b00;
				ctrl_memWrite = 1;
				ctrl_aluSrc = 1;
				ctrl_regWrite = 0;
			end

			// Load: lh
			'h21:
			begin
				ctrl_regDest = 0;
				ctrl_memRead = 1;
				ctrl_memToReg = 1;
				ctrl_aluOp = 2'b00;
				ctrl_memWrite = 0;
				ctrl_aluSrc = 1;
				ctrl_regWrite = 1;
			end

			// Load: lhu
			'h25:
			begin
				ctrl_regDest = 0;
				ctrl_memRead = 1;
				ctrl_memToReg = 1;
				ctrl_aluOp = 2'b00;
				ctrl_memWrite = 0;
				ctrl_aluSrc = 1;
				ctrl_regWrite = 1;
			end

			// Branch: beq
			'h4:
			begin
				//ctrl_regDest = X;
				ctrl_memRead = 0;
				//ctrl_memToReg = X ;
				ctrl_aluOp = 2'b01;
				ctrl_memWrite = 0;
				ctrl_aluSrc = 0;
				ctrl_regWrite = 0;
			end

			default:
			begin
				ctrl_regDest = 0;
				ctrl_memRead = 0;
				ctrl_memToReg = 0 ;
				ctrl_aluOp = 0;
				ctrl_memWrite = 0;
				ctrl_aluSrc = 0;
				ctrl_regWrite = 0;
			end

		endcase
	end
	
end

endmodule
