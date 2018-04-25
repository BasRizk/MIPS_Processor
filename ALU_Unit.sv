module ALU_Unit(ALU_result,input1,input2,selectionLines);
    output [31:0] ALU_result;
    input [31:0] input1,input2;
    input [3:0] selectionLines;
    always@(input1,input2,selectionLines) begin
        case(selectionLines)
            //ALU cases to be added
        endcase
    end
    

endmodule