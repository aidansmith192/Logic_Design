`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2019 03:45:06 PM
// Design Name: 
// Module Name: countUD5L
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


module counter4L(
    input clk,
    input CE,
    
    output [3:0] Q
    );
    
    wire [3:0] D;
    
    FDRE #(.INIT(1'b0) ) ff0 (.C(clk), .R(1'b0), .CE(CE), .D(D[0]), .Q(Q[0]));
    FDRE #(.INIT(1'b0) ) ff1 (.C(clk), .R(1'b0), .CE(CE), .D(D[1]), .Q(Q[1]));
    FDRE #(.INIT(1'b0) ) ff2 (.C(clk), .R(1'b0), .CE(CE), .D(D[2]), .Q(Q[2]));
    FDRE #(.INIT(1'b0) ) ff3 (.C(clk), .R(1'b0), .CE(CE), .D(D[3]), .Q(Q[3]));
    
    assign D[0] = (Q[0] ^ CE);
    assign D[1] = ((Q[1] ^ (CE & Q[0]))) | (Q[1] & ~CE);
    assign D[2] = ((Q[2] ^ (CE & Q[1] & Q[0]))) | (Q[2] & ~CE);
    assign D[3] = ((Q[3] ^ (CE & Q[2] & Q[1] & Q[0]))) | (Q[3] & ~CE);
    
endmodule
