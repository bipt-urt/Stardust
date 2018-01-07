----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:50:51 01/06/2018 
-- Design Name: 
-- Module Name:    id_exe - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity id_exe is

end id_exe;
	port (
				id_exe_pc_in : std_logic_vector(15 downto 0);
				id_exe_pc_out : std_logic_vector(15 downto 0);
				id_exe_instrution_in : std_logic_vector(15 downto 0);
				id_exe_instrution_out : std_logic_vector(15 downto 0);
				id_exe_immediate_in : std_logic_vector(15 downto 0);
				id_exe_immediate_out : std_logic_vector(15 downto 0);
				id_exe_rx_in : std_logic_vector(15 downto 0);
				id_exe_rx_out : std_logic_vector(15 downto 0);
				id_exe_ry_in : std_logic_vector(15 downto 0);
				id_exe_ry_out : std_logic_vector(15 downto 0);
				id_exe_rz_in : std_logic_vector(15 downto 0);
				id_exe_rz_out : std_logic_vector(15 downto 0);
				id_exc_aluOP_in : std_logic_vector(3 downto 0);
				id_exe_aluOP_out : std_logic_vector(3 downto 0);
				id_exe_memWrite_in : std_logic;
				id_exe_memWrite_out : std_logic;
				id_exe_memRead_in : std_logic;
				id_exe_memRead_out : std_logic;
				id_exe_mux1_in : std_logic_vector(1 downto 0);
				id_exe_mux1_out : std_logic_vector(1 downto 0);
				id_exe_mux2_in : std_logic_vector(1 downto 0);
				id_exe_mux2_out : std_logic_vector(1 downto 0);
				id_exe_mux3_in : std_logic_vector(1 downto 0);
				id_exe_mux3_out : std_logic_vector(1 downto 0);
				id_exe_mux4_in : std_logic_vector(1 downto 0);
				id_exe_mux4_out : std_logic_vector(1 downto 0);
				id_exe_mux5_in : std_logic_vector(1 downto 0);
				id_exe_mux5_out : std_logic_vector(1 downto 0);
				id_exe_mux6_in : std_logic_vector(1 downto 0);
				id_exe_mux6_out : std_logic_vector(1 downto 0);
architecture Behavioral of id_exe is

begin


end Behavioral;

