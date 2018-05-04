module ALU_Unit(ALU_result,input1,input2,selectionLines, shamt, clk);
    output reg [31:0] ALU_result;

    input [31:0] input1,input2;
    input [3:0] selectionLines;
    input [4:0] shamt;
    input clk;
    
    always@(*) begin
        case(selectionLines)
            4'b0000 : ALU_result = input1 & input2;
            4'b0001 : ALU_result = input1 | input2;
            4'b0010 : ALU_result = input1 + input2;
            4'b0110 : ALU_result = input1 - input2;
            4'b1011 : ALU_result = (input1 < input2)? 1 : 0;    //sltu
            4'b0111 : ALU_result = ($signed(input1) < $signed(input2))? 1 : 0;   //slt
            4'b1000 : ALU_result = input2 << shamt;
            4'b1001 : ALU_result = input2 >> shamt;
        endcase
    end
    

endmodule