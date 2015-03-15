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

reg [1:0] curr_state;
reg [1:0] next_state;

reg loadr, addr, shiftr, inbitr, validr;
reg [1:0] selr;

assign load = loadr;
assign add = addr;
assign shift = shiftr;
assign inbit = inbitr;
assign valid = validr;
assign sel = selr;

// State X: load  sel shift inbit add
// State 00: 1    10  1     0     X
// State 01: 0    01  0     X     0
// State 10: 0    01  1     0     1
// State 11: 0    11  1     1     X

reg[3:0] counter;
reg increment;
always @(counter)
begin
  if (counter == 4'b1000)
    validr = 1'b1;
  else
    validr = 1'b0;
end

// diagnostic
always @(sign)
begin
  $display("SIGN %b", sign);
end

//
// NOTE:
// w/o clk sensitivity, the initialization then START case, where the state
// is 00 twice in a row would not work with a sensitivity list based on the state
// To get around this, we use posedge clk for curr <- next assignment and negedge clk
// for next evaluation.
//
always @(posedge start or negedge clk)  
begin
  $display("START %b", start);
  if (start == 1'b1) begin
    next_state = 2'b00;
  end
  else begin
    case (curr_state) 
       2'b00:  next_state = 2'b01; 
       2'b01:  begin
                case(sign)
                  1'b1:   next_state = 2'b10;
                  1'b0:   next_state = 2'b11;
                endcase
                increment = 1'b0;
               end
       2'b10:  begin
                  next_state = 2'b01;
                  increment = 1'b1;
               end
       2'b11:  begin
                  next_state = 2'b01;
                  increment = 1'b1;
               end
       default: $display("ERROR IN CURR_STATE %b", curr_state);
    endcase
  end
end

always @(curr_state) 
begin
   case (curr_state) 
      2'b00:  begin
                loadr = 1'b1;
                selr = 2'b10;
                shiftr = 1'b1;
                inbitr = 1'b0;
              end
      2'b01:  begin
                loadr = 1'b0;
                selr = 2'b01;
                shiftr = 1'b0;
                addr = 1'b0;
              end
      2'b10:  begin
                loadr = 1'b0;
                selr = 2'b01;
                shiftr = 1'b1;
                inbitr = 1'b0;
                addr = 1'b1;
              end
      2'b11:  begin
                loadr = 1'b0;
                selr = 2'b11;
                shiftr = 1'b1;
                inbitr = 1'b1;
              end
   endcase
end

always @(posedge clk or posedge reset)
begin
	if (reset == 1'b1) begin
		curr_state <= 2'b00;
		counter <= 4'b0000;
		increment <= 1'b0;
	end
	else begin
		curr_state <= next_state;
		counter <= counter + increment;
  end
end

// diagnostic
always@(negedge clk)
begin
  $display("CURSTATE: %b", curr_state);
  $display("NXTSTATE: %b", next_state);
end

endmodule




