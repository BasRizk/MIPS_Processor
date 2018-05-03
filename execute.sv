module execute (
    branch_or_not_address, zero, ALU_result, write_register,            // OUTPUTS
	read_data_1_id_ex, read_data_2_id_ex,								// INPUTS
	extended_branch_offset_id_ex, supposed_next_address_id_ex,
	ctrl_aluOp_id_ex, ctrl_aluSrc_id_ex,
	next_instruction_20_16_id_ex, next_instruction_15_11_id_ex,
	ctrl_regDest_id_ex,
    clk, reset);

    output reg [31:0] branch_or_not_address, ALU_result;
    output reg zero = 0; 
    output reg [4:0] write_register;

    input [31:0] read_data_1_id_ex, read_data_2_id_ex, extended_branch_offset_id_ex, 
        supposed_next_address_id_ex;
    input [1:0] ctrl_aluOp_id_ex;
    input ctrl_aluSrc_id_ex;
    input [4:0] next_instruction_20_16_id_ex, next_instruction_15_11_id_ex;
    input ctrl_regDest_id_ex;
    input clk, reset;

    reg [3:0] ALU_control;
    reg [31:0] ALU_input2;

    assign ALU_input2 = (ctrl_aluSrc_id_ex == 0)?
        read_data_2_id_ex : extended_branch_offset_id_ex;


    always@(posedge clk or negedge reset) begin
        // TODO reset operations

        // ctrl_regDest MUX using ctrl_regDest coming from ID/EX Pipeline Register
        write_register = (ctrl_regDest_id_ex)?
            next_instruction_15_11_id_ex: next_instruction_20_16_id_ex; 

        case(ctrl_aluOp_id_ex)
            2'b00 : ALU_control = 4'b0010; 
            2'b01 : begin 
                ALU_control = 4'b0110;
                zero = (read_data_1_id_ex == read_data_2_id_ex)? 1 : 0;
            end   
            2'b10 : case(extended_branch_offset_id_ex[5:0])
                    6'b100000 : ALU_control = 4'b0010;
                    6'b100010 : ALU_control = 4'b0110;
                    6'b100100 : ALU_control = 4'b0000;
                    6'b100101 : ALU_control = 4'b0001;
                    6'b101010 : ALU_control = 4'b0111;
                endcase
        endcase
    end

    ALU_Unit alu(ALU_result,read_data_1_id_ex,ALU_input2,ALU_control,clk);
   
    always@(posedge clk) begin
        branch_or_not_address <= supposed_next_address_id_ex + extended_branch_offset_id_ex * 4; 
    end

endmodule

