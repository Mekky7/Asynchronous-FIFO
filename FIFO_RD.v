module FIFO_RD(raddr,rptr,rq2_wptr,rrst_n,rclk,rempty,rinc);
parameter ADD_WIDTH=3;
input  rinc,rclk,rrst_n;
input  [ADD_WIDTH:0] rq2_wptr;
output [ADD_WIDTH-1:0] raddr;
output [ADD_WIDTH:0] rptr;
output reg rempty;
reg [ADD_WIDTH:0] binary_add;
///////B2G_conversion////////////////////
binary_to_gray #(.WIDTH(ADD_WIDTH+1)) converter_block  
(
    .binary(binary_add),  
     .gray(rptr)    
);
/////////////////////////////////////////////
always @(posedge rclk or negedge rrst_n ) begin
 if (! rrst_n) begin
     binary_add  <= 0;
     rempty <= 1;
 end else begin
    if (rinc) begin
       binary_add <= binary_add + 1;  
    end
    rempty <= (rptr ==rq2_wptr);
 end   
end   
assign raddr =binary_add[ADD_WIDTH-1:0];
endmodule