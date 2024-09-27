`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2019 03:38:50 PM
// Design Name: 
// Module Name: SignChanger
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


module SignChanger(
    input sign,
    input [7:0] b,
  
    output [7:0] d
    );
    
    wire [7:0] c, comp; // c = carry in/outs, comp = 2's comp
    
    Adder add0(.a(~b[0]), .cin(sign), .b(1'b0), .o(c[0]), .s(comp[0]));
    Adder add1(.a(~b[1]), .cin(c[0]), .b(1'b0), .o(c[1]), .s(comp[1]));
    Adder add2(.a(~b[2]), .cin(c[1]), .b(1'b0), .o(c[2]), .s(comp[2]));
    Adder add3(.a(~b[3]), .cin(c[2]), .b(1'b0), .o(c[3]), .s(comp[3]));
    Adder add4(.a(~b[4]), .cin(c[3]), .b(1'b0), .o(c[4]), .s(comp[4]));
    Adder add5(.a(~b[5]), .cin(c[4]), .b(1'b0), .o(c[5]), .s(comp[5]));
    Adder add6(.a(~b[6]), .cin(c[5]), .b(1'b0), .o(c[6]), .s(comp[6]));
    Adder add7(.a(~b[7]), .cin(c[6]), .b(1'b0), .o(c[7]), .s(comp[7])); // last carry out doesnt matter
    
    m2_1x8 mux2pick( .in0(b), .in1(comp), .sel(sign), .o(d) ); // controls whether 2's comp or normal is returned
    
endmodule
