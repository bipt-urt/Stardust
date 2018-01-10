----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:31:36 01/07/2018 
-- Design Name: 
-- Module Name:    mem_wb - Behavioral 
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

entity mem_wb is
	port (
				mem_wb_pc_in : in std_logic_vector(15 downto 0);
				mem_wb_pc_out : out std_logic_vector(15 downto 0);
				mem_wb_aluResult_in : in std_logic_vector(15 downto 0);
				mem_wb_aluResult_out : out std_logic_vector(15 downto 0);
				mem_wb_memData_in : in std_logic_vector(15 downto 0);
				mem_wb_memDdata_out : out std_logic_vector(15 downto 0);
				mem_wb_rz_in : in std_logic_vector(15 downto 0);
				mem_wb_rz_out : out std_logic_vector(15 downto 0);
				mem_wb_mux6_in : in std_logic_vector(1 downto 0);
				mem_wb_mux6_out : out std_logic_vector(1 downto 0);
				mem_wb_pause : in std_logic;
				mem_wb_clk50 : in std_logic
			);
end mem_wb;

architecture Behavioral of mem_wb is

signal mem_wb_pc_temp,mem_wb_aluResult_temp : std_logic_vector(15 downto 0):="0000000000000000";
signal mem_wb_memData_temp,mem_wb_rz_temp : std_logic_vector(15 downto 0):="0000000000000000";
signal mem_wb_mux6_temp : std_logic_vector(1 downto 0):="00";

begin

process(clk50)

begin
	mem_wb_pc_temp <= mem_wb_pc_in;
	mem_wb_aluResult_temp <= mem_wb_aluResult_in;
	mem_wb_memData_temp <= mem_wb_memData_in;
	mem_wb_rz_temp <= mem_wb_rz_in;
	mem_wb_mux6_temp <= mem_wb_mux6_in;
end process;

process(clk50,mem_wb_pause)
begin
	if(mem_wb_pause='0')then
		mem_wb_pc_out <= mem_wb_pc_temp - '1';
		mem_wb_aluResult_out <= mem_wb_aluResult_temp;
		mem_wb_memDdata_out <= mem_wb_memData_temp;
		mem_wb_rz_out <= mem_wb_rz_temp;
		mem_wb_mux6_out <= mem_wb_mux6_temp;
	else
		null;
	end if;
end process;
end Behavioral;

