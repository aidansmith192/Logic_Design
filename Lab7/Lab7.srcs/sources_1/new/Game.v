`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2019 04:25:41 PM
// Design Name: 
// Module Name: Bird
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


module Game(
    input clk, 
    input btnC,
    input [7:0] caught,
    input timeUp,
    
    output win, 
    output start,
    output showTime, 
    output loadTime,
    output startTime, 
    output freeBirds, 
    output restart,
    output runTime
    );
    
    wire [3:0] Q, D; // current/next state of game logic

    GameLogic logic( .clk(clk), .btnC(btnC), .caught(caught), .win(win), .Q(Q), .timeUp(timeUp), .showTime(showTime), .runTime(runTime), .start(start), .loadTime(loadTime), .restart(restart), .startTime(startTime), .freeBirds(freeBirds), .D(D) );
    
    FDRE #(.INIT(1'b1)) X0_FF (.C(clk), .CE(1'b1), .D(D[0]), .Q(Q[0])); // greset gives 0001 (start in idle state)
    FDRE #(.INIT(1'b0)) X1to3_FF[3:1] (.C({3{clk}}), .CE({3{1'b1}}), .D(D[3:1]), .Q(Q[3:1]));
    
endmodule
