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


module BirdLogicNet(
    input clk, 
    input [9:0] netH,
    input [9:0] netV,
    input [9:0] netSize,
    input freeBirds,
    input [1:0] Q,
    input [9:0] nextH,
    input [9:0] nextV,
    input showTime,
    
    output caught,
    output [1:0] D
    );
    
    wire caughtNow = ( ( nextH + 10'd15 ) >= netH ) & ( nextH <= ( netH + netSize ) ) & ( ( nextV + 10'd15 ) >= netV ) & ( nextV <= ( netV + netSize ) ) & showTime;
    
    // NEXT STATE
    assign D[1] = (Q[0] & caughtNow) | ( Q[1] & ~( freeBirds ) ); // caught
    assign D[0] = ( Q[0] & ~caughtNow ) | ( Q[1] & ( freeBirds ) ); // free
    
    // OUTPUTS
    assign caught = Q[1];
   
endmodule
