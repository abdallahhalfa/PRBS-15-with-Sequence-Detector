module seq_detect ( input clk,rst,
                    input [7:0] data_in,
                    input [1:0] n,
                    output reg data_flag);
                    
parameter sequence = 32'hCCDDEEFF;
localparam FIRST_BYTE=3'b000,SECOND_BYTE=3'b001,THIRD_BYTE=3'b010,FORTH_BYTE=3'b011,DONE=3'b100;
reg [2:0] current_state,next_state;
reg [31:0] seq_reg;
reg [2:0] done_count_reg,done_count;
always@(posedge clk, negedge rst)
  begin
    if(!rst)
      begin
        current_state<=FIRST_BYTE;
        seq_reg<=sequence;
        done_count_reg<=0;  
      end
    else
      begin
        current_state<=next_state;
        done_count_reg<= done_count;
        data_flag<=(current_state==DONE); 
      end
  end                    

always@(*)
  begin
    next_state=FIRST_BYTE;
    done_count=done_count_reg;
    case(current_state)
      FIRST_BYTE:
        begin
          if(data_in == seq_reg[31:24])
            begin
              next_state = SECOND_BYTE;
            end
          else
            begin
              next_state = FIRST_BYTE;
              done_count=0;
            end  
        end
      SECOND_BYTE:
        begin
          if(data_in == seq_reg[23:16])
            begin
              next_state = THIRD_BYTE;
            end
          else
            begin
              next_state = FIRST_BYTE;
              done_count=0;
            end  
        end
      THIRD_BYTE:
        begin
          if(data_in == seq_reg[15:8])
            begin
              next_state = FORTH_BYTE;
            end
          else
            begin
              next_state = FIRST_BYTE;
              done_count=0;
            end  
        end
      FORTH_BYTE:
        begin
          if(data_in == seq_reg[7:0])
            begin
              if(done_count==n-1)
                begin
                  next_state = DONE;
                end
              else
                begin
                  next_state = FIRST_BYTE;
                  done_count = done_count_reg+1;  
                end
            end
          else
            begin
              next_state = FIRST_BYTE;
              done_count=0;
            end  
        end
      DONE:
        begin
          next_state = DONE; 
        end
      default:
        begin
          next_state = FIRST_BYTE;  
        end
    endcase  
  

  end
endmodule