module tb;  
  reg clk;
  reg rst;
  wire divided_clk;

  initial begin
    // dump waves
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);
    
    // oscillate the clock
	clk = 0;
    forever begin
      #1;
      clk = ~clk;
    end
  end
  
  // hold reset then release
  initial begin
  	rst = 1;
    #3;
    rst = 0;
  end
  
  // specify a duration 
  initial begin
    #40;// wait for 40 time units
    $finish;
  end
  
  // DUT (Set N parameter to anything 1+)
  divide_clock_by_N #(.N(3)) dut (
    .clk(clk),
    .rst(rst),
    .divided_clk(divided_clk)
  );
endmodule
