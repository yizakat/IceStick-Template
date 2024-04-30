`default_nettype none
`timescale 10ns/1ps

/* 
 * PLL instance
 * Input frequency:    12MHz
 * Output frequency:   48MHz
 *
 * The IceStick clock is on Pin-21 IOBlock 3 (Left) so we are not using a dedicated clock pad which
 * are only located in the top and bottom blocks. We use the SB_PLL40_CORE primitive rather than the SB_PLL40_PAD.
 */

module mod_pll(
	input  i_clk,
	output o_clk,
	output o_locked
	);

SB_PLL40_CORE #(
		.FEEDBACK_PATH("SIMPLE"),
		.DIVR(4'b0000),		
		.DIVF(7'b0111111),	
		.DIVQ(3'b100),		
		.FILTER_RANGE(3'b001)	
) u_pll (
		.LOCK(o_locked),
		.RESETB(1'b1),
		.BYPASS(1'b0),
		.REFERENCECLK(i_clk),
		.PLLOUTCORE(o_clk),
		.EXTFEEDBACK(1'b0),
		.DYNAMICDELAY(8'b0),
		.LATCHINPUTVALUE(1'b0),
		.SDI(1'b0),
		.SCLK(1'b0)
		);

endmodule
