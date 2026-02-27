/*
UpDownCounter Testbench
*/

module tb;
  // set this param in the tb to drive the DUT and the bit widths
  localparam WIDTH = 3;
  
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

  // stimulus
  initial begin
    // initialize inputs
    clk       = 0;
    rst       = 0;
    enable    = 0;
    direction = 0;

    // load and count up
    rst = 1;
    direction = 1;
    enable = 1;
    #5;
    rst = 0;

    // specify a duration 
    #100; // wait for 100 time units
    $finish;
  end
  
endmodule
