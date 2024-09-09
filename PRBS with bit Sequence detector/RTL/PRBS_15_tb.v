module PRBS_15_tb  ; 
 
  reg  [7:0]  data_in   ; 
  wire   data_out   ; 
  reg    rst   ; 
  wire  [7:0]  data_random   ; 
  reg  [2:0]  n   ; 
  reg    clk   ; 
  PRBS_15  
   DUT  ( 
       .data_in (data_in ) ,
      .data_out (data_out ) ,
      .rst (rst ) ,
      .data_random (data_random ) ,
      .n (n ) ,
      .clk (clk ) ); 

parameter T_period=10;

initial
  begin
    clk=0;
    n=2;
    forever #(T_period/2) clk=~clk;
  end

initial
  begin
    rst=0;
    @(negedge clk)
    rst=1;
    data_in = 8'hCC;
    @(negedge clk)
    data_in = 8'hDD;
    @(negedge clk)
    data_in = 8'hEE;
    @(negedge clk)
    data_in = 8'hFF;
    #(T_period*100)
    $stop;  
  end
endmodule

