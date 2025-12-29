/*
UpDownCounter Testbench
*/

module UpDownCounter_TB_top;

  reg clk, rst, enable, direction, flag;
  reg [WIDTH-1:0] load;

  // initialize inputs
  initial clk = 0;
  initial rst = 0;
  initial enable = 0;
  initial direction = 0;
  initial flag = 0;

  // clock signal
  always #10 clk = ~clk;

  UpDownCounter DUT #(
    .WIDTH(4)
  )
  (
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .load(load),
    .direction(direction),
    .flag(flag)
  )
  
endmodule
