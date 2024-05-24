module InstrMem(
	input clk,rst_n,
	input logic [31:0] addr;
	output logic [31:0] instr;
);
	reg [31:0] addr_imem [0:31];
integer i;

assign instr = addr[addr_iMem];
always@(posedge clk) begin
	if (rst_n == 1'b1) begin
		for (int i = 0; i < 32; i = i + 1)
			addr_iMem[i] = 32'b0;
		end
	end
end




endmodule : InstrMem

