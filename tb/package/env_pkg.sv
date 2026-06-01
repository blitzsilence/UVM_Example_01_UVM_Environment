`ifndef ENV_PKG__SV
`define ENV_PKG__SV

package env_pkg;
    import uvm_pkg::*;
		`include "uvm_macros.svh"
		
    `include "transaction.sv"
    `include "sequence.sv"
    `include "sequencer.sv"
    `include "driver.sv"
    `include "monitor.sv"
    `include "agent.sv"
    `include "scoreboard.sv"
    `include "ref_model.sv"
    `include "env.sv"
endpackage

`endif