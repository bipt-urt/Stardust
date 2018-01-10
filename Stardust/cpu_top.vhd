----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:55:50 01/05/2018 
-- Design Name: 
-- Module Name:    cpu_top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cpu_top is
    Port ( top_clk_key : in  STD_LOGIC;
           top_clk50 : in  STD_LOGIC;
			  top_rst : in  STD_LOGIC;
           top_sw : in  STD_LOGIC_VECTOR (15 downto 0);
           top_ram1_data : inout  STD_LOGIC_VECTOR (15 downto 0);
           top_ram2_data : inout  STD_LOGIC_VECTOR (15 downto 0);
           top_ram1_en : out  STD_LOGIC;
           top_ram1_we : out  STD_LOGIC;
           top_ram1_oe : out  STD_LOGIC;
           top_ram2_en : out  STD_LOGIC;
           top_ram2_we : out  STD_LOGIC;
           top_ram2_oe : out  STD_LOGIC;
           top_led : out  STD_LOGIC_VECTOR (15 downto 0);
           top_ram1_addr : out  STD_LOGIC_VECTOR (17 downto 0);
           top_ram2_addr : out  STD_LOGIC_VECTOR (17 downto 0);
           top_left_dyp : out  STD_LOGIC_VECTOR (6 downto 0);
           top_rigth_dyp : out  STD_LOGIC_VECTOR (6 downto 0));
end cpu_top;

architecture Behavioral of cpu_top is

component mux1 is
		port (	
				mux1_rx_in : in std_logic_vector(15 downto 0);
				mux1_aluResult_in : in std_logic_vector(15 downto 0);
				mux1_result_out : out std_logic_vector(15 downto 0);
				mux1_control_in : in std_logic_vector(1 downto 0)
			);
end component;

component pc is
		Port ( 
					pc_in : in  STD_LOGIC_VECTOR (15 downto 0);
					pc_out : out  STD_LOGIC_VECTOR (15 downto 0);
					pc_clk : in STD_LOGIC;
					pc_rst : in STD_LOGIC
				);
end component;

component pc_adder is
	 Port ( 
				pc_adder_in : in  STD_LOGIC_VECTOR (15 downto 0);
				pc_adder_out : out  STD_LOGIC_VECTOR (15 downto 0)
			);
end component;

component RAM1 is
	port(
			OE : out std_logic;
			WE : out std_logic;
			EN : out std_logic;
			ramAddr : out std_logic_vector(17 downto 0);
			data : inout std_logic_vector(15 downto 0);
			SerialPort: inout std_logic_vector(9 downto 0);
			instruction_addr : in std_logic_vector(15 downto 0);
			instruction : out std_logic_vector(15 downto 0);
			clk: in std_logic
			);
end component;

component if_id is
    Port (
				if_id_pc_in : in  STD_LOGIC_VECTOR (15 downto 0);
				if_id_instruction_in : in  STD_LOGIC_VECTOR (15 downto 0);
				if_id_pc_out : out  STD_LOGIC_VECTOR (15 downto 0);
				if_id_instruction_out : out  STD_LOGIC_VECTOR (15 downto 0);
				if_id_clk50 : in  STD_LOGIC;
				if_id_clean : in  STD_LOGIC;
				if_id_pause : in  STD_LOGIC
			);
end component;

component decoder is
port
	(
		switch : in std_logic_vector(15 downto 0);
		instruction_now : in std_logic_vector(15 downto 0);
		rx : out std_logic_vector(3 downto 0);
		ry : out std_logic_vector(3 downto 0);
		rz : out std_logic_vector(3 downto 0);
		imm : out std_logic_vector(15 downto 0);
		aluOP : out std_logic_vector(3 downto 0);
		mux3_control : out std_logic_vector(1 downto 0);
		mux6_control : out std_logic_vector(1 downto 0);
		ram2_write_out : out std_logic;
		ram2_read_out : out std_logic
	);
end component;

