//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : singleport_ram_sequence_item.sv 
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SINGLEPORT_RAM_SEQUENCE_ITEM_SV
`define GUARD_SINGLEPORT_RAM_SEQUENCE_ITEM_SV

class singleport_ram_sequence_item extends uvm_sequence_item;

  //i/p || o/p field declaration

  parameter ADDR_WIDTH=16;
  parameter DATA_WIDTH=8;

  rand logic [DATA_WIDTH-1:0]data_in; //8-bit
  rand logic rdn_wr;
  rand logic [ADDR_WIDTH-1:0]addr; //16-bit
  logic rst_p;

  logic [DATA_WIDTH-1:0]data_out;
  
  //register ram_sequence_item class with factory
  `uvm_object_utils_begin(singleport_ram_sequence_item) 
     `uvm_field_int( data_in ,UVM_ALL_ON)
     `uvm_field_int( rdn_wr ,UVM_ALL_ON)
     `uvm_field_int( rst_p ,UVM_ALL_ON)
     `uvm_field_int( addr ,UVM_ALL_ON)
  	 `uvm_field_int( data_out ,UVM_ALL_ON)
  `uvm_object_utils_end
  
  // Constructor: new
  extern function new(string name="singleport_ram_sequence_item");
  // Function :   convert2string
  extern function string convert2string();
  //  Function: do_print
  //extern function void do_print(uvm_printer printer);
    
  extern function void printf();
   
endclass: singleport_ram_sequence_item

//===================================================================================
// New
//===================================================================================

function singleport_ram_sequence_item::new(string name="singleport_ram_sequence_item");
    super.new(name);
endfunction :new

//===================================================================================
// Function convert2string
//===================================================================================
function string singleport_ram_sequence_item::convert2string();
    string s;
    s = super.convert2string();
    /*  list of local properties to be printed:  */
    s = {s, $sformatf("rst_p=%0b,rdn_wr=%0b,addr= %0h,data_in= %0h,data_out=%0h\n",rst_p,rdn_wr,addr,data_in,data_out)};
    return s; 
endfunction: convert2string
    
//===================================================================================
// Function printf
//===================================================================================
function void singleport_ram_sequence_item::printf();
    `uvm_info("mux_sequence_item",$sformatf("rst_p=%0b,rdn_wr=%0b,addr= %0h,data_in= %0h,data_out=%0h\n",rst_p,rdn_wr,addr,data_in,data_out),UVM_LOW)
endfunction :printf

`endif //GUARD_SINGLEPORT_RAM_SEQUENCE_ITEM_SV
