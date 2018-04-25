module main_control(regDest, memToRead, memToReg,
	aluOp, memWrite, aluSrc, regWrite, next_opCode);

output reg regDest, memToRead, memToReg,
	aluOp, memWrite, aluSrc, regWrite;
input [4:0] next_opCode;

always @ (next_opCode)
begin

	/*
	? Arithmetic: add, sub, addi
	? Load/Store: lw, sw, lh, lhu
	? Logic: and, or, sll, srl, and, or
	? Control flow: beq
	? Comparison: slt, sltu
	*/

/*
case(next_opCode)
endcase
*/

end

endmodule
