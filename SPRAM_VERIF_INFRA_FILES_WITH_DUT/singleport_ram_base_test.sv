////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : singleport_ram_base_test.sv 
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : This base test will run 3-sequences that is reset seq, write only and read only seq
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SINGLEPORT_RAM_BASE_TEST_SV
`define GUARD_SINGLEPORT_RAM_BASE_TEST_SV

class singleport_ram_base_test extends uvm_test;

    `uvm_component_utils(singleport_ram_base_test)
     
     singleport_ram_env env_h;
     int file_h;
  
     singleport_ram_reset_sequence       rst_seq;
     singleport_ram_write_only_sequence  write_seq;
     singleport_ram_read_only_sequence   read_seq;
       
      //Constructor: new   
     extern function new(string name = "singleport_ram_base_test",uvm_component parent);
   
     //Function: build_phase
     extern function void build_phase(uvm_phase phase);
      
     //Function: connect_phase
     extern function void connect_phase(uvm_phase phase);  
    
     //Function: end_of_elaboration_phase
     extern function void end_of_elaboration_phase(uvm_phase phase);
     
     //Function: start_of_simulation_phase  
     extern function void start_of_simulation_phase(uvm_phase phase);  
    
     //Task: run_phase
     extern task run_phase(uvm_phase phase);
      
     //Function: report_phase
     extern function void report_phase(uvm_phase phase);
      
     //Function: final_phase  
     extern function void final_phase(uvm_phase phase);  
    
endclass:singleport_ram_base_test

//===================================================================================
// New
//===================================================================================
function singleport_ram_base_test::new(string name="singleport_ram_base_test",uvm_component parent);
	super.new(name,parent);
endfunction:new

//===================================================================================
// build_phase
//===================================================================================
function void singleport_ram_base_test::build_phase(uvm_phase phase);
  
      super.build_phase(phase);
      env_h     = singleport_ram_env::type_id::create("env_h",this);

endfunction :build_phase
       
//===================================================================================
// connect_phase
//===================================================================================
      
function void singleport_ram_base_test::connect_phase(uvm_phase phase); 
    string _name = "connect_phase";
   `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_FULL);
    super.connect_phase(phase);
  
    uvm_top.print_topology();
   `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_FULL);
  
endfunction: connect_phase       

//===================================================================================
// end_of_elaboration_phase
//===================================================================================       

function void singleport_ram_base_test::end_of_elaboration_phase(uvm_phase phase);
     super.end_of_elaboration_phase(phase);
     uvm_top.print_topology();
endfunction: end_of_elaboration_phase 
       
       
//===================================================================================
// start_of_simulation_phase
//===================================================================================
function void singleport_ram_base_test::start_of_simulation_phase(uvm_phase phase);
  
    string _name = "start_of_simulation_phase";
   `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_FULL);

    super.start_of_simulation_phase(phase);

   `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_FULL);
  
endfunction : start_of_simulation_phase 
       
/*function void singleport_ram_base_test::start_of_simulation_phase(uvm_phase phase);
      $display("start_of_simulation_phase");
      file_h=$fopen("LOG_FILE.log","w");
      set_report_default_file_hier(file_h);
      set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY+UVM_LOG);
      env_h.set_report_verbosity_level_hier(UVM_LOW);  
      print();  //prints topology
endfunction	*/
    
//===================================================================================
// run_phase
//=================================================================================== 
task singleport_ram_base_test::run_phase(uvm_phase phase);
  
      string _name = "run_phase";
      `uvm_info({get_type_name(),"_",_name}, $sformatf("Started Running the Test"), UVM_NONE);
 
      phase.raise_objection(this);
  
      // Check and validate the sequencer handle
      if (env_h.agent_h.sequencer_h == null) begin 
         `uvm_fatal(get_type_name(), "Sequencer handle is null");  
      end
  
      // Create the sequence object
      rst_seq   = singleport_ram_reset_sequence::type_id::create("rst_seq");
	  write_seq = singleport_ram_write_only_sequence::type_id::create("write_seq");
      read_seq  = singleport_ram_read_only_sequence::type_id::create("resd_seq");
  
      // Ensure the sequence is started with a valid sequencer handle
      rst_seq.start(env_h.agent_h.sequencer_h); 
      read_seq.start(env_h.agent_h.sequencer_h);
      write_seq.start(env_h.agent_h.sequencer_h);
      read_seq.start(env_h.agent_h.sequencer_h);
  
      // Wait for 100 time units
      #100;
      phase.drop_objection(this); // Drop the objection to allow the phase to end
  
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended Running the Test"), UVM_NONE);
  
