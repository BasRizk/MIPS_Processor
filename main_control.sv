module main_control(regDest, memRead, memToReg,
	aluOp, memWrite, aluSrc, regWrite, next_opCode);

output reg regDest, memRead, memToReg,
	aluOp, memWrite, aluSrc, regWrite;
input [4:0] next_opCode;

always @ (next_opCode)
begin

	/*
	? Arithmetic: add, sub, addi -- DONE
	? Load/Store: lw, sw, lh, lhu -- DONE
	? Logic: and, or, sll, srl, and, or -- DONE
	? Control flow: beq
	? Comparison: slt, sltu -- DONE
	*/


case(next_opCode)

// Arithmetic: add, sub
// Logic: and, or, sll, srl, and, or
// Comparison: slt, sltu
'h0:
begin
	regDest <= 1;
	memRead <= 0;
	memToReg <= 0;
	aluOp <= 1;
	memWrite <= 0;
	aluSrc <= 0;
	regWrite <= 1;
end

// Arithmetic: addi
'h8:
begin
	regDest <= 0;
	memRead <= 0;
	memToReg <= 0;
	aluOp <= 1;
	memWrite <= 0;
	aluSrc <= 1;
	regWrite <= 1;
end
// Load: lw
'h23:
begin
	regDest <= 0;
	memRead <= 1;
	memToReg <= 1;
	aluOp <= 0; 
	memWrite <= 0;
	aluSrc <= 1;
	regWrite <= 1;
end

// Store: sw
'h2B:
begin
	//regDest <= 1;
	memRead <= 0;
	//memToReg <= X;
	aluOp <= 0;
	memWrite <= 1;
	aluSrc <= 1;
	regWrite <= 0;
end

// Load: lh
'h21:
begin
	regDest <= 0;
	memRead <= 1;
	memToReg <= 1;
	aluOp <= 0;
	memWrite <= 0;
	aluSrc <= 1;
	regWrite <= 1;
end

// Load: lhu
'h25:
begin
	regDest <= 0;
	memRead <= 1;
	memToReg <= 1;
	aluOp <= 0;
	memWrite <= 0;
	aluSrc <= 1;
	regWrite <= 1;
end

// Branch: beq
'h4:
begin
	//regDest <= X;
	memRead <= 0;
	//memToReg <= X ;
	aluOp <= 0;
	memWrite <= 0;
	aluSrc <= 0;
	regWrite <= 0;
end

default:
begin
	regDest <= 0;
	memRead <= 0;
	memToReg <= 0 ;
	aluOp <= 0;
	memWrite <= 0;
	aluSrc <= 0;
	regWrite <= 0;
end

endcase


end

endmodule
