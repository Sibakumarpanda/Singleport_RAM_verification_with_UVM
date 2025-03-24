//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : sp_ram_wr_in_1_mem_loc_thn_rd_frm_1_loc_seq.sv
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : ->it will first write in RAM in onle location(address),
//                and then read from same location(address).
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SP_RAM_WR_IN_1_MEM_LOC_THN_RD_FRM_1_LOC_SEQ_SV
`define GUARD_SP_RAM_WR_IN_1_MEM_LOC_THN_RD_FRM_1_LOC_SEQ_SV


class sp_ram_wr_in_1_mem_loc_thn_rd_frm_1_loc_seq extends singleport_ram_base_sequence;
 
    `uvm_object_utils(sp_ram_wr_in_1_mem_loc_thn_rd_frm_1_loc_seq)      
 
  
    singleport_ram_sequence_item txn;
    bit [17:0] count=200;
    bit [15:0] i;
    bit [15:0]temp_addr;
  
    extern function new(string name="sp_ram_wr_in_1_mem_loc_thn_rd_frm_1_loc_seq");
      
    extern task body();  
  
endclass:sp_ram_wr_in_1_mem_loc_thn_rd_frm_1_loc_seq
      
//===================================================================================
// New
//=================================================================================== 
function sp_ram_wr_in_1_mem_loc_thn_rd_frm_1_loc_seq::new(string name="sp_ram_wr_in_1_mem_loc_thn_rd_frm_1_loc_seq");
      super.new(name);
endfunction :new

//===================================================================================
// task body()
//===================================================================================
task sp_ram_wr_in_1_mem_loc_thn_rd_frm_1_loc_seq::body();
  
    txn=singleport_ram_sequence_item::type_id::create("txn");
  
        for(i=0;i<count;i++)
          begin
            
            if(i%2 != 0)
              begin
                start_item(txn);
               // txn.randomize()with{txn.rdn_wr==1;txn.addr==i;txn.data_in==i;};
                txn.addr=i;
                txn.data_in = i;
                txn.rdn_wr = 1;
                temp_addr=txn.addr;
                txn.rst_p=0;
                finish_item(txn);
              end
            
            else 
              begin
                start_item(txn);
                //txn.randomize()with{txn.rdn_wr==0;txn.data_in==i;};
                txn.data_in = 0;
                txn.rdn_wr = 0;
                txn.addr=temp_addr;
                txn.rst_p=0;
                finish_item(txn);
              end
         end
        
endtask:body
 
`endif //GUARD_SP_RAM_WR_IN_1_MEM_LOC_THN_RD_FRM_1_LOC_SEQ_SV