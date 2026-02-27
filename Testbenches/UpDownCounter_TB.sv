/*
UpDownCounter Testbench
*/

module tb;
  // set this param in the tb to drive the DUT and the bit widths
  localparam WIDTH = 8;
  
  reg clk, rst, enable, direction;
  reg [WIDTH-1:0] load;
  wire flag;

  // initialize DUT and connect IO
  UpDownCounter #(.WIDTH(WIDTH)) DUT (
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .load(load),
    .direction(direction),
    .flag(flag)
  );

  // initialize inputs
  initial clk = 0;
  initial rst = 0;
  initial enable = 0;
  initial direction = 0;

  // creating the clock signal
  initial begin
    // dump waves
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);
    
    // oscillating the clock
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

  // load and count up
  initial begin
    #3;
      
  end
  
  // specify a duration 
  initial begin
    #100; // wait for 50 time units
    $finish;
  end
  
endmodule
