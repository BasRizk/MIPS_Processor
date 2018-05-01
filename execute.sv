module execute (branch_or_not_address, supposed_next_address_pass, zero, ALU_result, read_data_1, read_data_2,
    extended_branch_offset, supposed_next_address, ctrl_aluOp, ctrl_aluSrc,
    clk, reset);

    output reg [31:0] branch_or_not_address, ALU_result;
    output [31:0] supposed_next_address_pass;
    output reg zero = 0; 

    input [31:0] read_data_1, read_data_2, extended_branch_offset, 
    supposed_next_address;
    input [1:0] ctrl_aluOp;
    input ctrl_aluSrc;
    input clk, reset; 

    reg [3:0] ALU_control;
    reg [31:0] ALU_input2;

    assign supposed_next_address_pass = supposed_next_address;
    assign ALU_input2 = (ctrl_aluSrc == 0)? read_data_2 : extended_branch_offset;

    always@(posedge clk or negedge reset) begin

        case(ctrl_aluOp)
            2'b00 : ALU_control = 4'b0010; 
            2'b01 : begin 
                ALU_control = 4'b0110;
                zero = 1;
            end   
            2'b10 : case(extended_branch_offset[5:0])
                    6'b100000 : ALU_control = 4'b0010;
                    6'b100010 : ALU_control = 4'b0110;
                    6'b100100 : ALU_control = 4'b0000;
                    6'b100101 : ALU_control = 4'b0001;
                    6'b101010 : ALU_control = 4'b0111;
                endcase
        endcase
    end

    ALU_Unit alu(ALU_result,read_data_1,ALU_input2,ALU_control);
   
    always@(posedge clk) begin
        branch_or_not_address <= supposed_next_address + extended_branch_offset * 4; 
    end

endmodule

