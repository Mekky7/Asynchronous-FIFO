`timescale 1ns/1ps
module TB();
parameter DATA_WIDTH=8;
reg W_CLK,W_RST,W_INC;
reg R_CLK,R_RST,R_INC;
reg  [DATA_WIDTH-1:0] WR_DATA;
wire FULL,EMPTY;
wire  [DATA_WIDTH-1:0] RD_DATA;    
integer  i;
integer read_index,write_index;
TOP DUT(W_CLK,W_RST,W_INC,R_CLK,
R_RST,R_INC,WR_DATA,RD_DATA,FULL,EMPTY);

reg test_failure;
reg [7:0] test_mem [9:0];
reg [7:0] ref_mem [9:0];
  initial begin
read_index=0;
write_index=0;
 for (i = 0; i <10 ; i = i + 1) begin
      ref_mem[i] = $random;
    end
  end
// Clock generation for write clock (100 MHz)
  initial begin
    W_CLK = 0;
    forever #5 W_CLK = ~W_CLK; 
  end
  
  // Clock generation for read clock (40 MHz)
  initial begin
    R_CLK = 0;
    forever #12.5 R_CLK = ~R_CLK; 
  end
///reading_block :  
initial begin  
 R_RST=0; //reset assertion ;
 repeat(2)@(negedge W_CLK); 
 R_RST=1;//reset deassertion ;
 forever begin
    @(negedge R_CLK);
   R_INC=0;
 if((!EMPTY)&&(read_index !=10))
 begin 
   R_INC=1;   
   test_mem[read_index]=RD_DATA;
   read_index =read_index+1;
 end 
 end
end
//writing block  :
initial begin
  W_RST=0; //reset assertion ;
 repeat(2)@(negedge W_CLK); 
 W_RST=1;//reset deassertion ;   
 forever begin
    @(negedge W_CLK);
   W_INC=0;
 if((!FULL)&&(write_index != 10))
 begin
    W_INC=1;
   WR_DATA=ref_mem[write_index];
   write_index =write_index+1;
 end 
 end
end
///////////////////////////
initial
begin
  test_failure=0;
    forever begin
#1;
if (read_index==10) begin
  for (i=0;i<=9;i=i+1)
  begin
    if (test_mem[i] != ref_mem [i]) begin
      test_failure = 1 ;
    end
  end
  if(test_failure)
  begin
    $display("error in test ");
    $stop ;
  end  
  else begin
    @(negedge R_CLK);
    $display("test done :)");
        $stop;
  end
end
    end
end
endmodule