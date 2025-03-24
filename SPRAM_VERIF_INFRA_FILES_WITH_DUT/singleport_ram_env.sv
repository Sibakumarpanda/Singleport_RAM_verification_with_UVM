//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : singleport_ram_env.sv 
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SINGLEPORT_RAM_ENV_SV
`define GUARD_SINGLEPORT_RAM_ENV_SV

class singleport_ram_env extends uvm_env;
 
   `uvm_component_utils(singleport_ram_env)
  
    singleport_ram_agent      agent_h;
    singleport_ram_coverage   coverage_h;
    singleport_ram_scoreboard scoreboard_h;
    
    // constructor
    extern function new(string name="",uvm_component parent);
    // build_phase
    extern function void build_phase(uvm_phase phase);
    // connect_phase
    extern function void connect_phase(uvm_phase phase);
 
endclass: singleport_ram_env
      
//===================================================================================
// New
//===================================================================================

function singleport_ram_env::new(string name="",uvm_component parent);
    super.new(name,parent);
endfunction :new

//===================================================================================
// build_phase
//===================================================================================
      
function void singleport_ram_env::build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent_h      = singleport_ram_agent::type_id::create("agent_h",this);
    coverage_h   = singleport_ram_coverage::type_id::create("coverage_h",this);
    scoreboard_h = singleport_ram_scoreboard::type_id::create("scoreboard_h",this);
endfunction :build_phase
 
//===================================================================================
// connect_phase
//===================================================================================
function void singleport_ram_env::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    agent_h.monitor_h.ap_mon.connect(coverage_h.analysis_export);   
    agent_h.monitor_h.ap_mon.connect(scoreboard_h.aport_mon);
    agent_h.driver_h.drv2sb.connect(scoreboard_h.aport_drv);
    
endfunction :connect_phase
  

`endif //GUARD_SINGLEPORT_RAM_ENV_SV