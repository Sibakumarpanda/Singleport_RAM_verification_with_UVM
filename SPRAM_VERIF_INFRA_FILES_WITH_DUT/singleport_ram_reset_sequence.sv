//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : singleport_ram_reset_sequence.sv 
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : reset sequence for resetting RAM
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SINGLEPORT_RAM_RESET_SEQUENCE_SV
`define GUARD_SINGLEPORT_RAM_RESET_SEQUENCE_SV

class singleport_ram_reset_sequence extends singleport_ram_base_sequence;
  
  `uvm_object_utils(singleport_ram_reset_sequence)      
  
   singleport_ram_sequence_item txn;
  
   extern function new(string name="singleport_ram_reset_sequence");
  
   extern task body();
  
endclass: singleport_ram_reset_sequence

//===================================================================================
// New
//===================================================================================
function singleport_ram_reset_sequence::new(string name="singleport_ram_reset_sequence");
    super.new(name);
endfunction :new

//===================================================================================
// task body
//===================================================================================
task singleport_ram_reset_sequence::body();
  
    txn=singleport_ram_sequence_item::type_id::create("txn");
    start_item(txn);
    txn.rst_p=1;
    txn.data_in=0;
    txn.rdn_wr=0;
    txn.addr=0;
    finish_item(txn);
  
endtask:body

`endif //GUARD_SINGLEPORT_RAM_RESET_SEQUENCE_SV