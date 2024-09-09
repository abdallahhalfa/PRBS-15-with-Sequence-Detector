module pattern_detect_tb  ; 

parameter STATE_D  = 4'b0101 ;
parameter STATE_E  = 4'b0111 ;
parameter SECOND_ONE  = 4'b0010 ;
parameter FIRST_ONE  = 4'b0001 ;
parameter DONE  = 4'b1001 ;
parameter STATE_F  = 4'b1000 ;
parameter IDLE  = 4'b0000 ;
parameter STATE_EF  = 4'b0110 ;
parameter STATE_C  = 4'b0100 ;
parameter STATE_CD  = 4'b0011 ; 
  reg    rst   ; 
  reg  [2:0]  n   ; 
  reg    data   ; 
  reg    clk   ; 
  wire    data_flag   ; 
  pattern_detect    
   DUT  ( 
       .rst (rst ) ,
      .n (n ) ,
      .data (data ) ,
      .clk (clk ) ,
      .data_flag (data_flag ) ); 

parameter T_period = 10;
integer i;
reg [63:0] arr2;
initial
  begin
    clk=0;
    n=1;
    data=0;
    //arr2=48'hCCDDCCDDEEFF; //second_one_state then error so go to state_cd and continue
    //arr2=40'hCCCCDDEEFF; //state_cd then error so go to state_c and continue
    arr2=64'hCCDDEEEFCCDDEEFF;
    //arr2=64'hCCDDEEFF_CCDDEEFF;
    forever #(T_period/2) clk=~clk;
  end    

initial
  begin
   reset();
   for(i=0;i<65;i=i+1)
   begin
   {data,arr2}= arr2<<1;
   @(negedge clk);
   end
   #(T_period*2)
   $stop;
  end
initial
  begin
    $monitor("data %0b",data);
  end
task reset;
  begin
    rst=0;
    @(negedge clk)
    rst=1;
  end
endtask
endmodule

