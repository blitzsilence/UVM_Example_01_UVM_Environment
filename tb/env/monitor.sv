`ifndef MY_MONITOR__SV
`define MY_MONITOR__SV

class my_monitor extends uvm_monitor;
	
	`uvm_component_utils(my_monitor)
	
	virtual intf vif;
	uvm_analysis_port #(my_transaction) ap;
	
	function new (string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	extern virtual function void build_phase (uvm_phase phase);
	extern task run_phase (uvm_phase phase);
	extern task collect_one_pkt (my_transaction tr);

endclass

function void my_monitor::build_phase (uvm_phase phase);
	super.build_phase(phase);
	
	if (!uvm_config_db #(virtual intf)::get(this, "", "vif", vif))
		`uvm_fatal("my_monitor", "Virtual interface set failed!")
		
	ap = new("ap", this);
endfunction

task my_monitor::run_phase (uvm_phase phase);
	my_transaction tr;
	
	while(1) begin
		tr = new("tr");
		collect_one_pkt(tr);
		ap.write(tr);
	end
endtask

task my_monitor::collect_one_pkt (my_transaction tr);
	byte unsigned data_q[$];	
	byte unsigned data_array[];	
	
	logic [7:0] data;
	logic valid = 0;
	int data_size;
	
	while(1) begin
		@(posedge vif.clk);
		if (vif.valid) break; 
	end
	
	`uvm_info("my_monitor", "Begin to collect one pkt", UVM_LOW)
	
	while(vif.valid) begin
		data_q.push_back(vif.data);
		@(posedge vif.clk);
	end
	
	data_size = data_q.size();
	data_array = new[data_size];
	
	for (int i=0; i < data_size; i++) begin
		data_array[i] = data_q[i];
	end
	
	tr.pload = new[data_size - 18]; 
	data_size = tr.unpack_bytes(data_array) / 8;
	
	`uvm_info("my_monitor", "Finished", UVM_LOW)
endtask

`endif