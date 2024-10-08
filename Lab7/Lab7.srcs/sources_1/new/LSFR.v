`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2019 11:13:11 AM
// Design Name: 
// Module Name: LSFR
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


module LSFR(
    input clk,
    
    output [7:0] rnd
    );
    
    wire start;
    
    assign start = rnd[0] ^ rnd[5] ^ rnd[6] ^ rnd[7];
    
    FDRE #(.INIT(1'b0) ) ff0 (.C(clk), .R(1'b0), .CE(1'b1), .D(start), .Q(rnd[0]));
    FDRE #(.INIT(1'b0) ) ff1 (.C(clk), .R(1'b0), .CE(1'b1), .D(rnd[0]), .Q(rnd[1]));
    FDRE #(.INIT(1'b0) ) ff2 (.C(clk), .R(1'b0), .CE(1'b1), .D(rnd[1]), .Q(rnd[2]));
    FDRE #(.INIT(1'b0) ) ff3 (.C(clk), .R(1'b0), .CE(1'b1), .D(rnd[2]), .Q(rnd[3]));
    FDRE #(.INIT(1'b0) ) ff4 (.C(clk), .R(1'b0), .CE(1'b1), .D(rnd[3]), .Q(rnd[4]));
    FDRE #(.INIT(1'b0) ) ff5 (.C(clk), .R(1'b0), .CE(1'b1), .D(rnd[4]), .Q(rnd[5]));
    FDRE #(.INIT(1'b0) ) ff6 (.C(clk), .R(1'b0), .CE(1'b1), .D(rnd[5]), .Q(rnd[6]));
    FDRE #(.INIT(1'b1) ) ff7 (.C(clk), .R(1'b0), .CE(1'b1), .D(rnd[6]), .Q(rnd[7])); // initially 1
    
endmodule
