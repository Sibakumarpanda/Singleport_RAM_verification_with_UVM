//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : singleport_ram_basic_write_read_sequence.sv.sv
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : This sequence will have both write and read operation with reset=0(deasserted)
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SINGLEPORT_RAM_BASIC_WRITE_READ_SEQUENCE_SV
`define GUARD_SINGLEPORT_RAM_BASIC_WRITE_READ_SEQUENCE_SV

class singleport_ram_basic_write_read_sequence extends singleport_ram_base_sequence;
 
  `uvm_object_utils(singleport_ram_basic_write_read_sequence)
  
   singleport_ram_sequence_item txn;
   int count=100;
  
   extern function new(string name="singleport_ram_basic_write_read_sequence");
   extern task body();
  
endclass: singleport_ram_basic_write_read_sequence

//===================================================================================
// New
//===================================================================================
function singleport_ram_basic_write_read_sequence::new(string name="singleport_ram_basic_write_read_sequence");
      super.new(name);
endfunction :new
     
//===================================================================================
// task body
//===================================================================================
task singleport_ram_basic_write_read_sequence::body();
  
    for(int i=0;i<count;i++)
      begin
        if(i<50)
          begin
            txn=singleport_ram_sequence_item::type_id::create("txn");
            start_item(txn);
            txn.randomize()with{txn.rdn_wr==1;}; //write operation
            txn.rst_p=0;
            finish_item(txn);
          end
        else  
          begin
            txn=singleport_ram_sequence_item::type_id::create("txn");
            start_item(txn);
            txn.randomize()with{txn.rdn_wr==0;}; //read operation
            txn.rst_p=0;
            finish_item(txn);
          end
      end

endtask:body


`endif //GUARD_SINGLEPORT_RAM_BASIC_WRITE_READ_SEQUENCE_SV