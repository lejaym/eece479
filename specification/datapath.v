//
// EECE 479: Project Verilog File: datapath.v
//
// This is the stub for the datapath block.  Please start with this
// template when writing your Verilog code.
//
// Names:  Steve Novakovic, Marc Lejay
// Number:  13305081, 47593108
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

reg[8:0] AddSub;

reg[15:0] Mux;

wire[15:0] ShiftA;
reg[15:0] ShiftB;

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
assign ShiftA = Mux;

// 8 Bit Divisor Register
always @(posedge clk or posedge reset)
begin
  if (reset == 1'b1) begin
    rDivisor = 8'b00000000;
  end
  else begin
    if (load == 1'b1)
      rDivisor[7:0] = divisorin;
  end
end

// 16 Bit 3:1 Mux
always @(sel or dividendin or AddSub or rRemainder)
begin
  case(sel) 
    2'b10: begin
              $display("10 %b", dividendin);
              Mux[15:8] <= 8'b00000000;
              Mux[7:0] <= dividendin;
           end
    2'b01: begin
              $display("01 %b  %b", AddSub, rRemainder[7:0]);
              Mux[15:8] <= AddSub;
              Mux[7:0] <= rRemainder[7:0];
           end
    2'b11: begin
              Mux <= rRemainder;
              $display("11");
           end
  endcase
  $display("MUX: %b", Mux);
 end
 
// 8 bit add subtract
// when add does not change
// no action is performed on the register
// TODO: should maybe rewrite this more realistically
// to be two separate always and use neg/posedge
always @(add or rDivisor or rRemainder)
begin
  $display("A/S %b %b", rRemainder[15:8], rDivisor);
  if (add == 1'b0)
    AddSub  <= rRemainder[15:8] - rDivisor;
  else
    AddSub <= rRemainder[15:8] + rDivisor;
end

// TODO: gotta figure out how to implement the shift register.

//always @(posedge shift)
//begin
  //ShiftB = (ShiftA << 1); 
  //ShiftB[0] = inbit;
//end

//assign SNS = Mux; 
 
// SNS to rRemainder
always @(posedge clk or posedge reset)
begin
  if (reset == 1'b1) begin
    rRemainder = 16'b0000000000000000;
  end
  else begin
    rRemainder <= ShiftA; //TODO: change to ShiftB after figuring out shift register
  end
end



// diagnostic only
always @(negedge clk)
begin
  $display("rRemainder (nege): %b", rRemainder);
end

endmodule
