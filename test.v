module test();
// 	reg clk = 0;
// 	wire [4:0] pcOut, pcOut2, out;
// 	reg [4:0] pcIn, pcIn2;
// 	wire rst;
// 	assign  rst = 0;
// 	initial repeat (10) #40 clk = ~clk;
// 	initial begin
// 		#30
// 		pcIn = 5'd5;
// 		#50
// 		pcIn = 5'd7;
// 		#100
// 		pcIn2 = 5'd10;
// 	end
// register #(.size(5)) pc(
// 		.clock(clk),
// 		.reset(rst),
// 		.regIn(pcIn),
// 		.regOut(pcOut)
// 	);
	
// register #(.size(5)) pc2(
// 		.clock(clk),
// 		.reset(rst),
// 		.regIn(pcOut),
// 		.regOut(pcOut2)
// 	);

// assign  out = pcOut + pcOut2;
	
	reg a, b;
	wire out;
	reg clk = 1;
	OR x(a, b, out);
	initial repeat (10) #40 clk = ~clk;
	initial begin
		#30
		a = 1;
		b = 0;
		#10
		a = 0;
		#10 
		b = 1;
		#10
		a  = 1;
	end

endmodule