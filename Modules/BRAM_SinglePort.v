/*
BRAM (Block RAM)
BRAM is used for storing or buffering large amounts of data.
FPGAs contain designated memory blocks within the FPGA fabric, but outside of the logic blocks.
Unlike distributed RAM, which is made up of LUTs chained together (as well as other resources) and is asynchronous,
BRAM is a clocked memory construct and does not support reset. 
Including a reset may cause synthesis tools to infer LUTs and registers (distributed RAM)

                <--WIDTH-->
                ____________  _
data_in  --/--> |          |   |
w_addr   --/--> |  BRAM    |   |
r_addr   --/--> | X Width  |  DEPTH
w_en     -----> | Z Depth  |   |
data_out <--/-- |__________|  _|

*/

module BRAM #(
  parameter WIDTH, // data width
  parameter DEPTH  // data depth (number of entries)
)(
  input  clk,
  input  write_enable,
  input  [WIDTH-1:0] write_address,
  input  [WIDTH-1:0] read_address,
  input  [WIDTH-1:0] data_in,
  output [WIDTH-1:0] data_out
);
  // creating the memory construct
  reg [WIDTH-1:0] mem [DEPTH-1:0];
  reg [WIDTH-1:0] data;

  always @ (posedge clk) begin
    // writing data to the memory
    if (write_enable) begin
      mem[write_address] <= data_in;
    end
    // reading from the memory
    data <= mem[read_address];
  end

  // assigning the data read to the output
  assign data_out = data;

endmodule
