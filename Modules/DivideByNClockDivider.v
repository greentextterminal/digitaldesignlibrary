/*
This module divides an input clock by N.
Example if N=2:
Dividing a clock frequency by 2 is multiplying the period 2.
Therefore in one clock period of the divided by 2 clock you can find 2 positive edges of the input clock
         ___   ___   ___   ___
clk    __|  |__|  |__|  |__|  |__
         ______      ______
divclk __|     |_____|     |_____

         ^     ^
posedge  1     2
count
*/

module divide_clock_by_N (
  input  clk,
  output divided_clk
);
parameter N = 2;
         
// count variable to hold up to N (
reg [($clog2(N)-1):0] count = 1; 
// reg var for procedural assignment (initialize the output to 1)
reg div_clk = 1;
// direction flag to count up or down (initialize to 1 to count up)
reg direction = 1; // 1 = up, 0 = down

// clocked direction toggle block
always @ (posedge clk) begin
  if (count == N) begin
    direction <= 0; // N reached, count down
  end
  else if (count == 0) begin
    direction <= 1; // 0 reached, count up
  end
end

// count direction logic
always @ (posedge clk) begin
  if (direction) begin
    count   <= count + 1;
    div_clk <= 1;
  end
  else if (!direction) begin
    count   <= count - 1;
    div_clk <= 0;
  end
end

// assign the divided clock to the output
assign divided_clk = div_clk;
endmodule
