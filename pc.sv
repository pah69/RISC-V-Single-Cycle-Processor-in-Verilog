module pc(clk, rst_n, pc_in, pc_out);
	input clk, rst_n;
	input logic [31:0] pc_in;
	output logic [31:0] pc_out;
	always @(posedge clk)
	if (rst_n == 1)
		pc_out <= 32'h0;
		else
		pc_out <= pc_in;
	end
endmodule :

module pc_plus4(from_pc, next_pc);
	input logic [31:0] from_pc;
	output logic [31:0] next_pc;
	always_comb next_pc = from_pc + 32'h00000004;

endmodule : pc_plus4

module adder (in1, in2, sum);
	input logic [31:0] in1, in2;
	output logic [31:0] sum;

	always_comb sum = in1 + in2;
	


endmodule : adder