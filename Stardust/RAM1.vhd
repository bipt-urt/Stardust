----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:16:21 01/03/2018 
-- Design Name: 
-- Module Name:    RAM1 - Behavioral 
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

entity RAM1 is
	port(
			OE : out std_logic;
			WE : out std_logic;
			EN : out std_logic;
			ramAddr : out std_logic_vector(17 downto 0);
			data : inout std_logic_vector(15 downto 0);
			SerialPort: inout std_logic_vector(9 downto 0);
			instruction_addr : in std_logic_vector(15 downto 0);
			instruction : out std_logic_vector(15 downto 0);
			clk: in std_logic);
end RAM1;

architecture Behavioral of RAM1 is
signal status:std_logic_vector(2 downto 0):="000";
begin

process(clk)
begin
	if(clk'event and clk='1' )then
		if (status="000")then
			data<="ZZZZZZZZZZZZZZZZ";
			Serialport<="ZZZZZZ1ZZZ";
			status<="001";
			OE<='0';
			EN<='0';
			WE<='1';
		elsif (status="001")then
			ramAddr<="00" & instruction_addr;
			status<="010";
		elsif(status="010")then
			instruction<=data;
			OE<='1';
			status<="000";
		end if;
	end if;
end process;
end Behavioral;

