module top_module ( input clk,rst,
                    output [3:0] DONE_VALUE////outputs E on the fpga leds
                    );
wire data_out;


pattern_detect pat_det ( .clk(clk),.rst(rst),.data(data_out),.DONE_VALUE(DONE_VALUE));
PRBS_15 PRBS( .clk(clk),.rst(rst),.data_out(data_out));

endmodule