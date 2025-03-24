//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : singleport_ram_agent.sv 
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SINGLEPORT_RAM_AGENT_SV
`define GUARD_SINGLEPORT_RAM_AGENT_SV

class singleport_ram_agent extends uvm_agent;
   `uvm_component_utils(singleport_ram_agent)
    
    singleport_ram_sequencer      sequencer_h;
    singleport_ram_driver         driver_h;
    singleport_ram_monitor        monitor_h;
  
    // Constructor
    extern function new(string name="",uvm_component parent);
    // build_phase  
    extern function void build_phase(uvm_phase phase);
    // connect_phase  
    extern function void connect_phase(uvm_phase phase);
      
      
endclass: singleport_ram_agent

//===================================================================================
// New
//===================================================================================
function singleport_ram_agent::new(string name="",uvm_component parent);
    super.new(name,parent);
endfunction :new
  

//===================================================================================
// build_phase
//===================================================================================
function void singleport_ram_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);
    sequencer_h = singleport_ram_sequencer::type_id::create("sequencer_h",this);
    driver_h    = singleport_ram_driver::type_id::create("driver_h",this);    
    monitor_h   = singleport_ram_monitor::type_id::create("monitor_h",this);
endfunction :build_phase
  
//===================================================================================
// connect_phase
//===================================================================================
  
function void singleport_ram_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
endfunction :connect_phase

`endif //GUARD_SINGLEPORT_RAM_AGENT_SV