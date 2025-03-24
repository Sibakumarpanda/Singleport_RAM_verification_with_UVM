//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : singleport_ram_package.sv 
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SINGLEPORT_RAM_PACKAGE_SV
`define GUARD_SINGLEPORT_RAM_PACKAGE_SV

package singleport_ram_package;

import uvm_pkg::*;
`include "uvm_macros.svh"
//`include "apb_interface.sv" - Inside Package "interface" is not allowed to write
//`include "tb_define.sv" - We can include when this file is in use , at current its not used


`include "singleport_ram_sequence_item.sv"
`include "singleport_ram_base_sequence.sv"
`include "singleport_ram_reset_sequence.sv"
`include "singleport_ram_write_only_sequence.sv"
`include "singleport_ram_read_only_sequence.sv"
`include "singleport_ram_basic_write_read_sequence.sv"
`include "sp_ram_first_wr_thn_rd_frm_same_loc_seq.sv"
`include "sp_ram_first_wr_0_thn_rd_0_in_all_addr_seq.sv"
`include "sp_ram_wr_in_1_mem_loc_thn_rd_frm_1_loc_seq.sv"
`include "sp_ram_first_wr_ff_in_all_addr_thn_rd_seq.sv"
`include "sp_ram_wr_in_2_mem_loc_thn_rd_frm_2_loc_seq.sv"
`include "singleport_ram_sequencer.sv"
`include "singleport_ram_driver.sv"
`include "singleport_ram_monitor.sv"
`include "singleport_ram_coverage.sv"
`include "singleport_ram_agent.sv"
`include "singleport_ram_scoreboard.sv"
`include "singleport_ram_env.sv"
`include "singleport_ram_base_test.sv"
`include "singleport_ram_basic_write_read_test.sv"
`include "sp_ram_first_wr_thn_rd_frm_same_loc_test.sv"
`include "sp_ram_first_wr_0_thn_rd_0_in_all_addr_test.sv"
`include "sp_ram_wr_in_1_mem_loc_thn_rd_frm_1_loc_test.sv"
`include "sp_ram_first_wr_ff_in_all_addr_thn_rd_test.sv"
`include "sp_ram_wr_in_2_mem_loc_thn_rd_frm_2_loc_test.sv"


endpackage : singleport_ram_package

`endif //GUARD_SINGLEPORT_RAM_PACKAGE_SV