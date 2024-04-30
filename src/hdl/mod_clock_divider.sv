`default_nettype none
`timescale 10ns/1ps

/*
* Divides down the 100MHz clock to around 48Khz  
*/

module mod_clock_divider 
#
(    
    DIVIDER = 1         /* By default, does nothing */
)
(
    input wire logic i_clk_in,
    input wire logic i_enable,
    output logic  o_clk_out
);


reg [$clog2(DIVIDER)-1:0] counter = '0;  

always @(posedge i_clk_in) 
begin    
    if (counter == DIVIDER) 
    begin 
        counter <= '0;
        o_clk_out <= ~o_clk_out; 
    end 
    else 
    begin
        counter <= counter + 1;
    end
end

endmodule
