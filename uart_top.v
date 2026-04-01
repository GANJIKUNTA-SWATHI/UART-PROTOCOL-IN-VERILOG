`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.02.2026 15:22:26
// Design Name: 
// Module Name: uart_top
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


module uart_top(input clk,
                input rst,
                input en,
                input start,
                input [7:0] tx_data,
                output[7:0] rx_data,
                output tx_done,tx_busy,
                output rx_done,rx_busy,
                output rx_error);
wire tx_out; //connecting output from tx to input of rx
wire tx_br,rx_br;
BAUD_RATE br(.clk(clk),
             .rst(rst),
             .tx_br(tx_br),
             .rx_br(rx_br));
uart_tx tx(.clk(clk),
            .en(en),
            .start(start),
            .tx_br(tx_br),
            .data(tx_data),
            .tx_out(tx_out),
            .done(tx_done),
            .busy(tx_busy));
uart_rx rx(.clk(clk),
           .en(en),
           .rx_br(rx_br),
           .rx_data(tx_out),
           .rx_out(rx_data),
           .done(rx_done),
           .busy(rx_busy),
           .error(rx_error));

endmodule


