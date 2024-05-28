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
	wire [31:0] instr_out;
	reg [31:0] from_pc_stim;
	wire [31:0] next_pc_out;
	reg [31:0] pc_in_stim;
	wire [31:0] pc_out_out;
	reg [31:0] command_stim;
	wire [3:0] ctrl_out; 
	reg regwrite_stim;
	reg [4:0] rs1_stim, rs2_stim, rd_stim;
	reg [31:0] wr_data_stim;
	wire [31:0] rd_data1_out, rd_data2_out;
	reg [31:0] data1_stim, data2_stim, imm_stim;
	reg [3:0] ALU_control_stim;
	wire zero_out;
	wire [31:0] ALU_result_out;
	wire [31:0] imm_out;
	
	initial //initialize clock
	begin
		t_clk = 0;
		forever t_clk = #5 ~t_clk; //clock switches value every 5ns
	end;
	
	InstrMem dut_1(.clk(t_clk), .rst_n(t_rst), .addr(addr_stim), .instr(instr_out));
	pc_plus4 dut_2(.from_pc(from_pc_stim), .next_pc(next_pc_out));
	pc dut_3(.clk(t_clk), .rst_n(t_rst), .pc_in(pc_in_stim), .pc_out(pc_out_out));
	decoder dut_4(.command(command_stim), .ALUcontrol_out(ctrl_out));
	RegFile dut_5(.clk(t_clk), .rst_n(t_rst), .RegWrite(regwrite_stim), .rs1(rs1_stim), .rs2(rs2_stim), .rd(rd_stim), .wr_data(wr_data_stim), .rd_data1(rd_data1_out), .rd_data2(rd_data2_out));
	alu dut_6(.data1(data1_stim), .data2(data2_stim), .ALU_control(ALU_control_stim), .imm(imm_stim), .Zero(zero_out), .ALU_result(ALU_result_out));
	ImmGen dut7(.instr(command_stim), .ImmOut(imm_out)); //regwrite and zero are unassigned atm
	
	initial
	begin //regwrite temporarily set to 1
	t_rst = 0; #1 t_rst = 1; #1 
	pc_in_stim = 0; regwrite_stim = 1; #5 from_pc_stim = pc_out_out;  addr_stim = pc_out_out; 
	
	#2 command_stim = instr_out; //instruction fetch
	#2 ALU_control_stim = ctrl_out; rs1_stim = instr_out[19:15]; imm_stim = imm_out; rs2_stim = instr_out[24:20]; rd_stim = instr_out[11:7]; //decode
	data1_stim = rd_data1_out; data2_stim = rd_data2_out;  #2 wr_data_stim = ALU_result_out; //ALU
	#2 pc_in_stim = next_pc_out; #2 from_pc_stim = pc_out_out; addr_stim = pc_out_out; //PC = PC + 4
	
	#2 command_stim = instr_out; //instruction fetch
	#2 ALU_control_stim = ctrl_out; rs1_stim = instr_out[19:15]; imm_stim = imm_out; rs2_stim = instr_out[24:20]; rd_stim = instr_out[11:7];
	data1_stim = rd_data1_out; data2_stim = rd_data2_out;  #2 wr_data_stim = ALU_result_out; 
	#2 pc_in_stim = next_pc_out; #2 from_pc_stim = pc_out_out; addr_stim = pc_out_out; //PC = PC + 4
	
	#2 command_stim = instr_out; //instruction fetch
	#2 ALU_control_stim = ctrl_out; rs1_stim = instr_out[19:15]; imm_stim = imm_out; rs2_stim = instr_out[24:20]; rd_stim = instr_out[11:7];
	data1_stim = rd_data1_out; data2_stim = rd_data2_out;  #2 wr_data_stim = ALU_result_out; 
	#2 pc_in_stim = next_pc_out; #2 from_pc_stim = pc_out_out; addr_stim = pc_out_out; //PC = PC + 4
	
	#2 command_stim = instr_out; //instruction fetch
	#2 ALU_control_stim = ctrl_out; rs1_stim = instr_out[19:15]; imm_stim = imm_out; rs2_stim = instr_out[24:20]; rd_stim = instr_out[11:7];
	data1_stim = rd_data1_out; data2_stim = rd_data2_out;  #2 wr_data_stim = ALU_result_out; 
	#2 pc_in_stim = next_pc_out; #2 from_pc_stim = pc_out_out; addr_stim = pc_out_out; //PC = PC + 4
	
	#15 $stop;	
	end
	// for some reason simulation cannot detect data stims.
	
endmodule
