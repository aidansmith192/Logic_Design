`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2019 10:55:21 AM
// Design Name: 
// Module Name: Lab5
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


module Lab5(
    input clkin,
    input btnR,
    input btnU,
    input btnC,
    input btnD,
    input sw0,
    
    output [15:0] led,
    output [3:0] an,
    output dp,
    output [6:0] seg
    );
    
    wire [15:0] disp; // hex 7 disp values
    
    wire clk, digsel, qsec; // timers
    
    lab5_clks slowit (.clkin(clkin), .greset(btnR), .clk(clk), .digsel(digsel), .qsec(qsec));
    
    wire timeUp; // LSFR variables
    wire [7:0] rnd;
    
    LSFR random( .clk(clk), .rnd(rnd) );
    
    wire lastLED; // LED_shifter value
    
    wire showTime, loadTime, runTime, incU, incD, showScore, flashU, flashD; // state machine outputs
    
    StateMachine state( .clk(clk), .btnC(btnC), .btnU(btnU), .btnD(btnD), .timeUp(timeUp), .lastLED(lastLED), .showTime(showTime), .loadTime(loadTime), .runTime(runTime), .incU(incU), .incD(incD), .showScore(showScore), .flashU(flashU), .flashD(flashD) );
    
    LED_Shifter led_shift( .CE(showTime & qsec), .clk(clk), .R(btnR | runTime), .q(led) );
    
    assign lastLED = led[15]; // if last LED shown
    
    wire [7:0] temp;
    
    time_counter timeC( .clk(clk), .Up(1'b0), .Dw(runTime & qsec), .LD(loadTime), .Din(rnd), .Q( {temp, disp[11:4]}) );
    
    assign timeUp = ~(|disp[11:4]); // if time = 0000 0000, then timeUp = 1
    
    counter4L countU( .clk(clk), .CE(incU), .Q(disp[15:12]) );
    counter4L countD( .clk(clk), .CE(incD), .Q(disp[3:0]) );
    
    wire [3:0] sel, n; // selector bits and n (the 4-bit bus that is selected)
    
    ring ring( .digsel(digsel), .clk(clk), .out(sel) );
    
    selector select( .sel(sel), .N(disp), .H(n) );
    
    wire [3:0] qF;
    
    counter4L qFlash( .clk(clk), .CE(qsec), .Q(qF) );
    
    assign an[0] = ~( sel[0] & ( (~flashD & showScore) | (flashD & qF[1]) ) ); // player D score
    assign an[3] = ~( sel[3] & ( (~flashU & showScore) | (flashU & qF[1]) ) ); // player U score
    assign an[2:1] = ~(sel[2:1] & {2{ (showTime | sw0) }} ); // timer
    assign dp = 1'b1; // turn off decimal point
    
    hex7seg segdisp( .n(n), .e(1'b1), .seg(seg) );
    
endmodule
