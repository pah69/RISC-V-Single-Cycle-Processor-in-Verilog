module ALU(data1, data2, ALU_control, ALU_result, Zero);
	input logic [31:0] data1, data2;
	input logic [3:0] ALU_control;
	output logic Zero;
	output logic [31:0] ALU_result;

always@(ALU_control, data1, data2) begin
	case (ALU_control)
		4'b0000: Zero <= 0; 
				ALU_result <= data1 && data2; // AND
		4'b0001: Zero <= 0;
				ALU_result <= data1 || data2; // OR
		4'b0010: Zero <= 0;
				ALU_result <= data1 + data2; // ADD
		4'b0110: Zero <= 0;
				ALU_result <= data1 - data2; // SUB
		default :Zero <= 0; ALU_result <= 0;
	endcase
end
endmodule