endtask :run_phase 
       
//===================================================================================
// report_phase
//===================================================================================
function void singleport_ram_base_test::report_phase(uvm_phase phase);
    string _name = "report_phase";
    int err_cnt;
    //uvm_default_report_server foo ;
    uvm_report_server foo ;
    //int err_cnt ;
    
   `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_NONE);
    $cast(foo,uvm_top.get_report_server());

    // sum num of errors from sequences (use global report server)
    err_cnt = foo.get_severity_count(UVM_ERROR) + foo.get_severity_count(UVM_FATAL);

    // sum num of errors from this test.
    $cast(foo,get_report_server());
    err_cnt += (foo.get_severity_count(UVM_ERROR) + foo.get_severity_count(UVM_FATAL)); 
    //This is an accumulation operation. The += operator adds the result of the expression on the right to the current value of err_cnt.
    //In this context, err_cnt is a variable that is being used to keep a running total of the number of errors and fatal errors encountered.

    if (err_cnt == 0)
        begin
            uvm_report_info(get_full_name(), "                                                    ", UVM_LOG);
            uvm_report_info(get_full_name(), "         _______  _______  _______  _______         ", UVM_LOG);
            uvm_report_info(get_full_name(), "        |       ||   _   ||       ||       |        ", UVM_LOG);
            uvm_report_info(get_full_name(), "        |    _  ||  |_|  ||  _____||  _____|        ", UVM_LOG);
            uvm_report_info(get_full_name(), "        |   |_| ||       || |_____ | |_____         ", UVM_LOG);
            uvm_report_info(get_full_name(), "        |    ___||       ||_____  ||_____  |        ", UVM_LOG);
            uvm_report_info(get_full_name(), "        |   |    |   _   | _____| | _____| |        ", UVM_LOG);
            uvm_report_info(get_full_name(), "        |___|    |__| |__||_______||_______|        ", UVM_LOG);
            uvm_report_info(get_full_name(), "                                                    ", UVM_LOG);
        end
    else
        begin
            uvm_report_info(get_full_name(), "                                                    ", UVM_LOG);
            uvm_report_info(get_full_name(), "         _______  _______  ___   ___                ", UVM_LOG);
            uvm_report_info(get_full_name(), "        |       ||   _   ||   | |   |               ", UVM_LOG);
            uvm_report_info(get_full_name(), "        |    ___||  |_|  ||   | |   |               ", UVM_LOG);
            uvm_report_info(get_full_name(), "        |   |___ |       ||   | |   |               ", UVM_LOG);
            uvm_report_info(get_full_name(), "        |    ___||       ||   | |   |___            ", UVM_LOG);
            uvm_report_info(get_full_name(), "        |   |    |   _   ||   | |       |           ", UVM_LOG);
            uvm_report_info(get_full_name(), "        |___|    |__| |__||___| |_______|           ", UVM_LOG);
            uvm_report_info(get_full_name(), "                                                    ", UVM_LOG);
            uvm_report_info(get_full_name(), "                                                    ", UVM_LOG);
        end
    super.report_phase(phase);
  `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_NONE);
  
endfunction : report_phase       
//===================================================================================
// final_phase
//===================================================================================
function void singleport_ram_base_test::final_phase(uvm_phase phase);
  
   string _name = "final_phase";

  `uvm_info({get_type_name(),"_",_name}, $sformatf("Started."), UVM_NONE);
   super.final_phase(phase);

  `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended."), UVM_NONE);
  
endfunction : final_phase           
   
`endif //GUARD_SINGLEPORT_RAM_BASE_TEST_SV