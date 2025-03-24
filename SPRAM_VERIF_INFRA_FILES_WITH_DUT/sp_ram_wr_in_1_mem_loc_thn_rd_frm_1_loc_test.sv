//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : sp_ram_wr_in_1_mem_loc_thn_rd_frm_1_loc_test.sv
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SP_RAM_WR_IN_1_MEM_LOC_THN_RD_FRM_1_LOC_TEST_SV
`define GUARD_SP_RAM_WR_IN_1_MEM_LOC_THN_RD_FRM_1_LOC_TEST_SV

class sp_ram_wr_in_1_mem_loc_thn_rd_frm_1_loc_test extends singleport_ram_base_test;

    `uvm_component_utils(sp_ram_wr_in_1_mem_loc_thn_rd_frm_1_loc_test)
     
     sp_ram_wr_in_1_mem_loc_thn_rd_frm_1_loc_seq  wr_in_1_mem_loc_thn_rd_frm_1_loc_seq;
    
     //Constructor: new
     extern function new(string name="",uvm_component parent);
       
     //Function: build_phase
     extern function void build_phase(uvm_phase phase);
       
     //Task: run_phase  
     extern task run_phase(uvm_phase phase);
    
endclass: sp_ram_wr_in_1_mem_loc_thn_rd_frm_1_loc_test
       
//===================================================================================
// New
//===================================================================================
function sp_ram_wr_in_1_mem_loc_thn_rd_frm_1_loc_test::new(string name="",uvm_component parent);
	   super.new(name,parent);
endfunction :new
    
//===================================================================================
// build_phase
//===================================================================================
function void sp_ram_wr_in_1_mem_loc_thn_rd_frm_1_loc_test::build_phase(uvm_phase phase);
      super.build_phase(phase);
      //env_h     = singleport_ram_env::type_id::create("env_h",this);

endfunction : build_phase
    
//===================================================================================
// run_phase
//===================================================================================
task sp_ram_wr_in_1_mem_loc_thn_rd_frm_1_loc_test::run_phase(uvm_phase phase);
	 
      string _name = "run_phase";
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Started Running the --> sp_ram_wr_in_1_mem_loc_thn_rd_frm_1_loc_test Test"), UVM_NONE);
 
      phase.raise_objection(this);
  
      // Check and validate the sequencer handle
      if (env_h.agent_h.sequencer_h == null) begin 
         `uvm_fatal(get_type_name(), "Sequencer handle is null");  
      end
  
      // Create the sequence object
      wr_in_1_mem_loc_thn_rd_frm_1_loc_seq = sp_ram_wr_in_1_mem_loc_thn_rd_frm_1_loc_seq::type_id::create("wr_in_1_mem_loc_thn_rd_frm_1_loc_seq");
	 
      // Ensure the sequence is started with a valid sequencer handle
      wr_in_1_mem_loc_thn_rd_frm_1_loc_seq.start(env_h.agent_h.sequencer_h); 
      
  
      // Wait for 100 time units
      #100;
      phase.drop_objection(this); // Drop the objection to allow the phase to end
  
     `uvm_info({get_type_name(),"_",_name}, $sformatf("Ended Running the --> sp_ram_wr_in_1_mem_loc_thn_rd_frm_1_loc_test Test"), UVM_NONE);
  
endtask: run_phase

       

`endif //GUARD_SP_RAM_WR_IN_1_MEM_LOC_THN_RD_FRM_1_LOC_TEST_SV