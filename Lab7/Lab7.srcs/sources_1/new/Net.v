`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2019 04:25:41 PM
// Design Name: 
// Module Name: Bird
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


module Net(
    input clk, 
    input go,
    input start,
    input btnL,
    input btnR,
    input btnU,
    input btnD,
    input [9:0] netSize,
    input [9:0] startH, 
    input [9:0] startV, 
    input win,
    input restart,
    input loadTime,
     
    output [9:0] nextH, 
    output [9:0] nextV
    );
    
    wire [3:0] A, B; // current states of H/V
    wire [3:0] X, Y; // next states of H/V
    
    NetLogicHort Hort( .clk(clk), .go(go), .netSize(netSize), .restart(restart), .btnL(btnL), .btnR(btnR), .start(start), .win(win), .Q(A), .startH(startH), .nextH(nextH), .D(X) );
    NetLogicVert Vert( .clk(clk), .go(go), .netSize(netSize), .restart(restart), .btnU(btnU), .btnD(btnD), .Q(B), .start(start), .win(win), .startV(startV), .nextV(nextV), .D(Y) );
    
    FDRE #(.INIT(1'b1)) X0_FF (.C(clk), .CE(1'b1), .D(X[0]), .Q(A[0])); // greset gives 001 (start in hold state)
    FDRE #(.INIT(1'b0)) X1to3_FF[3:1] (.C({3{clk}}), .CE({3{1'b1}}), .D(X[3:1]), .Q(A[3:1]));
    
    FDRE #(.INIT(1'b1)) Y0_FF (.C(clk), .CE(1'b1), .D(Y[0]), .Q(B[0])); // greset gives 001 (start in hold state)
    FDRE #(.INIT(1'b0)) Y1to3_FF[3:1] (.C({3{clk}}), .CE({3{1'b1}}), .D(Y[3:1]), .Q(B[3:1]));
    
endmodule
