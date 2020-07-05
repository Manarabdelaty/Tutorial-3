// file: top_tb.v
// author: @manarabdelatty
// Testbench for top

`timescale 1ns/10ps

module top_tb;

	//Inputs
	reg clk;
	reg rst_n;
	reg [31: 0] mc;
	reg [31: 0] mp;
	reg start;


	//Outputs
	wire [63: 0] prod;
	wire done;
    
    
    wire [63:0] refp;
    wire err;

	//Instantiation of Unit Under Test
	top uut (
		.clk(clk),
		.rst_n(rst_n),
		.mc(mc),
		.mp(mp),
		.start(start),
		.prod(prod),
		.done(done)
	);

    assign refp= $signed(mc) * $signed(mp);               // Golden Model
    assign err= (done)? (refp != prod) : 1'bx;           // The Checker
    
    always #0.1 clk=!clk;                                // Clock Generator

    always @(posedge clk) begin                      // The Checker
         if (done == 1'b1)
             $display ( "time = %0d, clk = %b, start = %b, mc = %0d , mp= %0d ,P = %0d ,done = %b, Error= %b, refp= %0d"
                      , $time,clk,start,$signed(mc),$signed(mp), $signed(prod), done , err, $signed(refp));
         if (err) begin
             $display ("DUT Error at time %d", $time);
             $display ("Expected value %d, Got Value %d", refp, prod);
         end
    end
    
   event rst_trigger; 
   event start_trigger;
   event rst_done_trigger; 
   event start_disabled;
   event loop_trigger;
   
	initial begin
    $dumpfile("spm.vcd");
    $dumpvars(0, top_tb);
	//Inputs initialization
		clk = 0;
		rst_n = 0;
		mc = 0;
		mp = 0;
        start =0;
	end


    initial begin : TestCases
       #10 ->rst_trigger; 
       @(rst_done_trigger);
      
       @(negedge clk); begin                  // MC & MP must be stable before firing start
         mc =3;                              // Test Case1 : unsigned multiplier & unsigned multiplicant
         mp =4;
       end
      -> start_trigger;
     
      // Test Case2 : signed multiplier & unsigned multiplicant
      @(start_disabled);
       @(negedge clk); begin
         mc =-15;
         mp = 10;
       end
       ->start_trigger;
       
       // Test Case3 : unsigned multiplier & signed multiplicant
      @(start_disabled);
       @(negedge clk); begin
         mc = 200;
         mp = -50;
       end
       ->start_trigger;
       
      // Test Case4 : signed multiplier & signed multiplicant
      @(start_disabled);
       @(negedge clk); begin
         mc = -150;
         mp = -32;
       end
       ->start_trigger;
       
        // Test Case5 : Deassert Enable at the middle of multiply stage 
       @ (start_disabled);
       @(negedge clk); begin
         mc = 6;
         mp = 6;
       end
       ->start_trigger;
       repeat (50) begin
       @(negedge clk);
       end
       start = 0;

      $finish;
      //  // TestCase: for loop to generate mc & mp 
      //  @(start_disabled);
      //  -> loop_trigger;
 end 
 
    initial begin   // for loop thread
 
     @(loop_trigger);
     @(negedge clk) begin
       mc= (2**1-1);
       mp= (2**1-1);
     end
     ->start_trigger;
     
     forever begin
     @(start_disabled);
     @(negedge clk) begin
     mc= mc-1;
     mp= mp-1;
     end
     ->start_trigger;
    end
 end
 
 // Enable Logic
 
 initial begin
     forever begin
     @(start_trigger);
     start= 1;

      repeat (68) begin
      @(negedge clk);
      end
      
       start=0;
     ->start_disabled;
     end
 end
 
 //reset Logic
initial begin
     forever begin
     @(rst_trigger);
     @(negedge clk);
     rst_n = 0;
     @(negedge clk);
     rst_n = 1;
     ->rst_done_trigger;
     end
end
  
endmodule