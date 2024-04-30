`default_nettype none
`timescale 10ns/1ps

/*
* Top (main) module
*/

module mod_top
(
  input wire logic i_clk_12mhz,
  output logic o_led_T,
  output logic o_led_B,
  output logic o_led_L,
  output logic o_led_R,
  output logic o_led_G,

  /* Logic analyser probe points */
  output logic o_top_10,
  output logic o_top_9,
  output logic o_top_8
);

logic clk_48mhz;
logic clk_48khz;
logic pll_locked;

logic sck;
logic ws;
logic ready;

/* Debug pins */
assign o_top_10 = i_clk_12mhz;
assign o_top_9 = clk_48mhz;
assign o_top_8 = clk_48khz;

/* PLL to generate a 48MHz clock (12MHz in) */
mod_pll u_mod_pll
(
    .i_clk(i_clk_12mhz),
    .o_clk(clk_48mhz),
    .o_locked(pll_locked)    
);

/* 
    Divide down the fsr from the clock: 12000000/48000/2 = 125.
*/
mod_clock_divider #(.DIVIDER(124)) u_mod_ws_divider
(
  .i_enable(pll_locked),
  .i_clk_in(i_clk_12mhz), 
  .o_clk_out(clk_48khz)   
);

/* I2S audio TX peripheral */
// mod_i2s_tx u_mod_i2s_tx
// (    
//     .i_clk(pll_clk),
//     .o_sck(sck),
//     .o_ws(ws),
//     .o_ready(ready)
// );




/* Turn off the red LEDs, otherwise they float (half-on) */
assign o_led_T = 1'b0;
assign o_led_B = 1'b0;
assign o_led_R = 1'b0;
assign o_led_L = 1'b0;


logic [15:0] counter;

/* Clock divider */
always_ff @(posedge clk_48khz)
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
assign o_led_G = counter[15];


endmodule