//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : singleport_ram_read_only_sequence.sv
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : it will only read from RAM , address is random. you can change iteration to any value 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SINGLEPORT_RAM_READ_ONLY_SEQUENCE_SV
`define GUARD_SINGLEPORT_RAM_READ_ONLY_SEQUENCE_SV

class singleport_ram_read_only_sequence extends singleport_ram_base_sequence;
 
   `uvm_object_utils(singleport_ram_read_only_sequence)      
 
    singleport_ram_sequence_item txn;
    int unsigned iteration=100;
  
    extern function new(string name="singleport_ram_read_only_sequence");
  
    extern task body();
      
endclass:singleport_ram_read_only_sequence

//===================================================================================
// New
//===================================================================================
function singleport_ram_read_only_sequence::new(string name="singleport_ram_read_only_sequence");
      super.new(name);
endfunction :new

//===================================================================================
// task body
//===================================================================================
task singleport_ram_read_only_sequence::body();
  
    repeat(iteration)
    begin
      txn=singleport_ram_sequence_item::type_id::create("txn");
      start_item(txn);
      txn.randomize()with{txn.rdn_wr==0;}; //read operation
      txn.rst_p=0;
      //txn.addr=16'h134a;
      finish_item(txn);
    end
  
endtask:body

`endif //GUARD_SINGLEPORT_RAM_READ_ONLY_SEQUENCE_SV