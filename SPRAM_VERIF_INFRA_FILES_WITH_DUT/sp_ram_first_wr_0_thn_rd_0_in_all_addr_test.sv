//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : sp_ram_first_wr_0_thn_rd_0_in_all_addr_test.sv
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SP_RAM_FIRST_WR_0_THN_RD_0_IN_ALL_ADDR_TEST_SV
`define GUARD_SP_RAM_FIRST_WR_0_THN_RD_0_IN_ALL_ADDR_TEST_SV

class sp_ram_first_wr_0_thn_rd_0_in_all_addr_test extends singleport_ram_base_test;

    `uvm_component_utils(sp_ram_first_wr_0_thn_rd_0_in_all_addr_test)
     
     sp_ram_first_wr_0_thn_rd_0_in_all_addr_seq  first_wr_0_thn_rd_0_in_all_addr_seq;
    
     //Constructor: new
     extern function new(string name="",uvm_component parent);
       
     //Function: build_phase
     extern function void build_phase(uvm_phase phase);
       
     //Task: run_phase  
     extern task run_phase(uvm_phase phase);
    
endclass: sp_ram_first_wr_0_thn_rd_0_in_all_addr_test
       
//===================================================================================
// New
//===================================================================================
function sp_ram_first_wr_0_thn_rd_0_in_all_addr_test::new(string name="",uvm_component parent);
	   super.new(name,parent);
endfunction :new
    
//===================================================================================
// build_phase
//===================================================================================
function void sp_ram_first_wr_0_thn_rd_0_in_all_addr_test::build_phase(uvm_phase phase);
      super.build_phase(phase);
      //env_h     = singleport_ram_env::type_id::create("env_h",this);

endfunction : build_phase
    
//===================================================================================
// run_phase
//===================================================================================
task sp_ram_first_wr_0_thn_rd_0_in_all_addr_test::run_phase(uvm_phase phase);
	 
      string _name = "run_phase";
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Started Running the --> sp_ram_first_wr_0_thn_rd_0_in_all_addr_test Test"), UVM_NONE);
 
      phase.raise_objection(this);
  
      // Check and validate the sequencer handle
      if (env_h.agent_h.sequencer_h == null) begin 
         `uvm_fatal(get_type_name(), "Sequencer handle is null");  
      end
  
      // Create the sequence object
      first_wr_0_thn_rd_0_in_all_addr_seq = sp_ram_first_wr_0_thn_rd_0_in_all_addr_seq::type_id::create("first_wr_0_thn_rd_0_in_all_addr_seq");
	 
      // Ensure the sequence is started with a valid sequencer handle
      first_wr_0_thn_rd_0_in_all_addr_seq.start(env_h.agent_h.sequencer_h); 
      
  
      // Wait for 100 time units
      #100;
      phase.drop_objection(this); // Drop the objection to allow the phase to end
  
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended Running the --> sp_ram_first_wr_0_thn_rd_0_in_all_addr_test Test"), UVM_NONE);
endtask: run_phase


`endif //GUARD_SP_RAM_FIRST_WR_0_THN_RD_0_IN_ALL_ADDR_TEST_SV