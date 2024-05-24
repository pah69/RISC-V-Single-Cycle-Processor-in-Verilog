module ALUcontrol(ALUOp, func7, func3, ALUcontrol_out);
	input logic [1:0] ALUOp_in;
	input logic [31:25] func7;
	input logic [14:12] func3;
	output logic [3:0] ALUcontrol_out;

	always_comb
	case ({ALUOp, func7, func3})
		12'b00_xxxxxxx_xxx: ALUcontrol_out <= 4'b0010;
		12'bx1_xxxxxxx_xxx: ALUcontrol_out <= 4'b0110;
		12'b1x_0000000_000: ALUcontrol_out <= 4'b0010;
		12'b1x_0100000_000: ALUcontrol_out <= 4'b0110;
		12'b1x_0000000_111: ALUcontrol_out <= 4'b0000;
		12'b1x_0000000_110: ALUcontrol_out <= 4'b0001;
		default : ALUcontrol_out = 4'b0000;
	endcase
		end
	end