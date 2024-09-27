`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2019 04:33:07 PM
// Design Name: 
// Module Name: StateMachine
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


module StateMachine(
    input clk,
    input btnC,
    input btnU,
    input btnD,
    input timeUp,
    input lastLED,
    
    output showTime,
    output loadTime,
    output runTime,
    output incU,
    output incD,
    output showScore,
    output flashU,
    output flashD
    );
    
    wire [7:0] Q;
    wire [7:0] D;
    
    StateLogic  logic( .btnC(btnC), .btnU(btnU), .btnD(btnD), .timeUp(timeUp), .lastLED(lastLED), .Q(Q), .showTime(showTime), .loadTime(loadTime), .runTime(runTime), .incU(incU), .incD(incD), .showScore(showScore), .flashU(flashU), .flashD(flashD), .D(D) );
    
    FDRE #(.INIT(1'b1)) Q0_FF (.C(clk), .CE(1'b1), .D(D[0]), .Q(Q[0])); // greset gives 0000 0001
    FDRE #(.INIT(1'b0)) Q1to7_FF[7:1] (.C({7{clk}}), .CE({7{1'b1}}), .D(D[7:1]), .Q(Q[7:1]));
    
endmodule

