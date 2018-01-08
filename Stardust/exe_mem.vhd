----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:09:26 01/07/2018 
-- Design Name: 
-- Module Name:    exe_mem - Behavioral 
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

entity exe_mem is
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
				
end exe_mem;

architecture Behavioral of exe_mem is
signal exe_mem_pc_temp,exe_mem_instruction_temp : std_logic_vector(15 downto 0):="0000000000000000";
signal exe_mem_ry_temp,exe_mem_rz_temp : std_logic_vector(15 downto 0):="0000000000000000";
signal exe_mem_aluResult_temp : std_logic_vector(15 downto 0):="0000000000000000";
signal exe_mem_memWrite_temp,exe_mem_memRead_temp : std_logic:='0';
signal exe_mem_mux6_temp : std_logic_vector(1 downto 0):="00";
begin
process(clk50)
begin
	exe_mem_pc_temp <= exe_mem_pc_in;
	exe_mem_instruction_temp <= exe_mem_instruction_in;
	exe_mem_ry_temp <= exe_mem_ry_in;
	exe_mem_rz_temp <= exe_mem_rz_in;
	exe_mem_aluResult_temp <= exe_mem_aluResult_in;
	exe_mem_memWrite_temp <= exe_mem_memWrite_in;
	exe_mem_memRead_temp <= exe_mem_memRead_in;
	exe_mem_mux6_temp <= exe_mem_mux6_in;
end process;

process(clk50)
begin
	exe_mem_pc_out <= exe_mem_pc_temp;
	exe_mem_instruction_out <= exe_mem_instruction_temp;
	exe_mem_ry_out <= exe_mem_ry_temp;
	exe_mem_rz_out <= exe_mem_rz_temp;
	exe_mem_aluResult_out <= exe_mem_aluResult_temp;
	exe_mem_memWrite_out <= exe_mem_memWrite_temp;
	exe_mem_memRead_out <= exe_mem_memRead_temp;
	exe_mem_mux6_out <= exe_mem_mux6_temp;
end process;

end Behavioral;

