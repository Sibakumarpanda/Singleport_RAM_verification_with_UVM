//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : sp_ram_wr_in_2_mem_loc_thn_rd_frm_2_loc_seq.sv
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : ->first it will write in 2 memory location and then
//                it will read form those 2 memory locations
//              ->here value of address is same as t_addr not i of
//                for loop.
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SP_RAM_WR_IN_2_MEM_LOC_THN_RD_FRM_2_LOC_SEQ_SV
`define GUARD_SP_RAM_WR_IN_2_MEM_LOC_THN_RD_FRM_2_LOC_SEQ_SV


class sp_ram_wr_in_2_mem_loc_thn_rd_frm_2_loc_seq extends singleport_ram_base_sequence;
  
    `uvm_object_utils(sp_ram_wr_in_2_mem_loc_thn_rd_frm_2_loc_seq)      
 
  
     singleport_ram_sequence_item txn;
     bit [15:0] count=50;
     bit [15:0] i;
     bit [15:0] t_addr;
     bit [15:0] temp;
  
     extern function new(string name="sp_ram_wr_in_2_mem_loc_thn_rd_frm_2_loc_seq");
       
     extern task body();  
       
endclass:sp_ram_wr_in_2_mem_loc_thn_rd_frm_2_loc_seq  
       

//===================================================================================
// New
//===================================================================================
function sp_ram_wr_in_2_mem_loc_thn_rd_frm_2_loc_seq::new(string name="sp_ram_wr_in_2_mem_loc_thn_rd_frm_2_loc_seq");
      super.new(name);
endfunction: new
       
//===================================================================================
// task body()
//===================================================================================
task sp_ram_wr_in_2_mem_loc_thn_rd_frm_2_loc_seq::body();
  
      repeat(count)
        begin
          txn=singleport_ram_sequence_item::type_id::create("txn");
          
            for(i=1;i<3;i++)
              begin
                t_addr++;
                temp=t_addr;
                start_item(txn);
                txn.randomize()with{txn.rdn_wr==1;txn.addr==t_addr;};
                txn.rst_p=0;
                finish_item(txn);
              end
          
            for(i=1;i<3;i++)
              begin
                temp--;
                if(i==1)
                  begin
                    start_item(txn);
                    txn.randomize()with{txn.rdn_wr==0;txn.addr==temp; };
                    txn.rst_p=0;
                    finish_item(txn);
                  end
                else  
                  begin
                    start_item(txn);
                    txn.randomize()with{txn.rdn_wr==0;txn.addr==t_addr; };
                    txn.rst_p=0;
                    finish_item(txn);
                  end
              end
        end
        
endtask:body
         
`endif //GUARD_SP_RAM_WR_IN_2_MEM_LOC_THN_RD_FRM_2_LOC_SEQ_SV