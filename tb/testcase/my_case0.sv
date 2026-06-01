`ifndef MY_CASE0__SV
`define MY_CASE0__SV

class case0_sequence extends my_sequence;
	
	`uvm_object_utils(case0_sequence)

	function new (string name = "case0_sequence");
		super.new(name);
	endfunction

	virtual task body ();
		my_transaction req;
	
		if (starting_phase != null)
			starting_phase.raise_objection(this);
			
		repeat (10) begin
			`uvm_do_with(req, {pload.size() == 5;})
		end
		
		#100;
		
		if (starting_phase != null)
			starting_phase.drop_objection(this);
	endtask

endclass


class my_case0 extends base_test;
	
	`uvm_component_utils(my_case0)
	
	function new (string name = "my_case0", uvm_component parent = null);
		super.new(name, parent);
	endfunction
	
	extern virtual function void build_phase (uvm_phase phase);

endclass

function void my_case0::build_phase (uvm_phase phase);
	super.build_phase(phase);
	
	uvm_config_db #(uvm_object_wrapper)::set(this, 
											"env.i_agt.sqr.main_phase",
											"default_sequence",
											case0_sequence::type_id::get());
endfunction

`endif