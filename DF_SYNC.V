module DF_SYNC(
RST,CLK,DATA_IN,SYNC_OUT
);
parameter DATA_WIDTH =4 ;
input RST,CLK;
input  [DATA_WIDTH-1:0] DATA_IN;
output reg [DATA_WIDTH-1:0] SYNC_OUT;
reg [DATA_WIDTH-1:0] temp ;
always @(posedge CLK or negedge RST ) begin
if (!RST) begin
    temp <= 0;
    SYNC_OUT <=0;
end else begin
    temp <= DATA_IN;
    SYNC_OUT <= temp;
end
end
endmodule