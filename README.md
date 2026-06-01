# UVM_Example_Simple_UVM_Environment

## Intro
參考書籍 張強 《UVM实战》第二章，建立一個完整的UVM測試平台

在testcase中，使用兩種方式來啟動sequence
my_case0: 使用default sequence，在sqr main_phase中啟動 sequence
my_case1: 使用seq.start()，手動啟動sqr

## Verification Environment
```
    Project_root
    │
    ├── README.md
    │    
    ├── doc
    │   └── xxxx
    │
    ├── rtl
    │   └── dut.sv
    │
    ├── sim
    │   ├── Makefile
    │   └── runlist
    │ 
    └── tb
        ├── env
        │   ├── agent.sv
        │   ├── env.sv
        │   ├── monitor.sv
        │   ├── ref_model.sv
        │   ├── scoreboard.sv
        │   ├── sequencer.sv
        │   ├── sequencer.sv
        │   └── transaction.sv
        │ 
        ├── interface
        │   └── interface.sv
        │
        ├── package
        │   └── env_pkg.sv
        │ 
        ├── testcase
        │   ├── base_test.sv
        │   ├── my_case1.sv
        │   └── my_case1.sv
        │        
        └── top
            ├── tb_top.sv
            ├── rtl.f
            └── tb.f
```

## Makefile excution
make comp 

make all TESTNAME=basetest

make sim TESTNAME=my_case0

make sim TESTNAME=my_case1


## UVM testbench topology
```
------------------------------------------------------------------
Name                       Type                        Size  Value
------------------------------------------------------------------
uvm_test_top               base_test                   -     @462 
  env                      my_env                      -     @470 
    i_agt                  my_agent                    -     @478 
      drv                  my_driver                   -     @673 
        rsp_port           uvm_analysis_port           -     @690 
        seq_item_port      uvm_seq_item_pull_port      -     @681 
      mon                  my_monitor                  -     @822 
        ap                 uvm_analysis_port           -     @832 
      sqr                  my_sequencer                -     @699 
        rsp_export         uvm_analysis_export         -     @707 
        seq_item_export    uvm_seq_item_pull_imp       -     @813 
        arbitration_queue  array                       0     -    
        lock_queue         array                       0     -    
        num_last_reqs      integral                    32    'd1  
        num_last_rsps      integral                    32    'd1  
    i_agt_mdl_fifo         uvm_tlm_analysis_fifo #(T)  -     @510 
      analysis_export      uvm_analysis_imp            -     @554 
      get_ap               uvm_analysis_port           -     @545 
      get_peek_export      uvm_get_peek_imp            -     @527 
      put_ap               uvm_analysis_port           -     @536 
      put_export           uvm_put_imp                 -     @518 
    mdl                    my_model                    -     @494 
      ap                   uvm_analysis_port           -     @850 
      port                 uvm_blocking_get_port       -     @841 
    mdl_scb_fifo           uvm_tlm_analysis_fifo #(T)  -     @563 
      analysis_export      uvm_analysis_imp            -     @607 
      get_ap               uvm_analysis_port           -     @598 
      get_peek_export      uvm_get_peek_imp            -     @580 
      put_ap               uvm_analysis_port           -     @589 
      put_export           uvm_put_imp                 -     @571 
    o_agt                  my_agent                    -     @486 
      mon                  my_monitor                  -     @863 
        ap                 uvm_analysis_port           -     @872 
    o_agt_scb_fifo         uvm_tlm_analysis_fifo #(T)  -     @616 
      analysis_export      uvm_analysis_imp            -     @660 
      get_ap               uvm_analysis_port           -     @651 
      get_peek_export      uvm_get_peek_imp            -     @633 
      put_ap               uvm_analysis_port           -     @642 
      put_export           uvm_put_imp                 -     @624 
    scb                    my_scoreboard               -     @502 
      act_port             uvm_blocking_get_port       -     @890 
      exp_port             uvm_blocking_get_port       -     @881 
------------------------------------------------------------------
```

