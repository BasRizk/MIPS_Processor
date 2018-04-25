module ALU_Unit(ALU_result,input1,input2,selectionLines);
    output reg [31:0] ALU_result;
    input [31:0] input1,input2;
    input [3:0] selectionLines;

    always@(input1,input2,selectionLines) begin
        case(selectionLines)
            4'b0000 : ALU_result = input1 & input2;
            4'b0001 : ALU_result = input1 | input2;
            4'b0010 : ALU_result = input1 + input2;
            4'b0110 : ALU_result = input1 - input2;
            4'b0111 : ALU_result = (input1 < input2)? 1 : 0;
        endcase
    end
    

endmodule