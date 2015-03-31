//
// EECE 479: Project Verilog File: controller.v
//
// This is the stub for the controller block.  Please start with this
// template when writing your Verilog code.
//
// Names:  Steve Novakovic, Marc Lejay
// Number:  13305081, 47593108
//

module controller(load,
                   add,
                   shift,
                   inbit,
                   sel,
		               valid,
                   start,
                   sign, 
                   clk,
                   reset);
output load;
output add;
output shift;
output inbit;
output [1:0] sel;
output valid;   
input start;
input sign;
input clk;
input reset;

// SB current/next
reg [1:0] SBc;
wire [1:0] SBn;
wire SBand, SBnor;
wire ctrl0, ctrl1;

assign SBand = SBc[0] & SBc[1];
assign SBnor = ~(SBc[0] | SBc[1]);

assign SBn[0] = (~start) & ((~(ctrl0 | SBand)) | SBand);
assign SBn[1] = (~start) & ((~(ctrl1 | SBand)) | SBand);

assign ctrl0 = (SBnor)&(~sign);
assign ctrl1 = (SBnor)&sign;

assign add = SBc[1] & (~SBc[0]);
assign load = SBc[1] & SBc[0];
assign shift = SBc[1] | SBc[0];
assign inbit = (~SBc[1]) & SBc[0];

assign sel[1] = SBc[0];
assign sel[0] = ~(SBc[0] & SBc[1]);

always @(posedge clk or posedge reset)
begin
  if (reset == 1'b1) begin
    SBc = 2'b00;
  end
  else begin
    SBc <= ~SBn;
  end  
end

// diagnostic only
//always @(SBc or SBn)
//begin
//  $display("SBc, SBn: %b  %b", SBc, ~SBn);
//end

endmodule




