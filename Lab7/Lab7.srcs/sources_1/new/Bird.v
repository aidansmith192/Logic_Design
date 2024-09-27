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


module Bird(
    input clk, 
    input go,
    input [1:0] rand,
    input start,
    input [9:0] startH, 
    input [9:0] startV, 
    input [9:0] netH, // net location
    input [9:0] netV,
    input [9:0] netSize, // net size
    input restart,
    input freeBirds,
    input showTime,
 
    output caught, // track if bird caught, if so add blue to disp to get purp
    output [9:0] nextH, 
    output [9:0] nextV
    );
    
    wire [2:0] A, B; // current states of H/V
    wire [2:0] X, Y; // next states of H/V
    wire [1:0] C; // current states of netted
    wire [1:0] Z; // next states of netted
    
    BirdLogicHort Hort( .clk(clk), .go(go), .rand(rand[1]), .restart(restart), .start(start), .Q(A), .startH(startH), .nextH(nextH), .D(X) );
    BirdLogicVert Vert( .clk(clk), .go(go), .rand(rand[0]), .restart(restart), .start(start), .Q(B), .startV(startV), .nextV(nextV), .D(Y) );
    BirdLogicNet Netted( .clk(clk), .showTime(showTime), .freeBirds(freeBirds), .netH(netH), .netV(netV), .netSize(netSize), /*.timeUp(timeUp),*/ .Q(C), .nextH(nextH), .nextV(nextV), .caught(caught), .D(Z) );
    
    FDRE #(.INIT(1'b1)) X0_FF (.C(clk), .CE(1'b1), .D(X[0]), .Q(A[0])); // greset gives 001 (start in hold state)
    FDRE #(.INIT(1'b0)) X1to2_FF[2:1] (.C({2{clk}}), .CE({2{1'b1}}), .D(X[2:1]), .Q(A[2:1]));
    
    FDRE #(.INIT(1'b1)) Y0_FF (.C(clk), .CE(1'b1), .D(Y[0]), .Q(B[0])); // greset gives 001 (start in hold state)
    FDRE #(.INIT(1'b0)) Y1to2_FF[2:1] (.C({2{clk}}), .CE({2{1'b1}}), .D(Y[2:1]), .Q(B[2:1]));
    
    FDRE #(.INIT(1'b1)) Z0_FF (.C(clk), .CE(1'b1), .D(Z[0]), .Q(C[0])); // greset gives 01 (start in free state)
    FDRE #(.INIT(1'b0)) Z1_FF (.C(clk), .CE(1'b1), .D(Z[1]), .Q(C[1]));
    
endmodule
