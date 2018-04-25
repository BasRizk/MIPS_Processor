module main_control(regDest, jump, memToRead, memToReg,
	aluOp, memWrite, aluSrc, regWrite, next_opCode, clk);

output reg regDest, jump, memToRead, memToReg,
	aluOp, memWrite, aluSrc, regWrite;
input [4:0] next_opCode;
input clk;

always @ (posedge clk or next_opCode)
begin

case

	/*
	? Arithmetic: add, sub, addi
	? Load/Store: lw, sw, lh, lhu
	? Logic: and, or, sll, srl, and, or
	? Control flow: beq
	? Comparison: slt, sltu
	*/

end

endmodule
