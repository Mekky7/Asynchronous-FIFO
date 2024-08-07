module FIFO_MEM_CNTRL (wdata,rdata,wCLKen,waddr
,CLK,raddr);
parameter FIFO_DEPTH=8;
parameter DATA_WIDTH=8;
parameter ADD_WIDTH=3;
input CLK,wCLKen;
input [ADD_WIDTH-1:0]raddr;
input [ADD_WIDTH-1:0]waddr;
input [DATA_WIDTH-1:0] wdata;
output  [DATA_WIDTH-1:0] rdata;
reg [FIFO_DEPTH-1:0] mem [DATA_WIDTH-1:0];
always @(posedge CLK) begin
if(wCLKen)
mem[waddr] <= wdata;    
end
assign rdata = mem[raddr];
endmodule