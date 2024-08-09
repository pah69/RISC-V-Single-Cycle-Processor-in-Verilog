module alu(data1, data2, ALU_control, imm, ALU_result);
	input logic [31:0] data1, data2;
	input logic [3:0] ALU_control;
	input logic [31:0] imm;
	output logic [31:0] ALU_result;

always@(ALU_control, data1, data2, imm) 
begin
	case (ALU_control)
		4'b0000: begin 
				ALU_result <= data1 && data2; end// AND 
		4'b0001: begin 
				ALU_result <= data1 || data2; end // OR
		4'b0010: begin
				ALU_result <= data1 + data2; end // ADD
		4'b0110: begin 
				ALU_result <= data1 - data2; end // SUB
		4'b1010: begin 
				ALU_result <= data1 + {20'b00000000000000000000, imm[11:0]}; end // ADDI
		4'b1000: begin 
				ALU_result <= data1 + {20'b00000000000000000000, imm[11:0]}; end // ANDI
		4'b1001: begin
				ALU_result <= data1 + {20'b00000000000000000000, imm[11:0]}; end// ORI
		default: begin ALU_result <= 0; end
	endcase
end
endmodule 
