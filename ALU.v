module ALU(inputA, inputB, carryIn, operation, result, carryOut, zero, shiftCount);
	input [7:0] inputA, inputB;
	input carryIn;
	input [3:0] operation;
	output reg [7:0] result;
	output reg carryOut, zero;
	input [2:0] shiftCount;

	integer i;
	always @(*) begin
		result = 8'b0;	
		case(operation)
			4'b1000: {carryOut, result} = inputA + inputB;
			4'b1001: {carryOut, result} = inputA + inputB + carryIn;
			4'b1010: {carryOut, result} = inputA - inputB;
			4'b1011: {carryOut, result} = inputA - inputB - carryIn;
			4'b1100: result = inputB & inputA;
			4'b1101: result = inputB | inputA;
			4'b1110: result = inputB ^ inputA;
			4'b1111: result = inputB &^ inputA;
			4'b0000: {carryOut ,result} <= (result << shiftCount);
			4'b0001: {result, carryOut} <= (result >> shiftCount);
			4'b0010: 
					for ( i = 0; i < shiftCount; i = i + 1) begin
						result = {result[6:0], result[7]};
					end
			4'b0011:
					for ( i = 0; i < shiftCount; i = i + 1) begin
						result = {result[0], result[7:1]};
					end
			default: result = result;
		endcase
		zero = ~(|result);
	end

endmodule