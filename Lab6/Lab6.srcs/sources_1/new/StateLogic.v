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
    input btnL,
    input btnR,
    input [7:0] Q,
    
    output showTime,
    output SRTime,
    output pointL,
    output pointR,
    output [7:0] D
    );
    
    // NEXT STATE
    assign D[6] = btnL & ~btnR & (Q[5] | Q[6]); // Right First Left Last (RFLL)
    assign D[5] = btnL & btnR & (Q[4] | Q[5] | Q[6]); // Right First Both (RFB)
    assign D[4] = ~btnL & btnR & (Q[0] | Q[4] | Q[5]); // Right First (RF)
    assign D[3] = ~btnL & btnR & (Q[2] | Q[3]); // Left First Right Last (LFRL)
    assign D[2] = btnL & btnR & (Q[1] | Q[2] | Q[3]); // Left First Both (LFB)
    assign D[1] = btnL & ~btnR & (Q[0] | Q[1] | Q[2]); // Left First (LF)
    assign D[0] = ( ~btnL & ~btnR & ( ( |Q[1:0] ) | ( |Q[4:3] ) | Q[6] ) ) | ( btnL & btnR & Q[0] ); // idle
    
    
    // OUTPUTS
    assign showTime = ( |Q[6:1] );
//    assign SRTime = ( btnL & ~btnR & ( Q[0] | Q[2] | Q[5] ) ) | ( btnL & btnR & ( Q[1] | Q[3] | Q[4] | Q[6] ) ) | ( ~btnL & btnR & ( Q[0] | Q[2] | Q[5] ) );
    assign SRTime = Q[0] | ( btnL & ~btnR & ( Q[0] | Q[2] | Q[5] ) ) | ( btnL & btnR & ( Q[1] | Q[3] | Q[4] | Q[6] ) ) | ( ~btnL & btnR & ( Q[0] | Q[2] | Q[5] ) );

    assign pointL = ~btnL & ~btnR & Q[3];
    assign pointR = ~btnL & ~btnR & Q[6];
   
endmodule
