module InstrMem(
	input clk, rst_n,
	input logic [31:0] addr,
	output logic [31:0] instr
);
reg [7:0] addr_iMem [0:127];

initial begin
	addr_iMem[0] = 8'h13;
	addr_iMem[1] = 8'h05;
	addr_iMem[2] = 8'h00;
	addr_iMem[3] = 8'h01;
	addr_iMem[4] = 8'h93;
	addr_iMem[5] = 8'h05;
	addr_iMem[6] = 8'hB0;
	addr_iMem[7] = 8'h02;
	addr_iMem[8] = 8'h33;
	addr_iMem[9] = 8'h06;
	addr_iMem[10] = 8'hB5;
	addr_iMem[11] = 8'h00;
	addr_iMem[12] = 8'h13;
	addr_iMem[13] = 8'h00;
	addr_iMem[14] = 8'h00;
	addr_iMem[15] = 8'h00;
end //ROM code

always@(posedge clk) begin
	instr <= {addr_iMem[addr+3], addr_iMem[addr+2], addr_iMem[addr+1], addr_iMem[addr]};
end


endmodule

