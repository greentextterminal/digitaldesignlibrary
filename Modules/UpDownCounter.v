/*
This counter can be set to count up or count down
If the counter is set to count up then it counts up from 0 to load
If the counter is set to count down then it counts down from load to 0
The WIDTH parameter is used to set the register width for storing the count
When enable is asserted the counter counts up or down
When enable is deasserted the counter is paused
*/

module UpDownCounter #(
  parameter WIDTH = 8
) 
(
  input  clk,
  input  rst,
  input  enable,
  input  [WIDTH - 1:0] load, 
  input  direction, // 1 up, 0 down
  output reg flag
); 

  // internal reg
  reg [WIDTH - 1:0] count;

  // sync reset clears or resets the load value based on the direction
  always @ (posedge clk) begin
    // default flag value
    flag <= 0;
    // reset block
    if (rst) begin
      if (direction) begin 
        count <= 0; // reset count with 0
      end
      else if (!direction) begin
        count <= load; // reset count with load
      end
    end
    // enabled count block
    else if (enable) begin
      if (direction) begin
        // if max count reached while counting up assert flag and reset count to 0
        if (count == load) begin
          count <= 0;
          flag  <= 1;
        end
        // increment the counter if direction is counting up
        else begin
          count <= count + 1;
        end
      end
      else if (!direction) begin
        // if count is 0 assert flag var and reset count to load
        if (count == 0) begin
          count <= load;
          flag  <= 1;
        end
        // decrement the counter if direction is counting down
        else begin
          count <= count - 1;
        end
      end
    end
    // hold the count if not enabled
    else if (!enable) begin
      count <= count; 
    end 
  end
endmodule
