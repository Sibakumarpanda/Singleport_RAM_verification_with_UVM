//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : singleport_ram_sequencer.sv 
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SINGLEPORT_RAM_SEQUENCER_SV
`define GUARD_SINGLEPORT_RAM_SEQUENCER_SV

class singleport_ram_sequencer extends uvm_sequencer#(singleport_ram_sequence_item);
  
  `uvm_component_utils(singleport_ram_sequencer)  
 
   // Constructor: new
   extern function new(string name ="singleport_ram_sequencer", uvm_component parent);
  
endclass: singleport_ram_sequencer

//===================================================================================
// New
//===================================================================================

function singleport_ram_sequencer::new(string name="singleport_ram_sequencer",uvm_component parent);  
    super.new(name,parent);
endfunction :new
 

`endif //GUARD_SINGLEPORT_RAM_SEQUENCER_SV
