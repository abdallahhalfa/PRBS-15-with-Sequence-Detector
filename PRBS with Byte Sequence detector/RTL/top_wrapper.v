module top_wrapper ( input clk,rst,
                     input [7:0] data_in,
                     input [1:0] n,
                     output [7:0] data_out,
                     output data_flag);
                     
PRBS_15 PRBS(  .clk(clk),.rst(rst),
               .n(n),.data_in(data_in),
               .data_out(data_out));

seq_detect SEQ( .clk(clk),.rst(rst),
                .n(n),.data_in(data_out),
                .data_flag(data_flag));     

endmodule
