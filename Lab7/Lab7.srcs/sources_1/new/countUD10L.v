`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2019 03:05:17 PM
// Design Name: 
// Module Name: countUD16L
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


module countUD10L(
    input clk,
    input Up,
    input Dw,
    input LD,
    input [9:0] Din, // only for load enabled
    
    output [9:0] Q
    );
    
    wire [1:0] outUTC, outDTC;
    wire [9:0] tempQ;
    
    countUD5L count5_1(.clk(clk), .Up(Up), .Dw(Dw), .LD(LD), .Din(Din[4:0]), .Q(tempQ[4:0]), .UTC(outUTC[0]), .DTC(outDTC[0]));
    countUD5L count5_2(.clk(clk), .Up(outUTC[0]&Up&~LD), .Dw(outDTC[0]&Dw), .LD(LD), .Din(Din[9:5]), .Q(tempQ[9:5]), .UTC(outUTC[1]), .DTC(outDTC[1]));
        
    assign Q = tempQ;
    
endmodule
