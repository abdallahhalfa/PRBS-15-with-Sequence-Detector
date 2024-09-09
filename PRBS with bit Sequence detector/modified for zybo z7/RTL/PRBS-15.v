module PRBS_15 ( input clk,rst,
                 output reg data_out
                 );
parameter seq =32'hCCDDEEFF,n=2;
reg [31:0] sequence;
reg [2:0] seq_counter;
reg [2:0] n_counter;
reg [14:0] prbs_shifter;
reg [4:0] bit_counter;
reg [7:0] data_random;
always@(posedge clk, negedge rst)
  begin
    if(!rst)
      begin
        data_out<=0;
        seq_counter<=0;
        sequence<=seq;
        n_counter<=0;
        data_random<=0;
        bit_counter<=0;
        prbs_shifter<={15{1'b1}};
      end
    else
      begin
            if(n_counter!=n)
              begin
                data_out<=sequence[31];
                sequence<={sequence[30:0],sequence[31]};
                if(bit_counter==31)
                  begin
                    n_counter<=n_counter+1;
                    bit_counter<=bit_counter+1;
                  end
                else
                  begin
                    bit_counter<=bit_counter+1;  
                  end
              end
            else
              begin
                prbs_shifter<={prbs_shifter[13:0],prbs_shifter[13]^prbs_shifter[14]};
                data_random<={prbs_shifter[7:0],prbs_shifter[14]};
              end
      end
  end
endmodule