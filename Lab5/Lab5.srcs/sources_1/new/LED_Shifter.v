`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2019 04:06:57 PM
// Design Name: 
// Module Name: ring
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


module LED_Shifter(
    input CE,
    input clk,
    input R, // reset
    
    output [15:0] q
    );
    
    wire [15:0] rcount;
    
    FDRE #(.INIT(1'b0) ) ff0 (.C(clk), .R(R), .CE(CE), .D(1'b1), .Q(rcount[0])); // initalizied to 0, takes 1 as its first value
    FDRE #(.INIT(1'b0) ) ff1 (.C(clk), .R(R), .CE(CE), .D(rcount[0]), .Q(rcount[1]));
    FDRE #(.INIT(1'b0) ) ff2 (.C(clk), .R(R), .CE(CE), .D(rcount[1]), .Q(rcount[2]));
    FDRE #(.INIT(1'b0) ) ff3 (.C(clk), .R(R), .CE(CE), .D(rcount[2]), .Q(rcount[3]));
    FDRE #(.INIT(1'b0) ) ff4 (.C(clk), .R(R), .CE(CE), .D(rcount[3]), .Q(rcount[4]));
    FDRE #(.INIT(1'b0) ) ff5 (.C(clk), .R(R), .CE(CE), .D(rcount[4]), .Q(rcount[5]));
    FDRE #(.INIT(1'b0) ) ff6 (.C(clk), .R(R), .CE(CE), .D(rcount[5]), .Q(rcount[6]));
    FDRE #(.INIT(1'b0) ) ff7 (.C(clk), .R(R), .CE(CE), .D(rcount[6]), .Q(rcount[7]));
    FDRE #(.INIT(1'b0) ) ff8 (.C(clk), .R(R), .CE(CE), .D(rcount[7]), .Q(rcount[8]));
    FDRE #(.INIT(1'b0) ) ff9 (.C(clk), .R(R), .CE(CE), .D(rcount[8]), .Q(rcount[9]));
    FDRE #(.INIT(1'b0) ) ff10 (.C(clk), .R(R), .CE(CE), .D(rcount[9]), .Q(rcount[10]));
    FDRE #(.INIT(1'b0) ) ff11 (.C(clk), .R(R), .CE(CE), .D(rcount[10]), .Q(rcount[11]));
    FDRE #(.INIT(1'b0) ) ff12 (.C(clk), .R(R), .CE(CE), .D(rcount[11]), .Q(rcount[12]));
    FDRE #(.INIT(1'b0) ) ff13 (.C(clk), .R(R), .CE(CE), .D(rcount[12]), .Q(rcount[13]));
    FDRE #(.INIT(1'b0) ) ff14 (.C(clk), .R(R), .CE(CE), .D(rcount[13]), .Q(rcount[14]));
    FDRE #(.INIT(1'b0) ) ff15 (.C(clk), .R(R), .CE(CE), .D(rcount[14]), .Q(rcount[15]));
    
    assign q = rcount;
    
endmodule
