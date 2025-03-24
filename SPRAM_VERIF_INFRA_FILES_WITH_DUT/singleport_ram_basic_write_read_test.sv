////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : singleport_ram_basic_write_read_test.sv.sv 
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SINGLEPORT_RAM_BASIC_WRITE_READ_TEST_SV
`define GUARD_SINGLEPORT_RAM_BASIC_WRITE_READ_TEST_SV

class singleport_ram_basic_write_read_test extends singleport_ram_base_test;

    `uvm_component_utils(singleport_ram_basic_write_read_test)
     
     singleport_ram_basic_write_read_sequence  basic_write_read_seq;
    
     //Constructor: new   
     extern function new(string name="",uvm_component parent);
       
     //Function: build_phase
     extern function void build_phase(uvm_phase phase);
       
     //Task: run_phase  
     extern task run_phase(uvm_phase phase);
    
endclass: singleport_ram_basic_write_read_test
       
//===================================================================================
// New
//===================================================================================
function singleport_ram_basic_write_read_test::new(string name="",uvm_component parent);
	   super.new(name,parent);
endfunction :new
    
//===================================================================================
// build_phase
//===================================================================================
function void singleport_ram_basic_write_read_test::build_phase(uvm_phase phase);
      super.build_phase(phase);
      //env_h     = singleport_ram_env::type_id::create("env_h",this);

endfunction : build_phase
    
//===================================================================================
// run_phase
//===================================================================================
task singleport_ram_basic_write_read_test::run_phase(uvm_phase phase);
	 
      string _name = "run_phase";
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Started Running the--> singleport_ram_basic_write_read_test Test"), UVM_NONE);
 
      phase.raise_objection(this);
  
      // Check and validate the sequencer handle
      if (env_h.agent_h.sequencer_h == null) begin 
         `uvm_fatal(get_type_name(), "Sequencer handle is null");  
      end
  
      // Create the sequence object
      basic_write_read_seq = singleport_ram_basic_write_read_sequence::type_id::create("basic_write_read_seq");
	 
      // Ensure the sequence is started with a valid sequencer handle
      basic_write_read_seq.start(env_h.agent_h.sequencer_h); 
      
  
      // Wait for 100 time units
      #100;
      phase.drop_objection(this); // Drop the objection to allow the phase to end
  
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended Running the --> singleport_ram_basic_write_read_test Test"), UVM_NONE);
  
endtask :run_phase
    
`endif //GUARD_SINGLEPORT_RAM_BASIC_WRITE_READ_TEST_SV