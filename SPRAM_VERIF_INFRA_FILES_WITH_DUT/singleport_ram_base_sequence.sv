//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : singleport_ram_base_sequence.sv 
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SINGLEPORT_RAM_BASE_SEQUENCE_SV
`define GUARD_SINGLEPORT_RAM_BASE_SEQUENCE_SV

//typedef class write_and_read;
class singleport_ram_base_sequence extends uvm_sequence#(singleport_ram_sequence_item);
 
  `uvm_object_utils(singleport_ram_base_sequence)            
  
   singleport_ram_sequence_item txn;
  
   // constructor
   extern function new(string name="singleport_ram_base_sequence");
   // task
   extern virtual task body();  

  
endclass:singleport_ram_base_sequence

//===================================================================================
// New
//===================================================================================

function singleport_ram_base_sequence::new(string name="singleport_ram_base_sequence");  
    super.new(name);
endfunction :new

//===================================================================================
// task body
//===================================================================================
task singleport_ram_base_sequence::body();
    
endtask:body
  
`endif //GUARD_SINGLEPORT_RAM_BASE_SEQUENCE_SV