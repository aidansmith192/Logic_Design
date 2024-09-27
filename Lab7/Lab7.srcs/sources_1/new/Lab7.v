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


module Lab7(
    input clkin,
    input btnL, // Left
    input btnR, // Right
    input btnU, // Up
    input btnD, // Down
    input BTNC, // game start (diff name since it must be edge detected!)
    input [15:0] sw, // time to catch birds
    
    output [15:0] led,
    output [3:0] an,
    output dp,
    output [6:0] seg,
    
    output Hsync,
    output Vsync,
    output [3:0] vgaRed, 
    output [3:0] vgaBlue, 
    output [3:0] vgaGreen
    );
    
    assign dp = 1'b1;
    
    wire left, right;
    
    wire clk, digsel;
    
    lab7_clks slowit (.clkin(clkin), .greset(sw[0]), .clk(clk), .digsel(digsel));
    
    wire btnC; // edge detected
    
    edgeD edgeD(.clk(clk), .btn(BTNC), .o(btnC) );
    
    FDRE #(.INIT(1'b0) ) ff1 ( .C(clk), .R(1'b0), .CE(1'b1), .D(btnL), .Q(left) ); // synchronize the buttons
    FDRE #(.INIT(1'b0) ) ff2 ( .C(clk), .R(1'b0), .CE(1'b1), .D(btnR), .Q(right) ); 
    
    wire [9:0] Hpixel, Vpixel;
    
    countUD10L Hcount( .clk(clk), .Up(1'b1), .Dw(1'b0), .LD(Hpixel == 10'd799), .Din(10'b0000000000), .Q(Hpixel) );
    countUD10L Vcount( .clk(clk), .Up(Hpixel == 10'd799), .Dw(1'b0), .LD((Hpixel == 10'd799) & (Vpixel == 10'd524)), .Din(10'b0000000000), .Q(Vpixel) );

    assign Hsync = ~((Hpixel >= 10'd655) & (Hpixel <= 10'd750));
    assign Vsync = ~((Vpixel >= 10'd489) & (Vpixel <= 10'd490));
    
    wire active = (Hpixel <= 10'd639) & (Vpixel <= 10'd479); // defines active region
    
    wire frameCount = (Hpixel == 10'd799) & (Vpixel == 10'd524); // gives a 1 once per frame 
    wire extraCount = (Hpixel == 10'd798) & (Vpixel == 10'd523);
    
    wire go = frameCount | extraCount; // causes a count twice per frame
    
    wire [7:0] useless1, useless2, frames, timer; // frames counts frames, timer counts down from set time
    
    wire timeUp, showTime, startTime, loadTime, freeBirds, win, start, runTime, restart;

    countUD16L secondCount( .clk(clk), .Up(frameCount), .Dw(1'b0), .LD(frames == 16'd60), .Din( 16'h0000 ), .Q( {useless1, frames} ) );

    countUD16L countDown( .clk(clk), .Up(1'b0), .Dw( (frames == 8'd60 ) & runTime), .LD(loadTime | restart ), .Din( { 8'b00000000, sw[11:4] } & {16{loadTime}} ), .Q( {useless2, timer} ) );
    
    assign timeUp = runTime & ( timer == 8'h00 );
    
    wire [7:0] caught; // caught = # birds caught
        
    Game game(.clk(clk), .btnC(btnC), .caught(caught), .win(win), .timeUp(timeUp), .showTime(showTime), .runTime(runTime), .start(start), .loadTime(loadTime), .restart(restart), .startTime(startTime), .freeBirds(freeBirds));
    
    wire [9:0] netH, netV, netSize; // netSize same size to avoid math errors
    assign netSize = { 2'b00, sw[15], sw[14], 6'b011111}; // normally 32 long, 1 + 31. increased by switches
        
    Net net( .clk(clk), .start(start), .loadTime(loadTime), .win(win), .restart(restart), .btnL(btnL), .btnR(btnR), .btnU(btnU), .btnD(btnD), .netSize(netSize), .go(frameCount), .startH(10'd310 - (netSize/10'd2) ), .startV(10'd255 - (netSize/10'd2) ), .nextH(netH), .nextV(netV) /*.netLook(netLook)*/ );
    
    wire [7:0] rand;
    
    LSFR randomizer(.clk(clk), .rnd(rand));
    
    wire [15:0] longRand = { ~rand, rand}; // every bird gets a random bit for up/down and all cannot be the same
    
    wire [9:0] bird1H, bird1V, bird2H, bird2V, bird3H, bird3V, bird4H, bird4V, bird5H, bird5V, bird6H, bird6V, bird7H, bird7V, bird8H, bird8V; 

    Bird bird1( .clk(clk), .showTime(showTime), .start(start), .go(go), .restart(restart), .freeBirds(freeBirds), .rand(longRand[1:0]), .netH(netH), .netV(netV), .netSize(netSize), .startH(10'd100), .startV(10'd75), .nextH(bird1H), .nextV(bird1V), .caught(caught[0]) );
    Bird bird2( .clk(clk), .showTime(showTime), .start(start), .go(go), .restart(restart), .freeBirds(freeBirds), .rand(longRand[3:2]), .netH(netH), .netV(netV), .netSize(netSize), .startH(10'd300), .startV(10'd75), .nextH(bird2H), .nextV(bird2V), .caught(caught[1]) );
    Bird bird3( .clk(clk), .showTime(showTime), .start(start), .go(go), .restart(restart), .freeBirds(freeBirds), .rand(longRand[5:4]), .netH(netH), .netV(netV), .netSize(netSize), .startH(10'd500), .startV(10'd75), .nextH(bird3H), .nextV(bird3V), .caught(caught[2]) );
    Bird bird4( .clk(clk), .showTime(showTime), .start(start), .go(go), .restart(restart), .freeBirds(freeBirds), .rand(longRand[7:6]), .netH(netH), .netV(netV), .netSize(netSize), .startH(10'd100), .startV(10'd250), .nextH(bird4H), .nextV(bird4V), .caught(caught[3]) );
    Bird bird5( .clk(clk), .showTime(showTime), .start(start), .go(go), .restart(restart), .freeBirds(freeBirds), .rand(longRand[9:8]), .netH(netH), .netV(netV), .netSize(netSize), .startH(10'd500), .startV(10'd250), .nextH(bird5H), .nextV(bird5V), .caught(caught[4]) );
    Bird bird6( .clk(clk), .showTime(showTime), .start(start), .go(go), .restart(restart), .freeBirds(freeBirds), .rand(longRand[11:10]), .netH(netH), .netV(netV), .netSize(netSize), .startH(10'd100), .startV(10'd400), .nextH(bird6H), .nextV(bird6V), .caught(caught[5]) );
    Bird bird7( .clk(clk), .showTime(showTime), .start(start), .go(go), .restart(restart), .freeBirds(freeBirds), .rand(longRand[13:12]), .netH(netH), .netV(netV), .netSize(netSize), .startH(10'd300), .startV(10'd400), .nextH(bird7H), .nextV(bird7V), .caught(caught[6]) );
    Bird bird8( .clk(clk), .showTime(showTime), .start(start), .go(go), .restart(restart), .freeBirds(freeBirds), .rand(longRand[15:14]), .netH(netH), .netV(netV), .netSize(netSize), .startH(10'd500), .startV(10'd400), .nextH(bird8H), .nextV(bird8V), .caught(caught[7]) );

    wire [3:0] wall, netG, netB, netR, bird1R, bird1B, bird2R, bird2B, bird3R, bird3B, bird4R, bird4B;
    wire [3:0] bird5R, bird5B, bird6R, bird6B, bird7R, bird7B, bird8R, bird8B;
    
    assign wall = {4{ ( ( ( (Hpixel <= 10'd7) | ( (Hpixel >= 10'd632) & (Hpixel <= 10'd639) ) ) | ( (Vpixel <= 10'd7) | ( (Vpixel >= 10'd472) & (Vpixel <= 10'd479) ) ) ) & active)}};
    assign netG = {4{ ( ( (Hpixel >= netH + 10'd7) & ( Hpixel <= ( netH + netSize - 10'd7) ) ) & ( ( Vpixel >= netV + 10'd7) & ( Vpixel <= ( netV + netSize - 10'd7) ) ) ) & active & |caught }};
    assign netB = {4{ ( ( (Hpixel >= netH) & ( Hpixel <= ( netH + netSize ) ) ) & ( ( Vpixel >= netV ) & ( Vpixel <= ( netV + netSize ) ) ) ) & active }};
    assign netR = {4{ ( ( (Hpixel >= netH + 10'd7) & ( Hpixel <= ( netH + netSize - 10'd7) ) ) & ( ( Vpixel >= netV + 10'd7) & ( Vpixel <= ( netV + netSize - 10'd7) ) ) ) & active & &caught }};
    assign bird1R = {4{ ( ( (Hpixel >= bird1H) & ( Hpixel <= ( bird1H + 10'd15 ) ) ) & ( ( Vpixel >= bird1V ) & ( Vpixel <= ( bird1V + 10'd15 ) ) ) ) & active }};
    assign bird1B = bird1R & {4{ caught[0] }};
    assign bird2R = {4{ ( ( (Hpixel >= bird2H) & ( Hpixel <= ( bird2H + 10'd15 ) ) ) & ( ( Vpixel >= bird2V ) & ( Vpixel <= ( bird2V + 10'd15 ) ) ) ) & active }};
    assign bird2B = bird2R & {4{ caught[1] }};
    assign bird3R = {4{ ( ( (Hpixel >= bird3H) & ( Hpixel <= ( bird3H + 10'd15 ) ) ) & ( ( Vpixel >= bird3V ) & ( Vpixel <= ( bird3V + 10'd15 ) ) ) ) & active }};
    assign bird3B = bird3R & {4{ caught[2] }};
    assign bird4R = {4{ ( ( (Hpixel >= bird4H) & ( Hpixel <= ( bird4H + 10'd15 ) ) ) & ( ( Vpixel >= bird4V ) & ( Vpixel <= ( bird4V + 10'd15 ) ) ) ) & active }};
    assign bird4B = bird4R & {4{ caught[3] }};
    assign bird5R = {4{ ( ( (Hpixel >= bird5H) & ( Hpixel <= ( bird5H + 10'd15 ) ) ) & ( ( Vpixel >= bird5V ) & ( Vpixel <= ( bird5V + 10'd15 ) ) ) ) & active }};
    assign bird5B = bird5R & {4{ caught[4] }};
    assign bird6R = {4{ ( ( (Hpixel >= bird6H) & ( Hpixel <= ( bird6H + 10'd15 ) ) ) & ( ( Vpixel >= bird6V ) & ( Vpixel <= ( bird6V + 10'd15 ) ) ) ) & active }};
    assign bird6B = bird6R & {4{ caught[5] }};
    assign bird7R = {4{ ( ( (Hpixel >= bird7H) & ( Hpixel <= ( bird7H + 10'd15 ) ) ) & ( ( Vpixel >= bird7V ) & ( Vpixel <= ( bird7V + 10'd15 ) ) ) ) & active }};
    assign bird7B = bird7R & {4{ caught[6] }};
    assign bird8R = {4{ ( ( (Hpixel >= bird8H) & ( Hpixel <= ( bird8H + 10'd15 ) ) ) & ( ( Vpixel >= bird8V ) & ( Vpixel <= ( bird8V + 10'd15 ) ) ) ) & active }};
    assign bird8B = bird8R & {4{ caught[7] }};
    
    assign vgaGreen = netG | wall;
    assign vgaBlue = netB | bird1B | bird2B | bird3B | bird4B | bird5B | bird6B | bird7B | bird8B;
    assign vgaRed = netR | bird1R| bird2R | bird3R | bird4R | bird5R | bird6R | bird7R | bird8R;
    
    wire [15:0] Q; // Q is the bits that are going to be used to select and then show
    wire [3:0] sel, n; // sel is selector 4 bits, n is chosen 4 bits of Q
  
    wire [3:0] totalCaught = 4'h0 + caught[7] + caught[6] + caught[5] + caught[4] + caught[3] + caught[2] + caught[1] + caught[0];
  
    assign Q = { totalCaught, 4'h0, timer };  

    ring ring( .digsel(digsel), .clk(clk), .out(sel) );
    
    selector sel1( .sel(sel), .N(Q), .H(n) );
    
    assign an[3] = ~sel[3]; // birds caught
    assign an[2] = 1'b1; // not needed
    assign an[1:0] = ~sel[1:0]; // time
    
    hex7seg seg1( .n(n), .e(1'b1), .seg(seg) );
    
endmodule
