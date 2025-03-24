//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : singleport_ram_coverage.sv 
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SINGLEPORT_RAM_COVERAGE_SV
`define GUARD_SINGLEPORT_RAM_COVERAGE_SV

class singleport_ram_coverage extends uvm_subscriber #(singleport_ram_sequence_item);
   `uvm_component_utils(singleport_ram_coverage)
  
    singleport_ram_sequence_item txn;
    real cov;
    
    //constructor
    extern function new(string name="",uvm_component parent);  
    //extract_phase
    extern function void extract_phase(uvm_phase phase);
    //report_phase
    extern function void report_phase(uvm_phase phase);
      
    extern function void write(singleport_ram_sequence_item t);  
  
    //Coverage group
    covergroup dut_cov;
       option.per_instance=1;
    
       ADDR:coverpoint txn.addr { option.auto_bin_max=65535;}
    
       RDN_WR:coverpoint txn.rdn_wr;
    
       ADDR_X_RDN_WR:cross ADDR,RDN_WR;
    
       // ADDR_X_RDN_WR:cross ADDR,RDN_WR {option.cross_auto_bin_max=131072;}
       // option.cross_auto_bin_max gives error in Aldec
       DATA:coverpoint txn.data_in { option.auto_bin_max=255; }
    
    endgroup:dut_cov

endclass: singleport_ram_coverage

//===================================================================================
// New
//===================================================================================
function singleport_ram_coverage::new(string name="",uvm_component parent);
    super.new(name,parent);
    dut_cov=new();
endfunction :new

//===================================================================================
// extract_phase
//===================================================================================
function void singleport_ram_coverage::extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    cov=dut_cov.get_coverage();
endfunction :extract_phase

//===================================================================================
// report_phase
//===================================================================================
function void singleport_ram_coverage::report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(),$sformatf("Coverage is %f",cov),UVM_LOW)
endfunction :report_phase
      
 //write method 
function void singleport_ram_coverage::write(singleport_ram_sequence_item t);
    txn=t;
    dut_cov.sample();
endfunction :write     

`endif //GUARD_SINGLEPORT_RAM_COVERAGE_SV