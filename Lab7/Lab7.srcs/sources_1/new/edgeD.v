`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2019 02:22:28 PM
// Design Name: 
// Module Name: edge
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


 module edgeD(
    input clk,
    input btn,
    
    output o
    );
    
    wire [1:0] temp;
    
    FDRE #(.INIT(1'b0) ) ff1 (.C(clk), .R(1'b0), .CE(1'b1), .D(btn), .Q(temp[0]));
    FDRE #(.INIT(1'b0) ) ff2 (.C(clk), .R(1'b0), .CE(1'b1), .D(temp[0]), .Q(temp[1]));
    
    assign o = ~temp[1] & temp[0];
    
endmodule
