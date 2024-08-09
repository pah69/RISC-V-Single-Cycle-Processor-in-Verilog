module ALUcontrol(ALUOp, func7, func3, ALUcontrol_out);
	input logic [1:0] ALUOp_in;
	input logic [31:25] func7;
	input logic [14:12] func3;
	output logic [3:0] ALUcontrol_out;

	always_comb
	case ({ALUOp, func7, func3})
		12'b00_xxxxxxx_xxx: ALUcontrol_out <= 4'b0010; // Load or Store - Add 
 		12'bx1_xxxxxxx_xxx: ALUcontrol_out <= 4'b0110; // BEQ - subtract
		12'b1x_0000000_000: ALUcontrol_out <= 4'b0010; // ADD - R type
		12'b1x_0100000_000: ALUcontrol_out <= 4'b0110; // SUB - R Type
		12'b1x_0000000_111: ALUcontrol_out <= 4'b0000; // AND- R type
		12'b1x_0000000_110: ALUcontrol_out <= 4'b0001; // OR - R type
		default : ALUcontrol_out = 4'b0000;
	endcase
		end
	end
endmodule
