`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2019 03:33:19 PM
// Design Name: 
// Module Name: m4_1e
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


module m4_1e(
    input [3:0] in,
    input [1:0] sel,
    input e,
    
    output o
    );
    
    wire [3:0] temp;
    
    assign temp[0] = in[0] & ~sel[1] & ~sel[0];
    assign temp[1] = in[1] & ~sel[1] & sel[0];
    assign temp[2] = in[2] & sel[1] & ~sel[0];
    assign temp[3] = in[3] & sel[1] & sel[0];
    
    assign o = (|temp) & e;
    
endmodule
