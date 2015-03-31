//
// EECE 479: Project Verilog File: addsub.v
//
// Single Addition/Subtraction Cell
//
// Names:  Steve Novakovic, Marc Lejay
// Number:  13305081, 47593108
//

module addsub( sum,
               cout,
               A,
               B,
               cin,
               AS); // ~AS = add, AS = subtract
                
output sum;
output cout;
input A;
input B;
input cin;
input AS;

wire coutb;
assign cout = ~coutb;

wire Bx;
assign Bx = B ^ AS;

wire sumb;
assign sum = ~sumb;

assign coutb = ~((cin & (A | Bx)) | (A & Bx));

assign sumb = ~((A & Bx & cin) | (coutb & (A | Bx | cin)));

endmodule
