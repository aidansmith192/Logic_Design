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


module time_counter(
    input clk,
    input Up,
    input Dw,
    input LD,
    input [15:0] Din, // only for load enabled
    
    output [15:0] Q
    );
    
    wire [3:0] outUTC, outDTC;
    wire [15:0] tempQ;
    
    countUD3L count3_0(.clk(clk), .Up(Up), .Dw(Dw), .LD(LD), .Din(Din[2:0]), .Q(tempQ[2:0]), .UTC(outUTC[0]), .DTC(outDTC[0]));
    countUD5L count5_1(.clk(clk), .Up(outUTC[0]&Up&~LD), .Dw(outDTC[0]&Dw), .LD(LD), .Din(Din[7:3]), .Q(tempQ[7:3]), .UTC(outUTC[1]), .DTC(outDTC[1]));
    countUD5L count5_2(.clk(clk), .Up((&outUTC[1:0])&Up&~LD), .Dw((&outDTC[1:0])&Dw&~LD), .LD(LD), .Din(Din[12:8]), .Q(tempQ[12:8]), .UTC(outUTC[2]), .DTC(outDTC[2]));
    countUD3L count3_3(.clk(clk), .Up((&outUTC[2:0])&Up&~LD), .Dw((&outDTC[2:0])&Dw&~LD), .LD(LD), .Din(Din[15:13]), .Q(tempQ[15:13]), .UTC(outUTC[3]), .DTC(outDTC[3]));
    
    assign Q = tempQ;
    
endmodule
