//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//(c) Copyright Siba Kumar Panda, All rights reserved
// File    : Readme.txt file for all Sequence and test description
// Project : Single Port RAM (64KB) Verif Infra Development
// Purpose : Readme file to get clear information about all the sequences and tests created for the verif Infra
// Author  : Siba Kumar Panda
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

1. singleport_ram_base_sequence.sv -> Base sequence

2. singleport_ram_reset_sequence.sv->  Reset sequence for resetting RAM , it is created by extending from base seq that is singleport_ram_base_sequence.sv

3. singleport_ram_write_only_sequence.sv -> Write only sequence, it will only write in RAM , in which data ,address are random. 
   It is created by extending  from base seq.

4. singleport_ram_read_only_sequence.sv-> Read only sequence,it will only read from RAM , address is random. It is created by extending from base seq.

5. singleport_ram_base_test.sv-> It is the base test , While running this test 3-sequences will be running that is 
   singleport_ram_reset_sequence ,singleport_ram_write_only_sequence ,singleport_ram_read_only_sequence

6. singleport_ram_basic_write_read_sequence.sv -> This sequence will have both write and read operation with reset=0(deasserted)

7. singleport_ram_basic_write_read_test.sv -> This is the write and read test , which will run the singleport_ram_basic_write_read_sequence.sv

8. sp_ram_first_wr_thn_rd_frm_same_loc_seq.sv -> it will first write into RAM and then read from it. Read and write location control by if condition.
   address and data are same as value of i in for loop.

9. sp_ram_first_wr_thn_rd_frm_same_loc_test.sv -> This test will run the sp_ram_first_wr_thn_rd_frm_same_loc_seq.sv sequence

10.sp_ram_first_wr_0_thn_rd_0_in_all_addr_seq.sv -> It will first write 0 in all address , and then read 0 from all address.
   at the time of reading from RAM output must remain 0 ,if it is not then there is a bug in design. address value is same as value of i in for loop.

11.sp_ram_first_wr_0_thn_rd_0_in_all_addr_test.sv -> This test will run sp_ram_first_wr_0_thn_rd_0_in_all_addr_seq.sv sequence 


12.sp_ram_wr_in_1_mem_loc_thn_rd_frm_1_loc_seq.sv->it will first write in RAM in onle location(address) and then read from same location(address).

13.sp_ram_wr_in_1_mem_loc_thn_rd_frm_1_loc_test.sv-> This test will run the sp_ram_wr_in_1_mem_loc_thn_rd_frm_1_loc_seq.sv sequence

14.sp_ram_first_wr_ff_in_all_addr_thn_rd_seq.sv -> It will first write FF in all address and read from all addresses.
   At the time of reading output value must remain FF ,if it is not then there is a bug in design. addess value is same as value of i in for loop.

15.sp_ram_first_wr_ff_in_all_addr_thn_rd_test.sv -> This test will run the sp_ram_first_wr_ff_in_all_addr_thn_rd_seq.sv sequence

16.sp_ram_wr_in_2_mem_loc_thn_rd_frm_2_loc_seq.sv->It will first write in two memory locations and read from those  two memory location
   here value of address is same as t_addr not i of for loop

17.sp_ram_wr_in_2_mem_loc_thn_rd_frm_2_loc_test.sv -> This test will run sp_ram_wr_in_2_mem_loc_thn_rd_frm_2_loc_seq sequence.sv 

-----------------------------------------------------------------------------------------------------------------------------------
