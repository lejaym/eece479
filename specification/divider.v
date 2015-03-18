//
// EECE 479: Project Verilog File: divider.v
//
// This is the stub for your top-level block.  Please start with this
// template when writing your Verilog code.
//
// Names:  Steve Novakovic, Marc Lejay
// Number:  13305081, 47593108
//

// run tb w/   
// >> verilog controller.v datapath.v divider.v test_divider.v
// (do not include other modules)

module divider(
         remainder,
         quotient,
	       valid,
         divisorin,
         dividendin,
         start,
         clk,
         reset);

output [6:0] remainder;
output [7:0] quotient;
output valid;  
input [6:0] divisorin;
input [7:0] dividendin;
input start;
input clk;
input reset;

wire sign, load, add, shift, inbit;
wire[1:0] sel;

datapath d0(
  .remainder(remainder),
  .quotient(quotient),
  .sign(sign),
  .divisorin(divisorin),
  .dividendin(dividendin),
  .load(load),
  .add(add),
  .shift(shift),
  .inbit(inbit),
  .sel(sel),
  .clk(clk),
  .reset(reset)
);

controller c0(
  .load(load),
  .add(add),
  .shift(shift),
  .inbit(inbit),
  .sel(sel),
  .valid(valid),
  .start(start),
  .sign(sign),
  .clk(clk),
  .reset(reset)
);

endmodule
