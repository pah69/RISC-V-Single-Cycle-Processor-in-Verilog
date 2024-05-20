module regfile(clk, rst_n, RegWrite, rs1, rs2, rd, wr_data, rd_data1, rd_data2);
	input logic clk, rst_n, RegWrite;
	input logic [4:0] rs1, rs2, rd;
	input [31:0] wr_data;
	output [31:0] rd_data1, rd_data2;

	reg [31:0] registers [31:0];

	integer i;
always @(posedge clk) begin
	if (rst_n == 1'b1) begin
		for (i = 0; i < 32; i = i + 1) begin
			registers[i] = 32'h0;
		end
	end
	else if (RegWrite == 1'b1) begin
		registers[rd] = wr_data;
	end
end

always_comb
rd_data1 = registers[rs1];
rd_data2 = registers[rs2];
end

endmodule

	 