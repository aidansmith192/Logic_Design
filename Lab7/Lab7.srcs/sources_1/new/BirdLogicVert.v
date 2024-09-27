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


module BirdLogicVert(
    input clk, 
    input go,
    input rand,
    input start,
    input [9:0] startV, 
    input restart,
    input [2:0] Q,
    
    output [9:0] nextV,
    output [2:0] D
    );
    
    wire [9:0] tempV;
    
    // NEXT STATE
    assign D[2] = ( Q[1] & ( tempV == 10'd8 ) & ~restart) | ( Q[2] & ~( tempV == 10'd456) & ~restart) | ( Q[0] & start & rand); // down
    assign D[1] = ( Q[2] & ( tempV == 10'd456 ) & ~restart ) | ( Q[1] & ~( tempV == 10'd8 ) & ~restart ) | ( Q[0] & start & ~rand ); // up
    assign D[0] = ( Q[0] & ~start) | ( |Q[2:1] & restart); // hold
    
    // OUTPUTS
    countUD10L H( .clk(clk), .Up(Q[2] & go), .Dw(Q[1] & go), .LD(Q[0]), .Din(startV), .Q(tempV) );
    assign nextV = tempV;
   
endmodule
