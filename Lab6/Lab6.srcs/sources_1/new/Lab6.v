`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2019 01:48:39 PM
// Design Name: 
// Module Name: Lab6
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


module Lab6(
    input btnL,
    input btnR,
    input btnD, // (greset)
    input clkin,
    
    output led8,
    output led15,
    output [3:0] an,
    output dp,
    output [6:0] seg
    );
    
    assign dp = 1'b1; // never want dp on :(
    
    wire clk, digsel, qsec;
    
    lab6_clks slowit (.clkin(clkin), .greset(btnD), .clk(clk), .digsel(digsel), .qsec(qsec));
    
    wire left, right;
    
    FDRE #(.INIT(1'b0) ) ff1 ( .C(clk), .R(1'b0), .CE(1'b1), .D(btnL), .Q(left) ); // synchronize the buttons
    FDRE #(.INIT(1'b0) ) ff2 ( .C(clk), .R(1'b0), .CE(1'b1), .D(btnR), .Q(right) );

    wire showTime, SRTime, pointL, pointR;
    
    StateMachine machine( .clk(clk), .btnL(left), .btnR(right), .showTime(showTime), .SRTime(SRTime), .pointL(pointL), .pointR(pointR) );
    
    wire [7:0] useless, timer; // timer for lower 8 bits, useless to satisfy machine output (top 8 bits)
     
    countUD16L timeCount( .clk(clk), .Up(qsec & ~timer[4] & (btnR | btnL)), .Dw(1'b0), .LD(SRTime), .Din(16'b0000000000000000), .Q( {useless, timer} ) );

    wire [7:0] temp, value; // temp is meaningless, value has the MSB = sign and other bits are the value
    countUD16L turkeyCount( .clk(clk), .Up(pointR), .Dw(pointL), .LD(1'b0), .Din(16'b0000000000000000), .Q( {temp, value} ) );

    // logic using sign changer to make an[2]: G = 1. MSB of 
    wire [6:0] final; // holds the 7 bit final value
    wire meaningless; // holds the MSB (meaningless)
    
    wire sign;
    assign sign = value[7];
    
    SignChanger signPicker( .sign(sign), .b(value), .d( {meaningless, final} ) );
    
    assign led8 = btnR; 
    assign led15 = btnL;

    wire [15:0] Q; // Q is the bits that are going to be used to select and then show
    wire [3:0] sel, n; // sel is selector 4 bits, n is chosen 4 bits of Q
  
    assign Q = { timer[5:2], 4'b0000, {1'b0, final} };  

    ring ring( .digsel(digsel), .clk(clk), .out(sel) );
    
    selector sel1( .sel(sel), .N(Q), .H(n) );
    
    wire [3:0] qF; // holds flashing signal
    wire flash = timer[4]; // allows flash signal
    
    counter4L qFlash( .clk(clk), .CE(qsec), .Q(qF) ); // qF[1] causes a flash every half second

    assign an[3] = ~( sel[3] & ( (~flash & showTime) | (flash & qF[1]) ) ); // timer
    assign an[2] = ~(sel[2] & sign ); // sign
    assign an[1:0] = ~sel[1:0]; // score
     
    wire [6:0] segTemp, neg; 
    assign neg = 7'b0111111; // 1 000 000 (makes G = 1)
//    assign neg = 7'b1000000; // 1 000 000 (makes G = 1)
    
    hex7seg seg1( .n(n), .e(1'b1), .seg(segTemp) );
    
//    assign seg = ~( ( ~neg & {7{sel[2]}} ) | ~( {7{~sel[2]}} & segTemp ) );
    assign seg = ( ( neg & {7{sel[2]}} ) | ( {7{~sel[2]}} & segTemp ) );
    
endmodule
