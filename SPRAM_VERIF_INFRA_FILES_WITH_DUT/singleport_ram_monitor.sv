//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : singleport_ram_monitor.sv 
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SINGLEPORT_RAM_MONITOR_SV
`define GUARD_SINGLEPORT_RAM_MONITOR_SV

class singleport_ram_monitor extends uvm_monitor;
  
  `uvm_component_utils(singleport_ram_monitor)
  
   singleport_ram_sequence_item  txn;
   virtual interface singleport_ram_interface vif;
   uvm_analysis_port#(singleport_ram_sequence_item) ap_mon; //analysis port
     
   // Constructor
   extern function new(string name="",uvm_component parent); 
     
   //build_phase
   extern function void build_phase(uvm_phase phase);
     
   //run_phase
   extern task run_phase(uvm_phase phase);  
 

endclass:singleport_ram_monitor
     
//===================================================================================
// New
//===================================================================================

function singleport_ram_monitor::new(string name="",uvm_component parent);
    super.new(name,parent);
endfunction :new
  
//===================================================================================
// build_phase
//===================================================================================
  
function void singleport_ram_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db#(virtual singleport_ram_interface)::get(this,"","vif",vif)))
    begin
      `uvm_fatal("monitor","unable to get interface")
    end
    
    ap_mon=new("ap_mon",this);
    txn=singleport_ram_sequence_item::type_id::create("txn",this);
endfunction :build_phase
 
//===================================================================================
// run_phase
//===================================================================================
 
task singleport_ram_monitor::run_phase(uvm_phase phase);
    forever
    begin
      // write monitor code here
      @(negedge vif.clk);
      txn.addr 		= vif.addr;
      txn.data_in   = vif.data_in;
      txn.data_out  = vif.data_out;
      txn.rdn_wr    = vif.rdn_wr;
      txn.rst_p     = vif.rst_p; 
      ap_mon.write(txn);
     
     // txn.printf();
    end
endtask :run_phase
       
`endif //GUARD_SINGLEPORT_RAM_MONITOR_SV