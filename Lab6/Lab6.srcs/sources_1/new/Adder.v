`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2019 05:02:49 PM
// Design Name: 
// Module Name: Adder
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


module Adder(
    input a,
    input cin,
    input b,
    
    output o, // carryout
    output s // sum
    );
    
    m4_1e mux4sum( .in({b,~b,~b,b}), .sel({a,cin}), .e(1), .o(s) );
    m4_1e mux4carry( .in({1'b1,b,b,1'b0}), .sel({a,cin}), .e(1), .o(o) );
    
endmodule
