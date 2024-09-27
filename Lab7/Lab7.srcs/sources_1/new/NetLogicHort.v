`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2019 04:57:33 PM
// Design Name: 
// Module Name: StateLogic
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


module NetLogicHort(
    input clk, 
    input go,
    input start,
    input win,
    input btnL,
    input btnR,
    input [9:0] netSize,
    input [9:0] startH, 
    input [3:0] Q,
    input restart,
    
    output [9:0] nextH,
    output [3:0] D
    );
    
    wire [9:0] tempH;
    
    // NEXT STATE
    assign D[3] = ( |Q[2:1] & win ) | ( Q[3] & ~restart ); // freeze in place
    assign D[2] = ( Q[1] & ( tempH == 10'd8 | btnR ) & ~win) | ( Q[2] & ~( tempH >= ( 10'd631 - netSize) ) & ~win & ~btnL ); // right
    assign D[1] = ( Q[2] & ( ( tempH >= ( 10'd631 - netSize) ) | btnL ) & ~win) | ( Q[1] & ~( tempH == 10'd8 ) & ~win & ~btnR ) | ( Q[0] & start ); // left
    assign D[0] = ( Q[0] & ~start) | ( Q[3] & restart ); // hold
    
    
    // OUTPUTS
    countUD10L H( .clk(clk), .Up(Q[2] & go), .Dw(Q[1] & go), .LD(Q[0]), .Din(startH), .Q(tempH) );
    assign nextH = tempH;
   
endmodule
