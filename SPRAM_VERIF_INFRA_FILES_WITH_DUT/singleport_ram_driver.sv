//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : singleport_ram_driver.sv 
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SINGLEPORT_RAM_DRIVER_SV
`define GUARD_SINGLEPORT_RAM_DRIVER_SV

class singleport_ram_driver extends uvm_driver #(singleport_ram_sequence_item);
  
  `uvm_component_utils(singleport_ram_driver)
   uvm_analysis_port #(singleport_ram_sequence_item) drv2sb;
  
   virtual interface singleport_ram_interface vif;
     
   // Constructor: new
   extern function new(string name="",uvm_component parent);
     
   //build_phase
   extern function void build_phase(uvm_phase phase);
   //run_phase
   extern task run_phase(uvm_phase phase);
 
     
endclass: singleport_ram_driver
     
//===================================================================================
// New
//===================================================================================
     
function singleport_ram_driver::new(string name="",uvm_component parent);
    super.new(name,parent);
    drv2sb=new("drv2sb",this);
endfunction :new
     
//===================================================================================
// build_phase
//===================================================================================
     
function void singleport_ram_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db#(virtual singleport_ram_interface)::get(this,"","vif",vif))) begin //get interface handel from top 
      `uvm_fatal("driver","unable to get interface");
    end
endfunction :build_phase

//===================================================================================
// run_phase
//===================================================================================
  
task singleport_ram_driver::run_phase(uvm_phase phase);
    singleport_ram_sequence_item txn;
    forever begin
      seq_item_port.get_next_item(txn);
      // write driver code here
      @(posedge vif.clk);
      vif.data_in <= txn.data_in;
      vif.rdn_wr  <= txn.rdn_wr;
      vif.rst_p   <= txn.rst_p;
      vif.addr    <= txn.addr;
      #1;
      drv2sb.write(txn);   // send data to scoreboard
      `uvm_info(get_type_name(),txn.convert2string(),UVM_MEDIUM)
     // txn.printf();
      seq_item_port.item_done();    
    end
endtask :run_phase
  
`endif //GUARD_SINGLEPORT_RAM_DRIVER_SV