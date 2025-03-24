//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : sp_ram_first_wr_0_thn_rd_0_in_all_addr_seq.sv
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : ->it will first write 0 in all address , and then read 0
//              from all address.
//           ->at the time of readind from RAM output must remain 0 ,
//             if it is not then there is a bug in design.
//           ->address value is same as value of i in for loop.
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SP_RAM_FIRST_WR_0_THN_RD_0_IN_ALL_ADDR_SEQ_SV
`define GUARD_SP_RAM_FIRST_WR_0_THN_RD_0_IN_ALL_ADDR_SEQ_SV


class sp_ram_first_wr_0_thn_rd_0_in_all_addr_seq extends singleport_ram_base_sequence;
  
    `uvm_object_utils(sp_ram_first_wr_0_thn_rd_0_in_all_addr_seq)      
  
     singleport_ram_sequence_item txn;
     bit [17:0] count=100;
     bit [17:0] i;
  
     
     extern function new(string name="sp_ram_first_wr_0_thn_rd_0_in_all_addr_seq");
       
     extern task body();  
  
endclass:sp_ram_first_wr_0_thn_rd_0_in_all_addr_seq
       
//===================================================================================
// New
//=================================================================================== 
function sp_ram_first_wr_0_thn_rd_0_in_all_addr_seq::new(string name="sp_ram_first_wr_0_thn_rd_0_in_all_addr_seq");
      super.new(name);
endfunction :new
       
//===================================================================================
// task body
//===================================================================================
task sp_ram_first_wr_0_thn_rd_0_in_all_addr_seq::body();
  
    txn=singleport_ram_sequence_item::type_id::create("txn");
  
        for(i=0;i<count;i++)
          begin
            start_item(txn);
            txn.randomize()with{txn.rdn_wr==1;txn.addr==i;txn.data_in==0;};
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
         
`endif //GUARD_SP_RAM_FIRST_WR_0_THN_RD_0_IN_ALL_ADDR_SEQ_SV