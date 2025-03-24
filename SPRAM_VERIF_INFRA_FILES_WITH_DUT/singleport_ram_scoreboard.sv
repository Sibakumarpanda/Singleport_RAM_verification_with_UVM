//------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : singleport_ram_scoreboard.sv 
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : 
// Author  : Siba Kumar Panda
////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef GUARD_SINGLEPORT_RAM_SCOREBOARD_SV
`define GUARD_SINGLEPORT_RAM_SCOREBOARD_SV

`uvm_analysis_imp_decl( _drv )
`uvm_analysis_imp_decl( _mon )

class singleport_ram_scoreboard extends uvm_scoreboard;
  
    `uvm_component_utils(singleport_ram_scoreboard)
  
     uvm_analysis_imp_drv #(singleport_ram_sequence_item, singleport_ram_scoreboard) aport_drv;
     uvm_analysis_imp_mon #(singleport_ram_sequence_item, singleport_ram_scoreboard) aport_mon;
  
     uvm_tlm_fifo #(singleport_ram_sequence_item) expfifo;
     uvm_tlm_fifo #(singleport_ram_sequence_item) outfifo;
  
     int vect_cnt, pass_cnt, fail_cnt;
     parameter ADDR_WIDTH=16;
     parameter DATA_WIDTH=8;
  
     reg [DATA_WIDTH-1:0] mem_test[(2**ADDR_WIDTH-1):0];
     reg [ADDR_WIDTH-1:0] t_data_out;
  
     // Constructor
     extern function new(string name="singleport_ram_scoreboard",uvm_component parent);
     // build_phase  
     extern function void build_phase(uvm_phase phase);
     //run_phase  
     extern task run_phase(uvm_phase phase);
       
     // Function: report_phase
     extern function void report_phase(uvm_phase phase);  
     
     // Other Functions used here are
     extern function void write_drv(singleport_ram_sequence_item tr);
         
     extern function void write_mon(singleport_ram_sequence_item tr);
       
     extern function void PASS();
       
     extern function void FAIL();  
       
     
  
endclass : singleport_ram_scoreboard

//===================================================================================
// New
//===================================================================================
function singleport_ram_scoreboard::new(string name="singleport_ram_scoreboard",uvm_component parent);
    super.new(name,parent);
endfunction : new
  
//===================================================================================
// build_phase
//===================================================================================
function void singleport_ram_scoreboard::build_phase(uvm_phase phase);
	super.build_phase(phase);
	aport_drv = new("aport_drv", this);
	aport_mon = new("aport_mon", this);
	expfifo= new("expfifo",this);
	outfifo= new("outfifo",this);
endfunction : build_phase

//===================================================================================
// run_phase
//===================================================================================
task singleport_ram_scoreboard::run_phase(uvm_phase phase);
  
	 singleport_ram_sequence_item exp_tr, out_tr;
  
	forever begin
        `uvm_info(get_name(),"WAITING for Expected output", UVM_LOW)
		 expfifo.get(exp_tr);
        `uvm_info("Expected Packet-->", exp_tr.convert2string(), UVM_LOW)
      
        `uvm_info(get_name(),"WAITING for Actual output", UVM_LOW)
		 outfifo.get(out_tr);
        `uvm_info("Actual packet -->", out_tr.convert2string(), UVM_LOW)
        
      
      	if(out_tr.rst_p==1) begin
          $display("***********RESET Signal is asserted , Hence Do not Comapre the Packet********");
          //`uvm_info(" RESET Signal is asserted , Hence Do not Comapre the Packet", UVM_LOW)
      	end
      
        
        else if (out_tr.compare(exp_tr)) begin			
         `uvm_info("FROM_SCOREBOARD_COMPARISION", $sformatf("\nActual Packet: %s\nExpected Packet: %s\nPACKET Status -> PACKET_MATCHED", out_tr.convert2string(), exp_tr.convert2string()), UVM_NONE)
          PASS();
		end 
             
        /*else if(out_tr.data_out==exp_tr.data_out)
        	begin
          	  PASS();
              `uvm_info("FROM_SCOREBOARD_COMPARISION", $sformatf("\nActual Packet: %s\nExpected Packet: %s\nPACKET Status -> PACKET_MATCHED", out_tr.convert2string(), exp_tr.convert2string()), UVM_NONE)
        	end */
      
      	else begin
          `uvm_error("FROM_SCOREBOARD_COMPARISION", $sformatf("\nActual Packet: %s\nExpected Packet: %s\nPACKET Status -> PACKET_MISMATCHED", out_tr.convert2string(), exp_tr.convert2string()))
          FAIL();
          
		end
      
    end
 endtask :run_phase
       
function void singleport_ram_scoreboard::PASS();
	vect_cnt++;
	pass_cnt++;
endfunction : PASS

function void singleport_ram_scoreboard::FAIL();
  	vect_cnt++;
  	fail_cnt++;
endfunction :FAIL
       
//Reference Model Logic as below to generate Expected Packet that is exp_tr.convert2string() and put in to expfifo
       
function void singleport_ram_scoreboard::write_drv(singleport_ram_sequence_item tr);
  
    `uvm_info("write_drv STIMULUS", tr.convert2string(), UVM_HIGH)
  
     if(tr.rst_p==1) 
       
        begin
          $display("************* Observation of RESET Signal as High *****************");
          `uvm_info("RESET in scoreboard", "----- RESET ---------", UVM_MEDIUM)
        for(int unsigned i=0;i<2**ADDR_WIDTH;i++)
          begin
          	mem_test[i]=0;
            tr.addr=0;
            tr.data_in=0;
            t_data_out=0;
            tr.rdn_wr=0;
          end
       end
  
    if(tr.rdn_wr==1)
       begin
        mem_test[tr.addr]=tr.data_in;
       end
  
    if(tr.rdn_wr==0)
       begin
        t_data_out=mem_test[tr.addr];
       end
    else begin
        t_data_out=t_data_out;
    end
  
    tr.data_out=t_data_out;
  
    void'(expfifo.try_put(tr));
  
endfunction : write_drv

//Logic as below to generate Actual Packet that is out_tr.convert2string() and put in to outfifo
       
function void singleport_ram_scoreboard::write_mon(singleport_ram_sequence_item tr);
    `uvm_info("write_mon OUT ", tr.convert2string(), UVM_HIGH)
	 void'(outfifo.try_put(tr));
endfunction : write_mon
       
//===================================================================================
// report_phase -Report phase to summarize results at the end of simulation
//===================================================================================
     
function void singleport_ram_scoreboard::report_phase(uvm_phase phase);
  $display("\n**************Singleport Ram Scoreboard comparison Summary***************\n");
     $display("Number of successful comparisons = %0d,Number of Unsuccessful comparisons = %0d\n",pass_cnt,fail_cnt);
     $display("-----------------------------------------------------------------\n");
endfunction : report_phase         
  
`endif //GUARD_SINGLEPORT_RAM_SCOREBOARD_SV