//
// EECE 479: Project Verilog File: datapath.v
//
// This is the stub for the datapath block.  Please start with this
// template when writing your Verilog code.
//
// Names:  Steve Novakovic, Marc Lejay
// Number:  13305081, 47593108
//

`include "addsub.v"
`include "mux.v"
`include "shift.v"

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

wire[8:0] ASR; // Add/Sub Register

wire[15:0] Mux;

wire[15:0] SNS; // Shift/No-Shift

reg[15:0] rRemainder;

// NOTE: Steve 2015-03-13
//
// Right now this module is implemented with many discrete elements
// to get a feel for interconnect.
// 

assign quotient = rRemainder[7:0];
assign remainder = rRemainder[15:9];
assign sign = ASR[7];

//
// 8 Bit Divisor Register
// not going to decompose into logic blocks, simple enough
// any action is qualified here by load anyways
//
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

// 
// 8 bit add subtract
// input A will be the divisor register
// input B will be the rRemainder[15:8]
// carries are chained, but last carry is disconnected
//
wire c1,c2,c3,c4,c5,c6,c7,c8;

// sum, cout, A, B, cin, AS
addsub as0( .sum(ASR[0]), .cout(c1), .A(rRemainder[8]), .B(rDivisor[0]), .cin(~add), .AS(~add) );
addsub as1( .sum(ASR[1]), .cout(c2), .A(rRemainder[9]), .B(rDivisor[1]), .cin(c1), .AS(~add) );
addsub as2( .sum(ASR[2]), .cout(c3), .A(rRemainder[10]), .B(rDivisor[2]), .cin(c2), .AS(~add) );
addsub as3( .sum(ASR[3]), .cout(c4), .A(rRemainder[11]), .B(rDivisor[3]), .cin(c3), .AS(~add) );
addsub as4( .sum(ASR[4]), .cout(c5), .A(rRemainder[12]), .B(rDivisor[4]), .cin(c4), .AS(~add) );
addsub as5( .sum(ASR[5]), .cout(c6), .A(rRemainder[13]), .B(rDivisor[5]), .cin(c5), .AS(~add) );
addsub as6( .sum(ASR[6]), .cout(c7), .A(rRemainder[14]), .B(rDivisor[6]), .cin(c6), .AS(~add) );
addsub as7( .sum(ASR[7]), .cout(c8), .A(rRemainder[15]), .B(rDivisor[7]), .cin(c7), .AS(~add) );

// 16 Bit 3:1 Mux
// out, in10, in01, in11, sel
mux m00( .out(Mux[0]), .in10(dividendin[0]), .in01(rRemainder[0]), .in11(rRemainder[0]), .sel(sel));
mux m01( .out(Mux[1]), .in10(dividendin[1]), .in01(rRemainder[1]), .in11(rRemainder[1]), .sel(sel));
mux m02( .out(Mux[2]), .in10(dividendin[2]), .in01(rRemainder[2]), .in11(rRemainder[2]), .sel(sel));
mux m03( .out(Mux[3]), .in10(dividendin[3]), .in01(rRemainder[3]), .in11(rRemainder[3]), .sel(sel));
mux m04( .out(Mux[4]), .in10(dividendin[4]), .in01(rRemainder[4]), .in11(rRemainder[4]), .sel(sel));
mux m05( .out(Mux[5]), .in10(dividendin[5]), .in01(rRemainder[5]), .in11(rRemainder[5]), .sel(sel));
mux m06( .out(Mux[6]), .in10(dividendin[6]), .in01(rRemainder[6]), .in11(rRemainder[6]), .sel(sel));
mux m07( .out(Mux[7]), .in10(dividendin[7]), .in01(rRemainder[7]), .in11(rRemainder[7]), .sel(sel));

mux m08( .out(Mux[8]), .in10(1'b0), .in01(ASR[0]), .in11(rRemainder[8]), .sel(sel));
mux m09( .out(Mux[9]), .in10(1'b0), .in01(ASR[1]), .in11(rRemainder[9]), .sel(sel));
mux m10( .out(Mux[10]), .in10(1'b0), .in01(ASR[2]), .in11(rRemainder[10]), .sel(sel));
mux m11( .out(Mux[11]), .in10(1'b0), .in01(ASR[3]), .in11(rRemainder[11]), .sel(sel));
mux m12( .out(Mux[12]), .in10(1'b0), .in01(ASR[4]), .in11(rRemainder[12]), .sel(sel));
mux m13( .out(Mux[13]), .in10(1'b0), .in01(ASR[5]), .in11(rRemainder[13]), .sel(sel));
mux m14( .out(Mux[14]), .in10(1'b0), .in01(ASR[6]), .in11(rRemainder[14]), .sel(sel));
mux m15( .out(Mux[15]), .in10(1'b0), .in01(ASR[7]), .in11(rRemainder[15]), .sel(sel));

// 16 bit shift register
// out1,  in1,   in0,    shift
wire SNS16;
shifter s00( .out1(SNS[0]), .in1(Mux[0]), .in0(inbit), .shift(shift));
shifter s01( .out1(SNS[1]), .in1(Mux[1]), .in0(Mux[0]), .shift(shift));
shifter s02( .out1(SNS[2]), .in1(Mux[2]), .in0(Mux[1]), .shift(shift));
shifter s03( .out1(SNS[3]), .in1(Mux[3]), .in0(Mux[2]), .shift(shift));
shifter s04( .out1(SNS[4]), .in1(Mux[4]), .in0(Mux[3]), .shift(shift));
shifter s05( .out1(SNS[5]), .in1(Mux[5]), .in0(Mux[4]), .shift(shift));
shifter s06( .out1(SNS[6]), .in1(Mux[6]), .in0(Mux[5]), .shift(shift));
shifter s07( .out1(SNS[7]), .in1(Mux[7]), .in0(Mux[6]), .shift(shift));
shifter s08( .out1(SNS[8]), .in1(Mux[8]), .in0(Mux[7]), .shift(shift));
shifter s09( .out1(SNS[9]), .in1(Mux[9]), .in0(Mux[8]), .shift(shift));
shifter s10( .out1(SNS[10]), .in1(Mux[10]), .in0(Mux[9]), .shift(shift));
shifter s11( .out1(SNS[11]), .in1(Mux[11]), .in0(Mux[10]), .shift(shift));
shifter s12( .out1(SNS[12]), .in1(Mux[12]), .in0(Mux[11]), .shift(shift));
shifter s13( .out1(SNS[13]), .in1(Mux[13]), .in0(Mux[12]), .shift(shift));
shifter s14( .out1(SNS[14]), .in1(Mux[14]), .in0(Mux[13]), .shift(shift));
shifter s15( .out1(SNS[15]), .in1(Mux[15]), .in0(Mux[14]), .shift(shift));

// SNS to rRemainder
always @(posedge clk or posedge reset)
begin
  if (reset == 1'b1) begin
    rRemainder = 16'b0000000000000000;
  end
  else begin
    rRemainder <= SNS;
  end
end

// diagnostic only
//always @(rRemainder)
//begin
// $display("rRemainder (nege): %b", rRemainder);
//end

endmodule
