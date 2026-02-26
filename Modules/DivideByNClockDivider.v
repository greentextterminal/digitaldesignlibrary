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
  input	 rst,
  output divided_clk
);
parameter N = 2;
         
// count variable to hold up to N
reg [($clog2(N)-1):0] count; 
// level flag to indicate whether the divided clock is high or low
reg div_clk; // 1 = high, 0 = low

always @ (posedge clk) begin
  // synchronous reset block
  if (rst) begin
    count     <= 0;
    div_clk   <= 1;
  end
  // counter rollover
  else if (count == N) begin
    count   <= 1; // reset count to 1
    div_clk <= !div_clk;
  end
  else begin
    count   <= count + 1; // increment the count
    div_clk <= div_clk;
  end
end

// assign the divided clock to the output
assign divided_clk = div_clk;
endmodule
