module FIFO_WR(
wfull,winc,waddr,wptr,wclk,wrst_n,wq2_rptr
);
parameter ADD_WIDTH=3;
input  winc,wclk,wrst_n;
input  [ADD_WIDTH:0] wq2_rptr;
output  [ADD_WIDTH-1:0] waddr;
output [ADD_WIDTH:0] wptr;
output reg wfull;
reg [ADD_WIDTH:0] binary_add;
///////B2G_conversion////////////////////
binary_to_gray #(.WIDTH(ADD_WIDTH+1)) converter_block  
(
    .binary(binary_add),  
     .gray(wptr)    
);
/////////////////////////////////////////////
always @(posedge wclk or negedge wrst_n ) begin
 if (! wrst_n) begin
     binary_add  <= 0;
     wfull <= 0;
 end else begin
    if (winc) begin
       binary_add <= binary_add + 1;  
    end
    wfull <=((wq2_rptr[ADD_WIDTH] != wptr[ADD_WIDTH])
    &(wptr[ADD_WIDTH-1:0]==wq2_rptr[ADD_WIDTH-1:0]));
 end   
end   
assign waddr =binary_add[ADD_WIDTH-1:0];
endmodule