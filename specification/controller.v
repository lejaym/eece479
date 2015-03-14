//
// EECE 479: Project Verilog File: controller.v
//
// This is the stub for the controller block.  Please start with this
// template when writing your Verilog code.
//
// Names:  Steve Novakovic, Marc Lejay
// Number:  13305081
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

always @(curr_state or sign or start)  
begin
  if (start) begin
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

always @(posedge clk or negedge reset)
	if (reset == 1'b0) begin
		curr_state <= 2'b00;
		counter <= 4'b0000;
		increment <= 1'b0;
	end
	else begin
		curr_state <= next_state;
		counter <= counter + increment;
  end
endmodule
