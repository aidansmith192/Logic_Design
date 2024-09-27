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


module BirdLogicHort(
    input clk, 
    input go,
    input start,
    input rand,
    input [9:0] startH, 
    input [2:0] Q,
    input restart,
    
    output [9:0] nextH,
    output [2:0] D
    );
    
    wire [9:0] tempH;
    
    // NEXT STATE
    assign D[2] = ( Q[1] & ( tempH == 10'd8 ) & ~restart) | ( Q[2] & ~( tempH == 10'd616 ) & ~restart) | ( Q[0] & start & rand ); // right
    assign D[1] = ( Q[2] & ( tempH == 10'd616 ) & ~restart) | ( Q[1] & ~( tempH == 10'd8 ) & ~restart ) | ( Q[0] & start & ~rand ); // left
    assign D[0] = ( Q[0] & ~start) | ( |Q[2:1] & restart ); // hold
    
    // OUTPUTS
    countUD10L H( .clk(clk), .Up(Q[2] & go), .Dw(Q[1] & go), .LD(Q[0]), .Din(startH), .Q(tempH) );
    assign nextH = tempH;
   
endmodule
