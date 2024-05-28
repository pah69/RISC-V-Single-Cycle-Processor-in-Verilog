module decoder(command, ALUcontrol_out);
	input logic [31:0] command;
	output logic [3:0] ALUcontrol_out;

	always_comb
	//always@(command) 
	casex ({command[31], command[14:12], command[6:0]})
		//9'bx_000_11000: ALUcontrol_out <= 4'b0110; // BEQ 
		11'b00000110011: ALUcontrol_out = 4'b0010; // ADD 
		11'b10000110011: ALUcontrol_out = 4'b0110; // SUB 
		11'b01110110011: ALUcontrol_out = 4'b0000; // AND
		11'b01100110011: ALUcontrol_out = 4'b0001; // OR
		11'b?0000010011: ALUcontrol_out = 4'b1010; // ADDI
		11'b?1110010011: ALUcontrol_out = 4'b1000; // ANDI
		11'b?1100010011: ALUcontrol_out = 4'b1001; // ADDI
		default : ALUcontrol_out = 4'b0000;
	endcase
endmodule