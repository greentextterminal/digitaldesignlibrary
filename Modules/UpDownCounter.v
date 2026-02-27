/*
This counter can be set to count up or count down
If the counter is set to count up then counts from 0 to WIDTH
If the counter is set to count down then counts from WIDTH to 0
When enable is deasserted the counter pauses, else it continues
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

  // async reset clears or resets the load value based on the direction
  always @ (posedge clk) begin
    // control logic if, if else chain (rst, enable, flag logic)
    if ((rst) && (direction)) begin 
      count <= 0; // reset count with 0
      flag  <= 0; // reset flag
    end
    else if ((rst) && (!direction)) begin
      count <= load; // reset count with load
      flag  <= 0;    // reset flag
    end
    else if (!enable) begin
    // hold the count if not enabled
      count <= count;
    end  
    else if ((direction) && (count == load)) begin
      // if max count reached while counting up assert flag and reset count to 0
      count <= 0;
      flag  <= 1;
    end
    else if ((!direction) && (count == 0)) begin
    // if count is 0 assert flag var and reset count to load
      count <= load;
      flag  <= 1;
    end
    // counter else if chain
    else if (direction) begin
      // increment the counter if direction is counting up
      count <= count + 1;
      flag  <= 0;
    end
    else if (!direction) begin
      // decrement the counter if direction is counting down
      count <= count - 1;
      flag  <= 0;
    end
    else begin
      // default
      flag  <= 0;
      count <= 0;
    end 
  end
endmodule
