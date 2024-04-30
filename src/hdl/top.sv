`default_nettype none
`timescale 10ns/1ps

/*
* Top (main) module
*/

module mod_top
(
  input wire logic i_clk,
  output logic o_led_T,
  output logic o_led_B,
  output logic o_led_L,
  output logic o_led_R,
  output logic o_led_G
);

logic [31:0] counter;
logic pll_clk;
logic pll_locked;

/* PLL to generate a 100 MHz (approx) clock from the 12MHz global clock */
mod_pll u_mod_pll
(
    .i_clk(i_clk),
    .o_clk(pll_clk),
    .o_locked(pll_locked)
);

/* Turn off the red LEDs, otherwise they float (half-on) */
assign o_led_T = 1'b0;
assign o_led_B = 1'b0;
assign o_led_R = 1'b0;
assign o_led_L = 1'b0;

/* Clock divider */
always_ff @(posedge pll_clk)
begin
  if(pll_locked)
  begin
    counter <= counter + 1;
  end
  else 
  begin
    counter <= 0;
  end
end

/* The ubiquitous Mr Blinky once again graces us with its presence */
assign o_led_G = counter[26];


endmodule