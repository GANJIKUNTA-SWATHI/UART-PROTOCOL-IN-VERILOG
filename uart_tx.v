`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.02.2026 11:55:07
// Design Name: 
// Module Name: uart_tx
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


module uart_tx(input clk,
                input en,
                input start,
                input tx_br,
                input[7:0] data,
                output reg done,
                output reg busy,
                output reg tx_out);
parameter RESET=0;
parameter IDLE=1;   
parameter START=2;
parameter DATA=3;
parameter PARITY=4;
parameter STOP=5; 
//INTERNAL REG
reg [7:0] hs_reg;//hold and shift reg
reg [2:0]state;//fsm current state
reg parity;
reg [2:0] bit_index;//to count the data bits
always@(posedge clk) begin
if(!en) begin
state<=RESET;
end
else if (tx_br)begin
case(state)
RESET:begin
busy<=0;
done<=0;
bit_index<=0;
tx_out<=1;
state<=IDLE;
end
IDLE:begin
if(start)begin
hs_reg<=data;
parity<=^data;
state<=START;
end
else
state<=IDLE;
end
START:begin
tx_out<=0;
busy<=1;
done<=0;
state<=DATA;
end
DATA:begin
tx_out<=hs_reg[0];
hs_reg<={1'b0,hs_reg[7:1]};
bit_index<=bit_index+1;
if(bit_index==7)
state<=PARITY;
else
state<=DATA;
end
PARITY:begin
tx_out<=PARITY;
state<=STOP;
end
STOP:begin
tx_out<=1;
busy<= 0;
done<=1;
if(start)
state<=IDLE;
else
state<=RESET;
end
endcase
end
end
endmodule