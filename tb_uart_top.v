`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.02.2026 16:00:09
// Design Name: 
// Module Name: tb_uart_top
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


module top_tb();
reg clk,rst,en,start;
reg[7:0]tx_data;

wire[7:0]rx_data;
wire tx_done,tx_busy;
wire rx_done,rx_busy;
wire  rx_error;
uart_top dut(.clk(clk),
        .rst(rst),
        .en(en),
        .start(start),
        .tx_data(tx_data),
        .rx_data(rx_data),
        .tx_done(tx_done),
        .rx_done(rx_done),
        .tx_busy(tx_busy),
        .rx_busy(rx_busy),
        .rx_error(rx_error));
always #5 clk =~clk;
initial begin
$monitor("TX_DATA:%b||RX_DATA:%b||TX_DONE:%b||RX_DONE:%b||TX_BUSY:%b||RX_BUSY:%b",tx_data,rx_data,tx_done,rx_done,tx_busy,rx_busy) ;       

clk=0;rst=1;en=0;start=0;tx_data=8'd0;
#20 rst =0;en=1;
#20 t_bytes(8'b10110011);
wait (rx_done);
#40;
$finish;
end
task t_bytes(input[7:0]data);
begin
wait(!tx_busy);
tx_data=data;
start=1;
#30 start=0;
end   
endtask     
endmodule