//
// EECE 479: Project Verilog File: mux.v
//
// Single Bit 3:1 Mux Cell
//
// Names:  Steve Novakovic, Marc Lejay
// Number:  13305081, 47593108
//

module mux( out,
            in10,
            in01,
            in11,
            sel);
output out;
input in10;
input in01;
input in11;
input[1:0] sel;

wire w10, w01, w11;

assign w10 = (sel[1] & (~sel[0]));
assign w01 = ((~sel[1]) & sel[0]);
assign w11 = sel[1] & sel[0];

assign out = (in10 & w10) | (in01 & w01) | (in11 & w11); 

endmodule
