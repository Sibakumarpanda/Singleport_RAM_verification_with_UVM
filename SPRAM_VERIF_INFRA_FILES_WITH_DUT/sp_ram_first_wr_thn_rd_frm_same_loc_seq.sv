//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : sp_ram_first_wr_thn_rd_frm_same_loc_seq.sv
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : ->it will first write into RAM and then read from it.
//             read and write location control by if condition.
//           ->you can change count , also according to it change
//             if coundition in body.
//           ->address and data are same as value of i in for loop.
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SP_RAM_FIRST_WR_THN_RD_FRM_SAME_LOC_SEQ_SV
`define GUARD_SP_RAM_FIRST_WR_THN_RD_FRM_SAME_LOC_SEQ_SV


class sp_ram_first_wr_thn_rd_frm_same_loc_seq extends singleport_ram_base_sequence;
  
    `uvm_object_utils(sp_ram_first_wr_thn_rd_frm_same_loc_seq)      
  
  
     singleport_ram_sequence_item txn;
     int count=100;
  
     extern function new(string name="sp_ram_first_wr_thn_rd_frm_same_loc_seq");
 
     extern task body();
  
endclass:sp_ram_first_wr_thn_rd_frm_same_loc_seq


//===================================================================================
// New
//===================================================================================
function sp_ram_first_wr_thn_rd_frm_same_loc_seq::new(string name="sp_ram_first_wr_thn_rd_frm_same_loc_seq");
      super.new(name);
endfunction :new
 

//===================================================================================
// task body()
//===================================================================================
task sp_ram_first_wr_thn_rd_frm_same_loc_seq::body();
  
    txn=singleport_ram_sequence_item::type_id::create("txn");
  
    for(int i=0;i<count;i++)
      begin
        if(i<50)
          begin
            start_item(txn);
            txn.randomize()with{txn.rdn_wr==1;txn.addr==i;txn.data_in==i;};
            txn.rst_p=0;
            finish_item(txn);
          end
        else  
          begin
            start_item(txn);
            txn.randomize()with{txn.rdn_wr==0;txn.addr==(i-50);txn.data_in==i;};
            txn.rst_p=0;
            finish_item(txn);
          end
      end

endtask:body
  
`endif //GUARD_SP_RAM_FIRST_WR_THN_RD_FRM_SAME_LOC_SEQ_SV