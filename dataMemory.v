module dataMemory(clock, memWrite, address, data, out);
	input clock, memWrite;
	input[10:0] address;// 1024 + 256 = 1280
	input [31:0] data
	output [31:0] out;

	reg[31:0] word[1280:1024];

	always @(clock)begin
		word[11'd1024] <= 32'd200;
		word[11'd1025] <= 32'd7;
		word[11'd1026] <= 32'd200;
		word[11'd1027] <= 32'd9;	
		// word[8'd104] <= 8'd3;
		// word[8'd105] <= 8'd4;
		// word[8'd106] <= 8'd5;
		// word[8'd107] <= 8'd6;
		// word[8'd108] <= 8'd7;
		// word[8'd109] <= 8'd8;
		// word[8'd110] <= 8'd9;
		// word[8'd111] <= 8'd90;
		// word[8'd112] <= 8'd10;
		// word[8'd113] <= 8'd12;
		// word[8'd114] <= 8'd13;
		// word[8'd115] <= 8'd14;
		// word[8'd116] <= 8'd15;
		// word[8'd117] <= 8'd120;
		// word[8'd118] <= 8'd1;
		// word[8'd119] <= 8'd2;
		// word[8'd120] <= 8'd3;
		// word[8'd121] <= 8'd4;
	end
	
	always @(posedge clock) begin
		if (memWrite)begin
			word[address] <= data;
		end
	end
	assign out = word[(address >> 2) << 2];
endmodule 