module ImmGen(instr, ImmOut);
	input logic [31:0] instr;
	output logic [31:0] ImmOut;

	always_comb
	case (instr[6:0])
	// 7'b0110011: ImmOut <=   // R instruction

		7'b0010111: ImmOut <= {{20{instr[31]}}, instr[31:20]}; // I instruction

		//7'b0000011: // Load instruction

		7'b0100011: ImmOut <= {{20{instr[31]}}, instr[31:25], instr[11:7]}; // S instruction

		7'b1100011: ImmOut <= {{19{instr[31]}}, instr[31], instr[30:25], instr[11:8], 1'b0};// B instruction

		//7'b1101111: ImmOut <= {{instr[31]}}, instr[]} // J instruction

		7'b0110111: ImmOut <= {{12{instr[31]}}, instr[31:12]}; // U instruction

		default : ImmOut <= {{20{instr[31]}}, instr[31:20]};
	endcase

endmodule : ImmGen