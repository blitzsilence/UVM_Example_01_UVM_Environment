//`timescale 1ns/1ps

`include "uvm_macros.svh"
`include "env_pkg.sv"

import uvm_pkg::*;
import env_pkg::*;

`include "interface.sv"
`include "base_test.sv"
`include "my_case0.sv"
`include "my_case1.sv"

module tb_top;

	parameter simulation_cycle = 100;		// 100ns: clk=10MHz
	
	bit clk;
	logic rst_n;
	
	logic [7:0] rxd;
	logic rx_dv;
	logic [7:0] txd;
	logic tx_en;
	
	intf input_intf (clk, rst_n);
	intf output_intf (clk, rst_n);
	
	dut my_dut(.clk		(clk),
						.rst_n	(rst_n),
						.rxd		(input_intf.data),
						.rx_dv	(input_intf.valid),
						.txd		(output_intf.data),
						.tx_en	(output_intf.valid));
	
	// CLOCK generation
	initial begin
		clk = 0;
		forever
			#(simulation_cycle/2) clk = ~clk;	// 10MHz
	end
	
	// RESET trigger
	initial begin
		rst_n = 1'b0;
		#1000;
		rst_n = 1'b1;
	end
	
	// Configuration
	initial begin
		// Format of time display
		$timeformat(-9, 2, "ns", 10);
	 
		uvm_config_db #(virtual intf)::set(null, "uvm_test_top.env.i_agt.drv", "vif", input_intf);
		uvm_config_db #(virtual intf)::set(null, "uvm_test_top.env.i_agt.mon", "vif", input_intf);
		uvm_config_db #(virtual intf)::set(null, "uvm_test_top.env.o_agt.mon", "vif", output_intf);
	end
	
	initial begin
		run_test();
	end
	
	
	// Dump fsdb
	`ifdef DUMP_FSDB
	initial begin : FSDB_generation
		string testname;
		
		$display("DUMP FSDB START!");
		if ($value$plusargs("UVM_TESTNAME=%s", testname) && testname != "") begin
			$fsdbDumpfile({testname, "_sim_dir/", testname, ".fsdb"});
		end else begin
			$fsdbDumpfile("tb.fsdb");
		end
		
		$fsdbDumpvars(0, tb_top);
		$fsdbDumpvars(0, tb_top.my_dut);
	end
	`endif
	
endmodule