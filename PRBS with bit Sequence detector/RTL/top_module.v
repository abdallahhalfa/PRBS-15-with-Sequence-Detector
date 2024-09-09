module top_module ( input clk,rst,
                    input [7:0] data_in,
                    input [2:0] n,
                    output [7:0] data_random,
                    output data_flag);
                    
pattern_detect pat_det ( .clk(clk),.rst(rst),.data(data_out),.n(n),.data_flag(data_flag));
PRBS_15 PRBS( .clk(clk),.rst(rst),.n(n),.data_in(data_in),.data_out(data_out),.data_random(data_random));

endmodule