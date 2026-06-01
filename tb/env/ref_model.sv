`ifndef REF_MODEL__SV
`define REF_MODEL__SV

class my_model extends uvm_component;
	
	`uvm_component_utils(my_model)
	
	uvm_blocking_get_port #(my_transaction) port;	
	uvm_analysis_port #(my_transaction) ap;
	
	function new (string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	extern function void build_phase (uvm_phase phase);
	extern virtual task run_phase (uvm_phase phase);

endclass

function void my_model::build_phase (uvm_phase phase);
	super.build_phase(phase);
	
	port = new("port", this);
	ap = new("ap", this);
endfunction

task my_model::run_phase (uvm_phase phase);
	my_transaction tr, new_tr;
		
	forever begin
		port.get(tr);
		new_tr = new("new_tr");
		new_tr.copy(tr);
		`uvm_info("my_model", "Get one transaction, copy and print it:", UVM_LOW)
		new_tr.print();
		ap.write(new_tr);
	end
endtask

`endif