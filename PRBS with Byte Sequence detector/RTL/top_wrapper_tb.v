module top_wrapper_tb  ; 
 
  reg  [7:0]  data_in   ; 
  wire  [7:0]  data_out   ; 
  reg    rst   ; 
  reg  [1:0]  n   ; 
  reg    clk   ; 
  wire    data_flag   ; 
  top_wrapper  
   DUT  ( 
       .data_in (data_in ) ,
      .data_out (data_out ) ,
      .rst (rst ) ,
      .n (n ) ,
      .clk (clk ) ,
      .data_flag (data_flag ) ); 

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
    #(T_period*40)
    $stop;  
  end
endmodule

