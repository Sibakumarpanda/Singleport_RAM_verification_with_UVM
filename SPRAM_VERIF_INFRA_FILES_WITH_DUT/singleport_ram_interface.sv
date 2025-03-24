//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : singleport_ram_interface.sv 
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SINGLEPORT_RAM_INTERFACE_SV
`define GUARD_SINGLEPORT_RAM_INTERFACE_SV

interface singleport_ram_interface(input bit clk);
  
    // port declaration
    parameter ADDR_WIDTH=16;
    parameter DATA_WIDTH=8;
    logic [DATA_WIDTH-1:0]data_in;
    logic [DATA_WIDTH-1:0]data_out;
    logic rdn_wr;
    logic rst_p;
    logic [ADDR_WIDTH-1:0]addr;

    //clocking & modport declaration 
  /*  clocking clocking_block_name @(posedge signal_name);
      default input #1step output #1step;
      output //input of DUT
      input  //output of DUT
    endclocking
  */
    //modport modport_name(clocking name_of_block);
   
        
endinterface :singleport_ram_interface

`endif //GUARD_SINGLEPORT_RAM_INTERFACE_SV