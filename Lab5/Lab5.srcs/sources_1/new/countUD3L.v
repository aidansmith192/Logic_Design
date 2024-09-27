`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2019 03:44:43 PM
// Design Name: 
// Module Name: countUD3L
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


module countUD3L(
    input clk,
    input Up,
    input Dw,
    input LD,
    input [2:0] Din, // only for load enabled
    
    output [2:0] Q,
    output UTC,
    output DTC
    );
    
    wire enable;
    assign enable = Up | Dw | LD; // if all on then load overrides. up/dw cancel out
    // ~enable = ~Up & ~Dw & ~LD;
    
    wire [2:0] D;
    
    FDRE #(.INIT(1'b0) ) ff1 (.C(clk), .R(1'b0), .CE(enable), .D(D[0]), .Q(Q[0]));
    FDRE #(.INIT(1'b0) ) ff2 (.C(clk), .R(1'b0), .CE(enable), .D(D[1]), .Q(Q[1]));
    FDRE #(.INIT(1'b0) ) ff3 (.C(clk), .R(1'b0), .CE(enable), .D(D[2]), .Q(Q[2]));
    
    assign D[0] = (~Q[0] & (Up ^ Dw) & ~LD) | (Din[0] & LD) | (Q[0] & ~enable);
    assign D[1] = ((Q[1] ^ (Up & Q[0])) & ~Dw & ~LD) | ((Q[1] ^ (Dw & ~Q[0])) & ~Up & ~LD) | (Din[1] & LD) | (Q[1] & ~enable);
    assign D[2] = ((Q[2] ^ (Up & Q[1] & Q[0])) & ~Dw & ~LD) | ((Q[2] ^ (Dw & ~Q[1] & ~Q[0])) & ~Up & ~LD) | (Din[2] & LD) | (Q[2] & ~enable);
    
    assign UTC = &Q;
    assign DTC = &(~Q);
    
endmodule
