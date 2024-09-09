module pattern_detect ( input clk,rst,
			input data,
			input [2:0] n,
			output data_flag);

localparam IDLE=4'b0000,FIRST_ONE=4'b0001,SECOND_ONE=4'b0010,STATE_CD=4'b0011,STATE_C=4'b0100,STATE_D=4'b0101,STATE_EF=4'b0110,STATE_E=4'b0111,STATE_F=4'b1000,DONE=4'b1001;
reg [3:0] current_state,next_state;
reg [2:0] byte_counter,byte_counter_comp;
reg [3:0] done_counter;
wire last_bit_byte;
wire first_half,second_half;
always@(posedge clk, negedge rst)
	begin
	 if(!rst)
	   begin
	    current_state<=IDLE;
	    byte_counter<=0;
	    done_counter<=0;
	   end
	 else
	   begin
	     current_state<=next_state;
	     if(byte_counter==7&&last_bit_byte)
	       begin
	         done_counter<=done_counter+1;
	       end
	      else
	        begin
	         byte_counter<=byte_counter_comp;
	        end
	   end
	end

always@(*)
  begin
    byte_counter_comp=byte_counter;
    case(current_state)
      IDLE:
        begin
          byte_counter_comp=0;
          if(data)
            begin
              next_state=FIRST_ONE;
            end
          else
            begin
              next_state=IDLE;
            end
        end
      FIRST_ONE:
        begin
          if(data)
            begin
              next_state=SECOND_ONE;
            end
          else
            begin
              next_state=IDLE;
            end
        end
      SECOND_ONE:
        begin
          if(!data && second_half)
            begin
              next_state=STATE_CD;
              byte_counter_comp=0;
           
end
        
 else if(data && first_half)
        
   begin
    
         next_state= SECOND_ONE;
  
          byte_counter_comp=0;
      
     end
    
     else
            begin
              if(data)
                begin
                  next_state=STATE_EF;
                end
              else
                begin
                  next_state=STATE_CD;
                end
            end
        end
      STATE_CD:
        begin
          if(!data && (byte_counter == 3'b000 || byte_counter == 3'b001))
            begin
              next_state=STATE_C;
            end
          else if(data && (byte_counter == 3'b010 || byte_counter == 3'b011))
            begin
              next_state=STATE_D;
            end
          else
            begin
              if(data)
                begin
                  next_state=FIRST_ONE;
                  byte_counter_comp=0;
                end
              else
                begin
                  next_state=STATE_C;
                  byte_counter_comp=0;
                end
            end
        end
      STATE_C:
        begin
          if(data)
            begin
              next_state=FIRST_ONE;
              byte_counter_comp=byte_counter+1;
            end
          else
            begin
              next_state=IDLE;
            end
        end
      STATE_D:
        begin
          if(data)
            begin
              next_state=FIRST_ONE;
              byte_counter_comp=byte_counter+1;
            end
          else
            begin
              next_state=IDLE;
            end
        end
      STATE_EF:
        begin
          if(!data && (byte_counter == 3'b100 || byte_counter == 3'b101))
            begin
              next_state=STATE_E;
            end
          else if(data && (byte_counter == 3'b110 || byte_counter == 3'b111))
            begin
              next_state=STATE_F;
            end
          else
            begin
              if(data)
                begin
                  next_state=SECOND_ONE;
                  byte_counter_comp=0;
                end
              else
                begin
                  next_state=STATE_CD;
                  byte_counter_comp=0;
                end
            end
        end
      STATE_E:
        begin
          if(data)
            begin
              next_state=FIRST_ONE;
              byte_counter_comp=byte_counter+1;
            end
          else
            begin
              next_state=IDLE;
            end
        end
      STATE_F:
        begin
          if(done_counter==n)
            begin
              next_state=DONE;
            end
          else
            begin
              if(data)
                begin
                  next_state=FIRST_ONE;
                  byte_counter_comp=byte_counter+1;
                end
              else
                begin
                  next_state=IDLE;
                end
            end
        end
      DONE:
        begin
          next_state=current_state;
        end
      default:
        begin
          next_state=IDLE;
        end
    endcase
  end
assign data_flag=(next_state==DONE);
assign first_half = byte_counter == 3'b000 || byte_counter == 3'b001 || byte_counter == 3'b010 || byte_counter == 3'b011;
assign second_half = byte_counter == 3'b100 || byte_counter == 3'b101 || byte_counter == 3'b110 || byte_counter == 3'b111;
assign last_bit_byte = (current_state==STATE_EF);
endmodule




 			
