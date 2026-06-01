`ifndef MY_CASE1__SV
`define MY_CASE1__SV

class case1_sequence extends my_sequence;
	
	`uvm_object_utils(case1_sequence)
	
	function new (string name = "case1_sequence");
		super.new(name);
	endfunction

	virtual task body ();
		my_transaction req;
	
		repeat (10) begin
			req = my_transaction::type_id::create("req");	
			start_item(req);
			if (!(req.randomize() with {pload.size() == 5;}))
				`uvm_fatal("Sequence", "Randomize Failed")
			finish_item(req);
		end
		
		#100;
	endtask

endclass

class my_case1 extends base_test;
	
	`uvm_component_utils(my_case1)
	
	function new (string name = "my_case1", uvm_component parent = null);
		super.new(name, parent);
	endfunction
	
	extern virtual task run_phase (uvm_phase phase);

endclass

task my_case1::run_phase (uvm_phase phase);
	case1_sequence seq;
	seq = case1_sequence::type_id::create("seq");	
	
	phase.raise_objection(this);
		
	if (env.i_agt.sqr == null)
		`uvm_fatal("my_case1", "Sequencer not exist!")
	else
		seq.start(env.i_agt.sqr);

	phase.drop_objection(this);
endtask

`endif