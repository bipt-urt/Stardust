----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:24:04 01/05/2018 
-- Design Name: 
-- Module Name:    ifid - Behavioral 
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

entity if_id is
    Port ( if_id_pc_in : in  STD_LOGIC_VECTOR (15 downto 0);
           if_id_instrution_in : in  STD_LOGIC_VECTOR (15 downto 0);
           if_id_pc_out : out  STD_LOGIC_VECTOR (15 downto 0);
           if_id_instrution_out : out  STD_LOGIC_VECTOR (15 downto 0);
           if_id_clk50 : in  STD_LOGIC;
           if_id_clean : in  STD_LOGIC;
           if_id_pause : in  STD_LOGIC);
end if_id;

architecture Behavioral of if_id is
signal if_id_pc_temp:std_logic_vector(15 downto 0):="0000000000000000";
signal if_id_instrution_temp:std_logic_vector(15 downto 0):="0000000000000000";
begin

process(if_id_clk50)
begin
	if_id_pc_temp<=if_id_pc_in;
	if_id_instrution_temp<=if_id_instrution_in;
end process;

process(if_id_clk50,if_id_clean,if_id_pause)
begin
	if(if_id_clean='1' and if_id_pause='0')then
		if_id_pc_out<="000000000000000";
		if_id_instrution_out<="0000000000000000";
	elsif(if_id_pause='0' and if_id_clean='0')then
		if_id_pc_out<=if_id_pc_temp;
		if_id_instrution_out<=if_id_instrution_temp;
	elsif(if_id_pause='1' and if_id_clean='0')then
		null;
	else
		null;
	end if;
end process;
end Behavioral;