component allRegister is
	port
	(
		read_rx: in std_logic_vector(3 downto 0);
		read_ry: in std_logic_vector(3 downto 0);
		write_io: in std_logic;
		write_data: in std_logic_vector(15 downto 0);
		write_rz: in std_logic_vector(3 downto 0);
		rx_data: out std_logic_vector(15 downto 0);
		ry_data: out std_logic_vector(15 downto 0);
		clk: in std_logic
	);
end component;

component pc_immediate_adder is
	port (
				pc_immediate_adder_pc_in : in std_logic_vector(15 downto 0);
				pc_immediate_adder_imm_in : in std_logic_vector(15 downto 0);
				pc_immediate_adder_result : out std_logic_vector(15 downto 0)
			);			
end component;

component data_adventure is
	port (
				data_adventure_instruction_in : in std_logic_vector(15 downto 0);
				data_adventure_rxNumber_in : in std_logic_vector(3 downto 0);
				data_adventure_ryNumber_in : in std_logic_vector(3 downto 0);
				data_adventure_rzNumber_in : in std_logic_vector(3 downto 0);
				if_id_pause_control : out std_logic;
				id_exe_pause_control : out std_logic;
				mem_wb_pause_control :  out std_logic;
				data_adventure_mux2 : out std_logic_vector(1 downto 0);
				data_adventure_mux5 : out std_logic_vector(1 downto 0)
			);
end component;

component data_relate is
	port (
				data_relate_rxNumber_in : in std_logic_vector(3 downto 0);
				data_relate_ryNumber_in : in std_logic_vector(3 downto 0);
				data_relate_rzNumber_in : in std_logic_vector(3 downto 0);
				data_relate_mux1_out : out std_logic_vector(1 downto 0);
				data_relate_mux4_out : out std_logic_vector(1 downto 0)
			);
end component;

component id_exe is
	port (
				id_exe_pc_in : in std_logic_vector(15 downto 0);
				id_exe_pc_out : out std_logic_vector(15 downto 0);
				id_exe_instruction_in : in std_logic_vector(15 downto 0);
				id_exe_instruction_out : out std_logic_vector(15 downto 0);
				id_exe_immediate_in : in std_logic_vector(15 downto 0);
				id_exe_immediate_out : out std_logic_vector(15 downto 0);
				id_exe_pcAddImm_in : in std_logic_vector(15 downto 0);
				id_exe_pcAddImm_out : out std_logic_vector(15 downto 0);
				id_exe_rx_in : in std_logic_vector(15 downto 0);
				id_exe_rx_out : out std_logic_vector(15 downto 0);
				id_exe_ry_in : in std_logic_vector(15 downto 0);
				id_exe_ry_out : out std_logic_vector(15 downto 0);
				id_exe_rz_in : in std_logic_vector(15 downto 0);
				id_exe_rz_out : out std_logic_vector(15 downto 0);
				id_exc_aluOP_in : in std_logic_vector(3 downto 0);
				id_exe_aluOP_out : out std_logic_vector(3 downto 0);
				id_exe_memWrite_in : in std_logic;
				id_exe_memWrite_out : out std_logic;
				id_exe_memRead_in : in std_logic;
				id_exe_memRead_out : out std_logic;
				id_exe_clean : in std_logic;
				id_exe_pause : in std_logic;
				id_exe_clk50 : in std_logic; 
				id_exe_mux1_in : in std_logic_vector(1 downto 0);
				id_exe_mux1_out : out std_logic_vector(1 downto 0);
				id_exe_mux2_in : in std_logic_vector(1 downto 0);
				id_exe_mux2_out : out std_logic_vector(1 downto 0);
				id_exe_mux3_in : in std_logic_vector(1 downto 0);
				id_exe_mux3_out : out std_logic_vector(1 downto 0);
				id_exe_mux4_in : in std_logic_vector(1 downto 0);
				id_exe_mux4_out : out std_logic_vector(1 downto 0);
				id_exe_mux5_in : in std_logic_vector(1 downto 0);
				id_exe_mux5_out : out std_logic_vector(1 downto 0);
				id_exe_mux6_in : in std_logic_vector(1 downto 0);
				id_exe_mux6_out : out std_logic_vector(1 downto 0));
