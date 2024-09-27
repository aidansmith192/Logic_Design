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


module GameLogic(
    input clk, 
    input btnC,
    input [3:0] Q,
    input [7:0] caught,
    input timeUp,
    
    output win, 
    output start,
    output showTime, 
    output loadTime,
    output startTime, 
    output freeBirds, 
    output restart,
    output runTime,
    output [3:0] D
    );
    
    wire firstCaught = |caught;
    wire allCaught = &caught;
        
    // NEXT STATE
    assign D[3] = ( Q[2] & allCaught ) | ( Q[3] & ~btnC ); // win
    assign D[2] = ( Q[1] & firstCaught ) | ( Q[2] & ~timeUp & ~allCaught ); // first
    assign D[1] = ( Q[0] & btnC ) | ( Q[1] & ~firstCaught ) | ( Q[2] & timeUp ); // start
    assign D[0] = ( Q[0] & ~btnC ) | ( Q[3] & btnC ); // idle
    
    // OUTPUTS
    assign win = ( Q[2] & allCaught ); // doubles as our output to stop time, freezes net
    assign showTime = |Q[3:1]; // shows time on disp
    assign runTime = Q[2]; // count down
    assign loadTime = ( Q[1] & firstCaught ); // reads in the time from switches
    assign start = ( Q[0] & btnC ); // everything starts moving
    assign freeBirds = ( Q[2] & timeUp ) | ( Q[3] & btnC ); // when birds must be uncaught, doubles as restartTime
    assign restart = ( Q[3] & btnC ); // moves everything back to start and freezes
   
endmodule
