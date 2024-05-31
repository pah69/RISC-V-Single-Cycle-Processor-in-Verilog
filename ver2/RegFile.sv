module RegFile(clk, rst_n, RegWrite, rs1, rs2, rd, wr_data, rs1_data, rs2_data);
	input logic clk, rst_n, RegWrite;
	input logic [4:0] rs1, rs2, rd;
	input logic [31:0] wr_data;
	output logic [31:0] rs1_data, rs2_data;

	reg [31:0] registers [31:0];

	integer i;
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			for (i = 0; i < 32; i = i + 1) begin
				registers[i] = 32'h0;
			end
		end
		else if (RegWrite) begin
			registers[rd] = wr_data;
		end
	end

	always_comb
	begin
		rs1_data = registers[rs1];
		rs2_data = registers[rs2];
	end

endmodule

	 
