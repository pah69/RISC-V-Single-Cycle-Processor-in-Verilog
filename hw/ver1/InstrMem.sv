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

`timescale 1ns/1ps

module InstrMem_test();
	reg t_clk, t_rst;
	reg [31:0] addr_stim;
	reg [31:0] from_pc_stim;
	reg [31:0] pc_in_stim;
	wire [31:0] instr_out;
	wire [31:0] next_pc_out;
	wire [31:0] pc_out_out;
	
	initial //initialize clock
	begin
		t_clk = 0;
		forever t_clk = #5 ~t_clk; //clock switches value every 5ns
	end;
	
	InstrMem dut_1(.clk(t_clk), .rst_n(t_rst), .addr(addr_stim), .instr(instr_out));
	pc_plus4 dut_2(.from_pc(from_pc_stim), .next_pc(next_pc_out));
	pc dut_3(.clk(t_clk), .rst_n(t_rst), .pc_in(pc_in_stim), .pc_out(pc_out_out));
	
	initial
	begin
	pc_in_stim = 0; #7 from_pc_stim = pc_out_out;  addr_stim = pc_out_out;
	#8 pc_in_stim = next_pc_out; #2 from_pc_stim = pc_out_out; addr_stim = pc_out_out;
	#8 pc_in_stim = next_pc_out; #2 from_pc_stim = pc_out_out; addr_stim = pc_out_out;
	#8 pc_in_stim = next_pc_out; #2 from_pc_stim = pc_out_out; addr_stim = pc_out_out;
	#15 $stop;
	end
	
	
endmodule
