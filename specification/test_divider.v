//
// EECE 479: Project Verilog File: test_divider.v
//
// This is a file you can use to test your divider block.
// To be correct, your design HAS TO WORK WITH THIS TESTFILE.
// We will use this testfile (with different test cases) to
// mark your design.  If the timing doesn't match, it is wrong.
// Getting an answer one cycle too early or one cycle too late 
// is wrong.
//

module  test_divider;

wire [6:0] remainder;
wire [7:0] quotient;
wire valid;
reg [6:0] divisorin;
reg [7:0] dividendin;
reg start;
reg clk;
reg reset;

//////////////////////////////////////////////////////////////////////////
// Instantiate the module
//////////////////////////////////////////////////////////////////////////

divider u0(
         .remainder(remainder),
         .quotient(quotient),
         .valid(valid),
         .divisorin(divisorin),
         .dividendin(dividendin),
         .start(start),
         .clk(clk),
         .reset(reset));

// Create a clock...

`define    QTR_PERIOD    5000
always begin
   #(`QTR_PERIOD) clk = 1;
   //$display("CLK");
   #(`QTR_PERIOD) clk = 0;
   //$display("nCLK");
end


//////////////////////////////////////////////////////////////////////////
// The test commands
//////////////////////////////////////////////////////////////////////////

initial begin
   test_divider;
   $finish;
end


//////////////////////////////////////////////////////////////////////////
// The code that actually runs the test
//////////////////////////////////////////////////////////////////////////


task test_divider;

 
  reg [6:0] divisorin_copy; 
  reg [7:0] dividendin_copy;
  integer cnt, num, numpass, numfail, numtest;
  
  begin

    // A clock cycle just to get things going

    @(negedge clk);

    numpass = 0;
    numfail = 0;
    reset = 0;
    numtest = 40;

    // Do 40 test cases (you might want to test with many more
    // than this, just to be sure your design is ok).  Note that
    // your design does not have to handle the divide-by-zero case,
    // so we will make sure we don't test that case.

    for(num=0;num<numtest;num=num+1) begin       

       // Assert Start for one cycle
       start = 1;

       @(negedge clk);
       //$display("START = 1");

       // Negate start and set inputs

       start = 0;

       // Choose dividend and divisor randomly 

       dividendin_copy = $random;
       divisorin_copy = $random;

       // If divisor is a 0, choose another number, since we don't
       // need to test for the divide-by-zero case

       while(divisorin_copy == 0) divisorin_copy = $random;

       dividendin = dividendin_copy;
       divisorin = divisorin_copy;
       
       //$display("DIVIDEND INITIALIZED: %b", dividendin);

       // Now wait 17 cycles
 
       for(cnt=0; cnt<17; cnt=cnt+1) begin
          @(negedge clk);
       end

       // Print Results for this test case
       
       //
       // TODO: add check for "valid" output as they will be testing for it
       //

       if (quotient * divisorin_copy + remainder == dividendin_copy) 
       begin
          $display("Pass: %d/%d = %d rem %d",
                                  dividendin_copy,
                                  divisorin_copy,
                                  quotient, remainder);
          numpass = numpass +1;
       end else begin
          $display("Fail: %d/%d is not %d rem %d",
                                  dividendin_copy,
                                  divisorin_copy,
                                  quotient, remainder); 
          numfail = numfail +1;
       end
    end

    $display("Number test cases passed: %d",numpass);
    $display("Number test cases failed: %d",numfail);
  
    if (numfail == 0)
       $display("Good work!");

 end
endtask
endmodule

