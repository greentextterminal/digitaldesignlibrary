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
parameter  N = 2;

/*
determining the registers needed using $clog2 changes depending on whether N is even or odd 
if N = 5 -> clog(2) = 3 -> [(3-1):0] -> [2:0] -> 3'b101
if N = 8 -> clog(2) = 3 -> [3:0] -> 4'b1000
We can see that for odd N's we need to subtract 1 and for even N's we can use the value computed by $clog2 directly
*/

// determines whether or not a bit adjustment needs to be made
localparam subtractor = (N % 2 == 0) ? 0 : 1;
// count variable to hold up to N
reg [($clog2(N) - subtractor):0] count; 
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
