// Verilog test fixture created to test sync signals
//  Instructions:
// 1. Add to your project.
// 2. Adjust instantiation of UUT (line 43).
// 3. Comment out lines 107 and 132 if your outputs are not run through FFs.
// 4. Run Simulator.
// 5. Add SERRORS and RGBERRORS to the waveform viewer (under GUT and RUT)
// 6. Reset simulation time to 0
// 7. Set step size to 17ms
// 8. Simulate one step (may take ?? seconds, or more if you have more components.
// 9. If SERRORs or RGBERRORS is not 0 find where they changed: that's a problem.
// check for transitions on "oops" and rgb_oops" to find out where
//10. Otherwise simulate one more step and check them again. 
//
//   Martine  Feb 22 2019

`timescale 1ns / 1ps

module testSyncs();

// Inputs
   reg btnL, btnR, btnD;
   reg clkin;

// Output
   wire [3:0] an;
   wire dp, led8, led15;
   wire [6:0] seg;


// You may need to replace the instantiation below
// to match your top level module and its port names.

// Instantiate the UUT
   Lab6 UUT (
    .btnL(btnL),
    .btnR(btnR),
    .btnD(btnD), // (greset)
    .clkin(clkin),
    
    .led8(led8),
    .led15(led15),
    .an(an),
    .dp(dp),
    .seg(seg)
    );
    
   	
 
// Clock parameters
   parameter PERIOD = 10;
   parameter real DUTY_CYCLE = 0.5;
   parameter OFFSET = 2;

	initial
	begin
		clkin = 1'b0;
	   #OFFSET
		clkin = 1'b1;
      forever
         begin
            #(PERIOD-(PERIOD*DUTY_CYCLE)) clkin = ~clkin;
         end
	end
	
	initial // the only input needed is a GSR pulse on sw[0]
	  begin // if you have others, set them to 0 or 1
       btnL = 1'b0;
       btnR = 1'b0;
       btnD = 1'b0;
       #1000; // wait for clock
       
       // minus point
       btnL = 1'b1;
       #100;
       btnR = 1'b1;
       #100;
       btnL = 1'b0;
       #100;
       btnR = 1'b0;
       #100;
       
       // plus point
       btnR = 1'b1;
       #100;
       btnL = 1'b1;
       #100;
       btnR = 1'b0;
       #100;
       btnL = 1'b0;
       #100;
       
       // nothing meaningful
       btnL = 1'b1;
       #100;
       btnR = 1'b1;
       #100;
       btnL = 1'b0;
       #100;
       btnL = 1'b1;
       #100;
       btnR = 1'b0;
       #100;
       btnL = 1'b0;
       #100;
       
	  end
   
endmodule

