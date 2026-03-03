/*
UpDownCounter Testbench
*/

// timescale <time_unit> / <time_precision>
`timescale 1ns/1ns

module tb;
  // set this param in the tb to drive the DUT and the bit widths
  localparam WIDTH = 4;
  
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

  // ----Defining the tasks----
  // Creating a DUT reset for up counting
  task up_reset(input integer num_clocks);
    begin
      rst = 1;
      enable = 0;
      direction = 1;
      repeat (num_clocks) @ (posedge clk);
      rst = 0;
    end

  // Creating a DUT reset for down counting
  task down_reset(input integer num_clocks);
    begin
      rst = 1;
      enable = 0;
      direction = 0;
      repeat (num_clocks) @ (posedge clk);
      rst = 0;
    end 
    
  // Creating an up count task
  task up_count(input [WIDTH-1:0] load, 
                input integer num_clocks);
    begin
      enable = 1;
      load = load;
      direction = 1;
      repeat (num_clocks) @ (posedge clk);
      enable = 0;
    end
  
  // Creating a down count task
  task down_count(input [WIDTH-1:0] load, 
                  input integer num_clocks);
    begin
      enable = 1;
      load = load;
      direction = 0;
      repeat (num_clocks) @ (posedge clk);
      enable = 0;
    end
    
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

  // driving stimulus
  initial begin
    // initialize inputs
    clk       = 0;
    rst       = 0;
    enable    = 0;
    direction = 0;
    repeat (3) @ (posedge clk);

    up_reset(2);
    up_count(4'd5, 20);

    down_reset(3);
    down_count(4'd6, 30);

    // specify a duration 
    #100; // wait for 100 time units
    $finish;
  end
  
endmodule
