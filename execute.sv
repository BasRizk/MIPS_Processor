module execute (new_address, zero, ALU_result, next_address,
    read_data_1, read_data_2, extended_address,ALU_op,ALU_src);
   
   output reg [31:0] new_address, ALU_result, next_address;
   output reg zero; 
   input [31:0] read_data_1, read_data_2, extended_address;
   input [1:0] ALU_op;
   input ALU_src;
   reg [3:0] ALU_control;
   reg [31:0] ALU_input2;
   
   always@(read_data_1,read_data_2,extended_address,ALU_op,ALU_src) begin
       ALU_input2 = (ALU_src == 0)? read_data_2 : extended_address;
       case(ALU_op)
           2'b00 : ALU_control = 4'b0010; 
           2'b01 : ALU_control = 4'b0110;
           2'b10 : case(extended_address[5:0])
                   6'b100000 : ALU_control = 4'b0010;
                   6'b100010 : ALU_control = 4'b0110;
                   6'b100100 : ALU_control = 4'b0000;
                   6'b100101 : ALU_control = 4'b0001;
                   6'b101010 : ALU_control = 4'b0111;
               endcase
       endcase
   end
   ALU_Unit alu(ALU_result,read_data_1,ALU_input2,ALU_control);
   
   
   endmodule