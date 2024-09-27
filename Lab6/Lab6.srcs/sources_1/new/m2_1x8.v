`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2019 03:33:55 PM
// Design Name: 
// Module Name: m2_1x8
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


module m2_1x8(
    input [7:0] in0, // normal, sel = 0
    input [7:0] in1, // complement, sel = 1
    input sel,
    
    output [7:0] o
    );
    
    wire [7:0] a;
    
    assign a = {8{sel}};
    
    assign o = (in0 & ~a) | (in1 & a);
    
endmodule
