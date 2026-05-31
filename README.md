# UVM_Example_01_Simple_UVM_Environment

#### Intro
參考書籍 張強 《UVM实战》第二章，建立一個完整的UVM測試平台

在testcase中，使用兩種方式來啟動sequence
1. my_case0: 使用default sequence，在sqr main_phase中啟動 sequence
2. my_case1: 使用seq.start()，手動啟動sqr

#### Verification Environment
```
    Project
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


