`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2019 04:33:07 PM
// Design Name: 
// Module Name: StateMachine
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


module StateMachine(
    input clk,
    input btnL,
    input btnR,
    
    output showTime,
    output SRTime,
    output pointL,
    output pointR
    );
    
    wire [6:0] Q;
    wire [6:0] D;
    
    StateLogic  logic( .btnL(btnL), .btnR(btnR), .Q(Q), .showTime(showTime), .SRTime(SRTime), .pointL(pointL), .pointR(pointR), .D(D) );
    
    FDRE #(.INIT(1'b1)) Q0_FF (.C(clk), .CE(1'b1), .D(D[0]), .Q(Q[0])); // greset gives 000 0001 (start in idle state)
    FDRE #(.INIT(1'b0)) Q1to6_FF[6:1] (.C({6{clk}}), .CE({6{1'b1}}), .D(D[6:1]), .Q(Q[6:1]));
    
endmodule

