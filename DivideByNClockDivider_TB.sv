module tb;  
  reg clk;
  wire divided_clk;

  initial begin
    // dump waves
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);
    
    // oscillate the clock
    clk = 1;
    forever begin
      #1;
      clk = ~clk;
    end
    
  end
  
  // specify a duration 
  initial begin
    #20;// wait for 20 time units
    $finish;
  end
  
  // DUT
  divide_clock_by_N dut (
    .clk(clk),
    .divided_clk(divided_clk)
  );
endmodule
