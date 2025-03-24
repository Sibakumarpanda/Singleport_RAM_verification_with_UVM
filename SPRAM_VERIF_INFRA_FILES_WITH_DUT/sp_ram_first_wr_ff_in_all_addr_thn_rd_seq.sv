//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : sp_ram_first_wr_ff_in_all_addr_thn_rd_seq.sv
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : ->it will first write value FF in all address of RAM ,
//              and then read from it.
//           ->at the time of reading output value must remain FF ,
//             if it is not then there is a bug in design.
//           ->addess value is same as value of i in for loop.
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SP_RAM_FIRST_WR_FF_IN_ALL_ADDR_THN_RD_SEQ_SV
`define GUARD_SP_RAM_FIRST_WR_FF_IN_ALL_ADDR_THN_RD_SEQ_SV


class sp_ram_first_wr_ff_in_all_addr_thn_rd_seq extends singleport_ram_base_sequence;
 
   `uvm_object_utils(sp_ram_first_wr_ff_in_all_addr_thn_rd_seq)      
 
    singleport_ram_sequence_item txn;
    bit [17:0] count=100;
    bit [17:0] i;
  
    extern function new(string name="sp_ram_first_wr_ff_in_all_addr_thn_rd_seq");
      
    extern task body();
 
  
endclass:sp_ram_first_wr_ff_in_all_addr_thn_rd_seq

//===================================================================================
// New
//===================================================================================
function sp_ram_first_wr_ff_in_all_addr_thn_rd_seq::new(string name="sp_ram_first_wr_ff_in_all_addr_thn_rd_seq");
      super.new(name);
endfunction :new
  
//===================================================================================
// task body()
//===================================================================================
task sp_ram_first_wr_ff_in_all_addr_thn_rd_seq::body();
  
     txn=singleport_ram_sequence_item::type_id::create("txn");
  
        for(i=0;i<count;i++)
          begin
            start_item(txn);
            txn.randomize()with{txn.rdn_wr==1;txn.addr==i;txn.data_in==8'hFF;};
            txn.rst_p=0;
            finish_item(txn);
          end
  
        for(i=0;i<count;i++)
          begin
            start_item(txn);
            txn.randomize()with{txn.rdn_wr==0;txn.addr==i;txn.data_in==0;};
            txn.rst_p=0;
            finish_item(txn);
          end
        
endtask:body      
      

`endif //GUARD_SP_RAM_FIRST_WR_FF_IN_ALL_ADDR_THN_RD_SEQ_SV