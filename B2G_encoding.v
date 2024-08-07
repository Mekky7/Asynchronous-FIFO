module binary_to_gray #(parameter WIDTH = 4) (
    input [WIDTH-1:0] binary,  
    output [WIDTH-1:0] gray    
);
genvar i;
generate
    for (i = 0; i < WIDTH; i = i + 1) begin : gen_gray
        if (i == WIDTH-1) begin
            assign gray[i] = binary[i];  
        end else begin
            assign gray[i] = binary[i+1] ^ binary[i];  
        end
    end
endgenerate

endmodule
