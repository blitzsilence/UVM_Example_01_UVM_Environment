`ifndef MY_SCOREBOARD__SV
`define MY_SCOREBOARD__SV

class my_scoreboard extends uvm_scoreboard;
	
	`uvm_component_utils(my_scoreboard)
	
	local int compare_cnt = 0;
	local int success_cnt = 0;
	local int failure_cnt = 0;
	
	my_transaction expect_queue[$];
	
	uvm_blocking_get_port #(my_transaction) exp_port;	// from ref_model
	uvm_blocking_get_port #(my_transaction) act_port;	// from o_agt.mon
	
	function new (string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	extern virtual function void build_phase (uvm_phase phase);
	extern virtual task run_phase (uvm_phase phase);
	extern function void report_phase (uvm_phase phase);

endclass

function void my_scoreboard::build_phase (uvm_phase phase);
	super.build_phase(phase);
	
	exp_port = new("exp_port", this);
	act_port = new("act_port", this);
endfunction

task my_scoreboard::run_phase (uvm_phase phase);
	my_transaction expect_tr, actual_tr, temp_tr;
	bit result;
		
	fork
		while(1) begin
			exp_port.get(expect_tr);
			expect_queue.push_back(expect_tr);
		end
		
		while(1) begin
			act_port.get(actual_tr);
			
			if (expect_queue.size() > 0) begin
				temp_tr = expect_queue.pop_front();
				result = actual_tr.compare(temp_tr);
				compare_cnt++;
				
				if (result) begin
					success_cnt++;
					`uvm_info("my_scoreboard", "Compare SUCCESSFULLY", UVM_LOW)
				end
				else begin
					failure_cnt++;
					`uvm_error("my_scoreboard", "Compare FAILED");
					`uvm_info("TRACE", $sformatf("%m\nThe expect pkt is:\n%s", temp_tr.sprint()), UVM_HIGH)
					`uvm_info("TRACE", $sformatf("%m\nThe actual pkt is:\n%s", actual_tr.sprint()), UVM_HIGH)
				end
			end
			else begin
				`uvm_error("my_scoreboard", "Expect queue is empty")
				`uvm_info("TRACE", $sformatf("%m\nThe unexpected pkt is:\n%s", actual_tr.sprint()), UVM_HIGH)
			end
		end
	join_none
	
endtask

function void my_scoreboard::report_phase (uvm_phase phase);
	super.report_phase(phase);
	$display("Compare %0d times: %0d success and %0d failure.", compare_cnt, success_cnt, failure_cnt);
endfunction

`endif