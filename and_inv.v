module and_inv (in,inv_in,out);
 input in,inv_in;
 output out;
 assign out =(!inv_in) & in ;   
endmodule