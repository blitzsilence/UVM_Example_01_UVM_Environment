`ifndef MY_SEQUENCE__SV
`define MY_SEQUENCE__SV

class my_sequence extends uvm_sequence #(my_transaction);
	
	`uvm_object_utils(my_sequence)
	
	my_transaction req;
	
	function new (string name = "my_sequence");
		super.new(name);
	endfunction

	virtual task body ();
		repeat (5) begin
			`uvm_do(req);
		end
		
		#100;
	endtask

endclass

`endif