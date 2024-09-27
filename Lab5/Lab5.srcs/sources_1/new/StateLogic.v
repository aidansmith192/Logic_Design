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


module StateLogic(
    input btnC,
    input btnU,
    input btnD,
    input timeUp,
    input lastLED,
    input [7:0] Q,
    
    output showTime,
    output loadTime,
    output runTime,
    output incU,
    output incD,
    output showScore,
    output flashU,
    output flashD,
    input [7:0] D
    );
    
    // NEXT STATE
    assign D[7] = (Q[4] & timeUp) | (Q[3] & btnU & ~timeUp) | (Q[7] & ~btnC); // Uwin
    assign D[6] = (Q[3] & timeUp) | (Q[4] & btnD & ~timeUp) | (Q[6] & ~btnC); // Dwin
    assign D[5] = (btnD & btnU & Q[2] & ~timeUp) | (Q[5] & ~btnC); // both
    assign D[4] = (Q[2] & btnU & ~btnD & ~timeUp) | (Q[4] & ~timeUp & ~btnD); // Ufirst
    assign D[3] = (Q[2] & btnD & ~btnU & ~timeUp) | (Q[3] & ~timeUp & ~btnU); // Dfirst
    assign D[2] = (Q[1] & lastLED) | (Q[2] & ~timeUp & ~btnU & ~btnD); // Go
    assign D[1] = (btnC & (Q[0] | Q[5] | Q[6] | Q[7])) | (Q[1] & ~lastLED); // ready
    assign D[0] = (Q[0] & ~btnC) | (Q[2] & timeUp); // before
    
    
    // OUTPUTS
    assign showTime = Q[1];
    assign loadTime = btnC & (Q[0] | Q[5] | Q[6] | Q[7]);
    assign runTime = |Q[4:2];
    assign incU = (Q[4] & timeUp) | (Q[3] & btnU & ~timeUp) | (btnD & btnU & Q[2] & ~timeUp);
    assign incD = (Q[3] & timeUp) | (Q[4] & btnD & ~timeUp) | (btnD & btnU & Q[2] & ~timeUp);
    assign showScore = Q[0] | Q[5] | Q[6] | Q[7];
    assign flashU = (Q[7] | Q[5]);
    assign flashD = (Q[6] | Q[5]);
   
endmodule
