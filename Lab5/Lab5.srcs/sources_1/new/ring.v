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


module ring(
    input digsel,
    input clk,
    
    output [3:0] out
    );
    
    wire [3:0] rcount;
    
    FDRE #(.INIT(1'b1) ) ff1 (.C(clk), .R(1'b0), .CE(digsel), .D(rcount[3]), .Q(rcount[0])); // initalizied to 1
    FDRE #(.INIT(1'b0) ) ff2 (.C(clk), .R(1'b0), .CE(digsel), .D(rcount[0]), .Q(rcount[1]));
    FDRE #(.INIT(1'b0) ) ff3 (.C(clk), .R(1'b0), .CE(digsel), .D(rcount[1]), .Q(rcount[2]));
    FDRE #(.INIT(1'b0) ) ff4 (.C(clk), .R(1'b0), .CE(digsel), .D(rcount[2]), .Q(rcount[3]));
    
    assign out = rcount;
    
endmodule
