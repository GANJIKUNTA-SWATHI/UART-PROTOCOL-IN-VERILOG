`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.02.2026 10:07:07
// Design Name: 
// Module Name: BAUD_RATE
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module BAUD_RATE(input clk, rst,
                output reg tx_br,
                output reg rx_br);
parameter CLK_FREQ=100;
parameter BR=96;

parameter TX_MAX_COUNT=CLK_FREQ/BR;    //100MHZ/9600
parameter RX_MAX_COUNT=CLK_FREQ/BR;    //100MHZ/9600


reg[31:0] tx_counter;
reg[31:0] rx_counter;

always @(posedge clk or posedge rst)begin
if(rst) begin
tx_br<=0;
tx_counter<=0;
end
else begin
if(tx_counter==TX_MAX_COUNT) begin
tx_br<=1;
tx_counter<=32'd0;
end
else begin
tx_counter<=tx_counter +1;
tx_br<=0;
end
end
end

always @(posedge clk or posedge rst)begin
if(rst) begin
rx_br<=0;
rx_counter<=0;
end
else begin
if(rx_counter==RX_MAX_COUNT) begin
rx_br<=1;
rx_counter<=32'd0;
end
else begin
rx_counter<=rx_counter +1;
rx_br<=0;
end
end
end

 
endmodule
