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


module test_bench_Lab5();

  reg clkin, btnR, btnC, btnU, btnD;
  reg sw0;
  wire [15:0] led;
  wire [6:0] seg;
  wire [3:0] an;
  wire dp;
  
  Lab5
   UUT (
      .clkin(clkin),
      .btnR(btnR),
      .btnU(btnU),
      .btnD(btnD),
      .btnC(btnC),
      .led(led),
      .sw0(sw0),
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
     
     btnR = 1'b0;
     btnC = 1'b0;
     btnU = 1'b0;
     btnD = 1'b0;
     sw0 = 1'b0;
     
     #1000; // wait for clock to start
     
     // btnC pressed to start game!
     btnC = 1'b1;
     
     // wait for LED
     #10000;
     btnC = 1'b0;
     #100;
     
     // btnU win
     btnU = 1'b1;
     #100;
     btnD = 1'b1;
     btnU = 1'b0;
     #100;
     btnD = 1'b0;
     
     // reset
     btnC = 1'b1;
     #10000;
     btnC = 1'b0;
     #100;
     
     // btnD win
     btnD = 1'b1;
     #100;
     btnU = 1'b1;
     btnD = 1'b0;
     #100;
     btnD = 1'b0;
     
     // reset
     btnC = 1'b1;
     #10000;
     btnC = 1'b0;
     #100;
     
     // both win
     btnU = 1'b1;
     btnD = 1'b1;
     #1000;
     
     //fin
     
	end

endmodule
