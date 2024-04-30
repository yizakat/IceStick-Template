`default_nettype none
`timescale 10ns/1ps

/*
* I2S transmitter
*/

module mod_i2s_tx
(
    input wire logic i_clk,    
    output logic o_sck,
    output logic o_ws,
    output logic o_ready
);

/* signals */
logic [7:0] clock_div = '0;
logic sck = 1'b0;
logic ws = 1'b0;
logic ready = 1'b0;
logic [5:0] bit_count = '0;

/* Sequential state */
always_ff @(posedge i_clk)
begin
    clock_div <= clock_div + 1;

    if(clock_div == 15)
    begin
        sck <= ~sck;
        
        if(sck)
        begin
            ws <= bit_count[5];    
            bit_count <= bit_count + 1;
            ready <= bit_count== 0;
        end

      clock_div <= 1'b0;
    end    
end

/* Outputs */
assign o_sck = sck;
assign o_ws = ws;
assign o_ready = ready;

endmodule