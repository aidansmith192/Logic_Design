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


module NetLogicVert(
    input clk, 
    input go,
    input start,
    input btnU,
    input btnD,
    input [9:0] netSize,
    input [9:0] startV, 
    input win,
    input [3:0] Q,
    input restart,
    
    output [9:0] nextV,
    output [3:0] D
    );
    
    wire [9:0] tempV;
    
    // NEXT STATE
    assign D[3] = ( |Q[2:1] & win ) | ( Q[3] & ~restart ); // freeze in place
    assign D[2] = ( Q[1] & ( tempV == 10'd8 | btnD ) & ~win ) | ( Q[2] & ~( tempV >= ( 10'd471 - netSize) ) & ~win & ~btnU ); // down
    assign D[1] = ( Q[2] & ( ( tempV >= ( 10'd471 - netSize) ) | btnU ) & ~win ) | ( Q[1] & ~( tempV == 10'd8 ) & ~win & ~btnD ) | ( Q[0] & start ); // up
    assign D[0] = ( Q[0] & ~start) | ( Q[3] & restart); // hold, start position
    
    
    // OUTPUTS
    countUD10L H( .clk(clk), .Up(Q[2] & go), .Dw(Q[1] & go), .LD(Q[0]), .Din(startV), .Q(tempV) );
    assign nextV = tempV;
   
endmodule