end component;	

component mux1 is
	port (	
				mux1_rx_in : in std_logic_vector(15 downto 0);
				mux1_aluResult_in : in std_logic_vector(15 downto 0);
				mux1_result_out : out std_logic_vector(15 downto 0);
				mux1_control_in : in std_logic_vector(1 downto 0)
			);
end component;

component mux2 is
	port (
				mux2_mux1Result_in : in std_logic_vector(15 downto 0);
				mux2_writeBackData_in : in std_logic_vector(15 downto 0);
				mux2_result_out : out std_logic_vector(15 downto 0);
				mux2_control_in : in std_logic_vector(1 downto 0)
			);
end component;

component mux3 is
	port (
				mux3_mux2Result_in : in std_logic_vector(15 downto 0);
				mux3_immediate_in : in std_logic_vector(15 downto 0);
				mux3_result_out : out std_logic_vector(15 downto 0);
				mux3_control_in : in std_logic_vector(1 downto 0)
			);
end component;

component mux4 is
	port (
				mux4_aluResult_in : in std_logic_vector(15 downto 0);
				mux4_rx_in : in std_logic_vector(15 downto 0);
				mux4_result_out : in std_logic_vector(15 downto 0);
				mux4_control_in : in std_logic_vector(1 downto 0)
			);
end component;

component mux5 is
	port (
				mux5_mux4Resulr_in : in std_logic_vector(15 downto 0);
				mux5_writeBackData_in : in std_logic_vector(15 downto 0);
				mux5_result_out : out std_logic_vector(15 downto 0);
				mux5_control_in : in std_logic_vector(1 downto 0)
			);
end component;

component alu is
	port
	(
		alu_op : in std_logic_vector(3 downto 0);
		alu_output : out std_logic_vector(15 downto 0);
		alu_x : in std_logic_vector(15 downto 0);
		alu_y : in std_logic_vector(15 downto 0);
		alu_jump_flag : out std_logic;
		clk: in std_logic
	);
end component;

component control_adventure is
	port ( 
				control_adventure_pcAddImm_in : in std_logic_vector(15 downto 0);
				control_adventure_pcAddImm_out : out std_logic_vector(15 downto 0);
				control_adventure_zeroFlag_in : in std_logic;
				control_adventure_instruction :  in std_logic_vector(15 downto 0);
				control_adventure_mux7 : out std_logic_vector(1 downto 0);
				control_adventure_if_id_clean : out std_logic;
				control_adventure_id_exe_clean : out std_logic				
			);	
end component;

component exe_mem is
	port (
				exe_mem_pc_in : in std_logic_vector(15 downto 0);
				exe_mem_pc_out : out std_logic_vector(15 downto 0);
				exe_mem_instruction_in : in std_logic_vector(15 downto 0);
				exe_mem_instruction_out : out std_logic_vector(15 downto 0);
				exe_mem_ry_in : in std_logic_vector(15 downto 0);
				exe_mem_ry_out : out std_logic_vector(15 downto 0);
				exe_mem_rz_in : in std_logic_vector(15 downto 0);
				exe_mem_rz_out : out std_logic_vector(15 downto 0);
				exe_mem_aluResult_in : in std_logic_vector(15 downto 0);
				exe_mem_aluResult_out : out std_logic_vector(15 downto 0);
				exe_mem_memWrite_in : in std_logic;
				exe_mem_memWrite_out : out std_logic;
				exe_mem_memRead_in : in std_logic;
				exe_mem_memRead_out : out std_logic;
				exe_mem_mux6_in : in std_logic_vector(1 downto 0);
				exe_mem_mux6_out : out std_logic_vector(1 downto 0);
				exe_mem_clk50 : in std_logic
			);		
end component;


----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
begin



end Behavioral;

