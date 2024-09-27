`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2019 07:38:08 PM
// Design Name: 
// Module Name: test_bench
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


module test_bench_Lab4();

  reg clkin, btnR, btnC, Up, Dw, LD;
  reg [15:0] b;
  wire [6:0] seg;
  wire [3:0] an;
  wire dp, UTC;
  
  Lab4
   UUT (
      .clkin(clkin),
      .greset(btnR),
      .btnU(Up),
      .btnD(Dw),
      .LD(LD),
      .btnC(btnC),
      .Din(b),
      .seg(seg),
      .dp(dp),
      .an(an)
      );

    parameter PERIOD = 10;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET = 2;

    initial    // Clock process for clkin
    begin
        #OFFSET
		  clkin = 1'b1;
        forever
        begin
            #(PERIOD-(PERIOD*DUTY_CYCLE)) clkin = ~clkin;
        end
	end
	
   initial
   begin
   
//-----------------------------

     #1000; // move to 1000ns so clock works
     
     // btnC held down
     btnC = 1'b1;
     btnR = 1'b0;
     Up = 1'b0;
     Dw = 1'b0;
     LD = 1'b0;
     b[15:0] = 16'b0000000000000000;
     #100;
   
	 //btnC let go and let sit
	 btnC = 1'b0;
	 #100;
	 
	 //btnU held down
	 Up = 1'b1;
	 #100; 
	 
	 //btnD held down
	 Up = 1'b0;
	 Dw = 1'b1;
	 #100;

	end

endmodule
