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

module testBird();

// Inputs
   reg btnC, go;
   reg [9:0] startH, startV, netH, netV, netSize;
   reg clkin;
   reg [1:0] rand;

// Output
   wire [9:0] nextH, nextV;
   wire caught;

// You may need to replace the instantiation below
// to match your top level module and its port names.

// Instantiate the UUT
   Bird UUT (
    .clk(clkin),
    .netH(netH),
    .rand(rand),
    .netV(netV),
    .netSize(netSize),
    .caught(caught), 
    .go(go),
    .btnC(btnC),
    .startH(startH), 
    .startV(startV), 
    .nextH(nextH), 
    .nextV(nextV)
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
       btnC = 1'b0;
       go = 1'b0;
       rand = 2'b11;
       startH = 10'd100;
       startV = 10'd100;
       netH = 10'd126;
       netV = 10'd126;
       netSize = 10'd10;
       #100;
       btnC = 1'b1;
       #10;
       btnC = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       #10;
       go = 1'b1;
       #10;
       go = 1'b0;
       
       
       
       
       
	  end
   
endmodule

