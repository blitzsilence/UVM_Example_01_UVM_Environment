`ifndef BASE_TEST__SV
`define BASE_TEST__SV

class base_test extends uvm_test;
	
	`uvm_component_utils(base_test)
	
	my_env env;
	
	function new (string name = "base_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction
	
	extern virtual function void build_phase (uvm_phase phase);	
	extern virtual function void end_of_elaboration_phase( uvm_phase phase);
	extern virtual function void report_phase (uvm_phase phase);

endclass

function void base_test::build_phase (uvm_phase phase);
	super.build_phase(phase);
	
	`uvm_info("base_test", "Build_phase", UVM_LOW);
	
	env = my_env::type_id::create("env", this);	
endfunction

function void base_test::end_of_elaboration_phase (uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
endfunction

function void base_test::report_phase (uvm_phase phase);
	uvm_report_server server;
	int err_num;
	string testname;
	
	super.report_phase(phase);
	
	$value$plusargs("UVM_TESTNAME=%s", testname);
	
	server = get_report_server();
	err_num = server.get_severity_count(UVM_ERROR);
	
	if (err_num != 0) begin
			$display("==================================================");
			$display("%s testcase Failed!", testname);
			$display("==================================================");
	end
	else begin
			$display("==================================================");
			$display("%s testcase Passed!", testname);
			$display("==================================================");
	end
	
endfunction

`endif