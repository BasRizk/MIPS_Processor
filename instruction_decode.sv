module instruction_decode ( read_data_1, read_data_2, extended_address,
 next_instruction, write_data, clk, ctrl_reg_dest, ctrl_reg_write, reset);

    output reg ctrl_reg_dest, ctrl_reg_write;
    output reg [31:0] read_data_1, read_data_2, extended_address;
    input [31:0] next_instruction, write_data;
    input clk, reset;

    reg [31:0] [31:0] register_file = 0;

    //reg [25:0] target_address_inst_25_0;
    reg [31:26] inst_31_26;
    reg [25:21] rs_read_reg_1;
    reg [20:16] rt_read_reg_2;
    reg [15:11] rd_inst_15_11;
    reg [15:0] address_immed;

    reg [4:0] write_register;

    //assign write_register = (ctrl_reg_dest)? next_instruction[15:11]:next_instruction[20:16];

    always@ (posedge clk or negedge reset)
    begin
        if(~reset)
        begin
            inst_31_26 <= 0;
            rs_read_reg_1 <= 0;
            rt_read_reg_2 <= 0;
            rd_inst_15_11 <= 0;
            address_immed <= 0;
        end


        // Variables for clarification on the fly
        //target_address_inst_25_0 <= next_instruction[25:0];
        inst_31_26 <= next_instruction[31:26];
        rs_read_reg_1 <= next_instruction[25:21];
        rt_read_reg_2 <= next_instruction[20:16];
        rd_inst_15_11 <= next_instruction[15:11];
        address_immed <= next_instruction[15:0];

        // Updating outputs
        read_data_1 <= register_file[rs_read_reg_1];
        read_data_2 <= register_file[rt_read_reg_2];
        extended_address <= { {16{address_immed[15]}}, address_immed };

        // RegDest Mux
        write_register <= (ctrl_reg_dest)? rd_inst_15_11: rt_read_reg_2; 

        register_file[write_register] <= (ctrl_reg_write && write_register != 0)?
        write_data: register_file[write_register];

    end


endmodule

