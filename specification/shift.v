//
// EECE 479: Project Verilog File: shift.v
//
// Single Bit Shift Register
//
// Names:  Steve Novakovic, Marc Lejay
// Number:  13305081, 47593108
//

module shifter(  out1,
                 in1,
                 in0,
                 shift);
output out1;
input in1;
input in0;
input shift;

assign out1 = ((~shift) & in1) | (shift & in0);

endmodule
