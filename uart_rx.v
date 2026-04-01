`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.02.2026 13:48:28
// Design Name: 
// Module Name: uart_rx
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


module uart_rx(input clk,en,
               input rx_data,
               input rx_br,
               output reg [7:0] rx_out,
               output reg done,
               output reg busy,
               output reg error );
parameter RESET=0;
parameter START=1;
parameter DATA=2;
parameter PARITY=3;
parameter STOP=4;
parameter READY=5;     

reg [2:0]state;
reg[7:0] sb_reg;
reg[2:0] bit_index;
always @(posedge clk)begin
if(!en)begin
state<= RESET;
end
else if(rx_br) begin
case(state)
RESET: begin
done<=0;
busy<=0;
error<=0;
sb_reg<=0;
bit_index<=0;
state<=START;
end   
START:begin
if(!rx_data)begin
busy<=1;
state<=DATA;
end 
else
state<=START;
end
DATA:begin
sb_reg<={rx_data,sb_reg[7:1]};
bit_index<=bit_index+1;
if(bit_index==7)
state<=PARITY;
else
state<=DATA;
end
PARITY:begin
error<=(^sb_reg!=rx_data);
state<=STOP;
end
STOP:begin
if(rx_data)begin
done<=1;
rx_out<=sb_reg;
state<=READY;
end
else begin
error<=1;
state<=RESET;
end
end
READY:begin
busy<=0;
state<=RESET;
end
endcase
end
end
endmodule
