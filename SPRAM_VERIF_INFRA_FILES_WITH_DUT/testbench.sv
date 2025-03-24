//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : testbench.sv 
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : tb_top file
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`include "singleport_ram_interface.sv"
`include "singleport_ram_package.sv"


module tb_top;
  import uvm_pkg::*;
  import singleport_ram_package::*;
  
  bit clk; // external signal declaration
  
  singleport_ram_interface i_intf(clk);
  
  singleport_RAM_64KB DUT(.clk(i_intf.clk),
                          .data_in(i_intf.data_in),
                          .data_out(i_intf.data_out),
                          .rst_p(i_intf.rst_p),
                          .addr(i_intf.addr),
                          .rdn_wr(i_intf.rdn_wr)
                          );
  
  always #5 clk=~clk;

  initial begin
    clk=0;
  end
  
  initial begin
    uvm_config_db#(virtual singleport_ram_interface)::set(uvm_root::get(),"","vif",i_intf);
  end
  
  initial begin
    run_test("singleport_ram_base_test");
    //run_test("singleport_ram_basic_write_read_test");
    //run_test("sp_ram_first_wr_thn_rd_frm_same_loc_test"); // Need to debug this test, having lot of scb errors
    //run_test("sp_ram_first_wr_0_thn_rd_0_in_all_addr_test"); // Need to debug this test, having lot of scb errors
    
    //run_test("sp_ram_wr_in_1_mem_loc_thn_rd_frm_1_loc_test");
    //run_test("sp_ram_first_wr_ff_in_all_addr_thn_rd_test");
    //run_test("sp_ram_wr_in_2_mem_loc_thn_rd_frm_2_loc_test");
    
  end
  
  initial begin
    $dumpfile("dumpfile.vcd");
    $dumpvars;
  end
  
endmodule :tb_top
     
