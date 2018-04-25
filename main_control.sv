module main_control(regDest, jump, memToRead, memToReg,
	aluOp, memWrite, aluSrc, regWrite, next_opCode, clk);

output reg regDest, jump, memToRead, memToReg,
	aluOp, memWrite, aluSrc, regWrite;
input [4:0] next_opCode;
input clk;

always @ (posedge clk)
begin

	// Control work... xD

end

endmodule
