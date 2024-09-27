`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2019 03:33:43 PM
// Design Name: 
// Module Name: m8_1e
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


module m8_1e(
    input [7:0] in,
    input [2:0] sel,
    input e, // enable
    
    output o
    );
    
    wire [7:0] temp;
    
    assign temp[0] = in[0] & ~sel[2] & ~sel[1] & ~sel[0]; // 000
    assign temp[1] = in[1] & ~sel[2] & ~sel[1] & sel[0];  // 001
    assign temp[2] = in[2] & ~sel[2] & sel[1] & ~sel[0];  // 010
    assign temp[3] = in[3] & ~sel[2] & sel[1] & sel[0];   // 011
    assign temp[4] = in[4] & sel[2] & ~sel[1] & ~sel[0];  // 100
    assign temp[5] = in[5] & sel[2] & ~sel[1] & sel[0];   // 101
    assign temp[6] = in[6] & sel[2] & sel[1] & ~sel[0];   // 110
    assign temp[7] = in[7] & sel[2] & sel[1] & sel[0];    // 111
    
    assign o = (|temp) & e;
    
endmodule
