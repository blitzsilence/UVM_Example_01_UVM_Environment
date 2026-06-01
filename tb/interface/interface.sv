`ifndef MY_INTERFACE__SV
`define MY_INTERFACE__SV

interface intf (input clk, input rst_n);

	logic [7:0] data;
	logic valid;
	
endinterface

`endif