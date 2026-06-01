module dut(
	input 	logic 			clk,
	input 	logic 			rst_n,
	input 	logic [7:0] rxd,
	input 	logic 			rx_dv,
	output 	logic [7:0] txd,
	output 	logic				tx_en
);
	
	always_ff @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			txd 	<= '0;
			tx_en <= 1'b0;
		end
		else begin
			txd 	<= rxd;
			tx_en <= rx_dv;
		end	
	end

endmodule