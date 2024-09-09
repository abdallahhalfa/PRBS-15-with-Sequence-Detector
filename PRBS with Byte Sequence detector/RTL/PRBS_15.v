module PRBS_15 ( input clk,rst,
                 input [1:0] n,
                 input [7:0] data_in,
                 output reg [7:0] data_out);
reg [2:0] seq_count,seq2_count;
reg [31:0] seq_value;
reg [2:0] done_count;
reg [14:0] PRBS_SHIFTER;               
always@(posedge clk, negedge rst)
  begin
    if(!rst)
      begin
        data_out<=0;
        seq_count<=0;
        seq_value<=0;
        done_count<=0;
        seq2_count<=0;
        PRBS_SHIFTER<={15{1'b1}};
      end
    else if(seq_count != 4)
      begin
        data_out<=data_in;
        seq_value<={seq_value[23:0],data_in};
        seq_count<=seq_count+1;
      end
    else if(done_count == n-1)
      begin
        PRBS_SHIFTER<={PRBS_SHIFTER[13:0],PRBS_SHIFTER[14]^PRBS_SHIFTER[13]};
        data_out<={PRBS_SHIFTER[6:0],PRBS_SHIFTER[14]};
      end
    else
      begin
        if(seq2_count!=4)
          begin
            data_out<=seq_value[31:24];
            seq_value<={seq_value[23:0],seq_value[31:24]};
            seq2_count<=seq2_count+1;
          end
       else
         begin
           seq2_count<=0;
            done_count<=done_count+1;
      
  end
      end
  end
endmodule                 

