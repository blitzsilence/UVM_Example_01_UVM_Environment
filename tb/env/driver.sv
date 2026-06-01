`ifndef MY_DRIVER__SV
`define MY_DRIVER__SV

class my_driver extends uvm_driver #(my_transaction);

	`uvm_component_utils(my_driver)
	
	virtual intf vif;
	
	function new (string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	extern virtual function void build_phase (uvm_phase phase);
	extern task run_phase (uvm_phase phase);
	extern task drive_one_pkt (my_transaction tr);
	
endclass


function void my_driver::build_phase (uvm_phase phase);
	super.build_phase(phase);
	
	if (!uvm_config_db #(virtual intf)::get(this, "", "vif", vif))
		`uvm_fatal("my_driver", "Virtual interface set failed!")
endfunction

task my_driver::run_phase (uvm_phase phase);
	vif.data 	<= 8'b0;
	vif.valid <= 1'b0;
	
	while (!vif.rst_n)
		@(posedge vif.clk);
		
	while(1) begin
		seq_item_port.get_next_item(req);
		drive_one_pkt(req);
		seq_item_port.item_done();
	end
endtask

task my_driver::drive_one_pkt (my_transaction tr);
	byte unsigned data_q[];
	int data_size;
	
	data_size = tr.pack_bytes(data_q) / 8; 
	`uvm_info("my_driver", "Begin to drive one pkt", UVM_LOW);
	
	repeat(3) @(posedge vif.clk);
	
	for (int i=0; i < data_size; i++) begin
		@(posedge vif.clk);
		vif.valid <= 1'b1;
		vif.data <= data_q[i];	
	end
	
	@(posedge vif.clk);
	vif.valid <= 1'b0;
	`uvm_info("my_driver", "Finshed", UVM_LOW);

endtask

`endif