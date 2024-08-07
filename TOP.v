module TOP(W_CLK,W_RST,W_INC,
R_CLK,R_RST,R_INC,WR_DATA,RD_DATA,FULL,EMPTY
);
parameter FIFO_DEPTH=8;
parameter ADD_WIDTH=3;
parameter DATA_WIDTH=8;
input W_CLK,W_RST,W_INC;
input R_CLK,R_RST,R_INC;
input [DATA_WIDTH-1:0] WR_DATA;
output FULL,EMPTY;
output  [DATA_WIDTH-1:0] RD_DATA;
wire [ADD_WIDTH-1:0] waddr,raddr;
wire [ADD_WIDTH:0] wptr,rptr;
wire [ADD_WIDTH:0] wq2_rptr,rq2_wptr;
wire wCLKen;


FIFO_WR B0(
.wfull(FULL),.winc(W_INC),.waddr(waddr),.wptr(wptr),
.wclk(W_CLK),.wrst_n(W_RST),.wq2_rptr(wq2_rptr));

FIFO_RD B1 (.raddr(raddr),.rptr(rptr),.rq2_wptr(rq2_wptr),
.rrst_n(R_RST),.rclk(R_CLK),.rempty(EMPTY),.rinc(R_INC));

DF_SYNC B2(
.RST(R_RST),.CLK(R_CLK),.DATA_IN(wptr),
.SYNC_OUT(rq2_wptr)
);

DF_SYNC B3(
.RST(W_RST),.CLK(W_CLK),.DATA_IN(rptr)
,.SYNC_OUT(wq2_rptr)
);

FIFO_MEM_CNTRL B4 (.wdata(WR_DATA),.rdata(RD_DATA),
.wCLKen(wCLKen),.waddr(waddr)
,.CLK(W_CLK),.raddr(raddr));

and_inv B5 (.in(W_INC),.inv_in(FULL),.out(wCLKen));
endmodule