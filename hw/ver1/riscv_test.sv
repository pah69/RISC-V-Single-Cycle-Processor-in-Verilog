module riscv_test(
	input clk, rst_n,
	input [31:0] data_in,
	output [31:0] data_out
);
	reg [31:0] pc;
	reg [31:0][31:0] x;
	integer i;
	
	initial begin
		for (i = 0; i < 32; i = i + 1)
		begin
			x[i][31:0] = 32'h0; 
		end
		x[2][31:0] = 32'h7FFFFFF0; //stack pointer
	end
	
	always @(data_in)
	begin
		case (data_in[6:2]) // for opcode 0110111, 0010111, 1101111 -> J-type or U-type -> no func3
			5'b00100: // is type that has func3 component -> check func3
			begin
				if (data_in[14:12] == 3'b000)
				begin
					x[data_in[11:7]][31:0] <= x[data_in[19:15]][31:0] + {20'b00000000000000000000, data_in[31:20]};
				end
			end
		endcase			
	end
	
endmodule