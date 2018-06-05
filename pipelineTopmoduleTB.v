module AAAAAAAAAATB();

  reg clk = 0;
  reg init = 0;
  reg rst = 1;
  
  initial repeat (15) #3 init = ~init;
  initial repeat (300) #70 clk = ~clk;

  initial begin
    #100
    rst = 0;
  end

	pipeline p(clk, rst, init);
	
endmodule

