module register  #(parameter integer size = 32)(clock, reset, regIn, regOut);
    input clock , reset;
    input [size - 1:0] regIn;
    output reg [size - 1: 0] regOut;
    
    always @(posedge clock) begin
      if (reset) regOut <= 0;
      else regOut <= regIn;
    end
endmodule