module registerCtrl(
	input logic clk, rst_n,
	input logic [31:0] instr,
	output logic RegWrite,
	output logic [4:0] rs1, rs2, rd
);

	always_comb
	casex (instr[6:0])
		7'b0110011: begin rd <= instr[11:7]; rs1 <= instr[19:15]; rs2 <= instr[24:20]; RegWrite = 1; end //R-type
		7'b0010111:	begin rd <= instr[11:7]; rs1 <= instr[19:15]; RegWrite = 1; end //I-type
		7'b?100011: begin rs1 <= instr[19:15]; rs2 <= instr[24:20]; RegWrite = 0; end //B-type or S-type
		7'b0?10111: begin rd <= instr[11:7]; RegWrite = 1; end //U-type or J-type
		7'b1101111: begin rd <= instr[11:7]; RegWrite = 1; end
	endcase
endmodule 