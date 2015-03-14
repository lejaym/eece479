//
// EECE 479: Project Verilog File: datapath.v
//
// This is the stub for the datapath block.  Please start with this
// template when writing your Verilog code.
//
// Names:  Steve Novakovic, Marc Lejay
// Number:  13305081, XXXXXXXX
//

module datapath(remainder, 
                quotient, 
                sign,
                divisorin,
                dividendin,
                load,
                add,
                shift,
                inbit,
                sel,
                clk,
                reset);

output [6:0] remainder;
output [7:0] quotient;
output sign;
input [6:0] divisorin;
input [7:0] dividendin;
input load;
input add;
input shift;
input inbit;
input [1:0] sel;
input clk;
input reset;


reg[7:0] rDivisor;

wire[15:0] AddSub;

reg[15:0] Mux;
reg[15:0] SNS;
reg[15:0] rRemainder;

// Steve 2015-03-13
//
// Right now this module is implemented in a very
// "software like" way. It may be prudent to replace 
// all elements with the actual elements used in layout
// (adders, shift registers, etc) to get a feel for interconnect.
// 

assign quotient = rRemainder[7:0];
assign remainder = rRemainder[15:9];
assign sign = AddSub[7];


assign AddSub[15:9] = rRemainder[15:9];
assign AddSub[7:0] = rDivisor;

// 8 Bit Divisor Register
always @(posedge clk or negedge reset)
begin
  if (reset == 1'b0)
    rDivisor = 8'b00000000;
  else begin
    if (load == 1'b1)
      rDivisor[6:0] = divisorin;
  end
end

// 16 Bit 3:1 Mux
always @(sel)
begin
  case(sel)
    2'b10: begin
              Mux[15:8] <= 8'b00000000;
              Mux[7:0] <= dividendin;
            end
    2'b01: begin
              Mux[15:8] <= AddSub;
              Mux[7:0] <= rRemainder[7:0];
            end
    2'b11: begin
              Mux <= rRemainder;
            end
  endcase
 end
 
// SNS to rRemainder
always @(posedge clk or negedge reset)
begin
  if (reset == 1'b0)
    rRemainder = 16'h0000;
  else
    rRemainder = SNS;
end

endmodule
