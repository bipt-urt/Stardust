----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:02:49 01/03/2018 
-- Design Name: 
-- Module Name:    RAM2 - Behavioral 
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

entity RAM2 is
	port(
			EN : out std_logic;
			WE : out std_logic;
			EN : out std_logic;
			writeSignal : in std_logic;
			readSignal : in std_logic;
			addr : in std_logic_vector(15 downto 0);
			ram2data : inout std_logic_vector(15 downto 0);
			ram2addr : out std_logic_vector(17 downto 0);
			indata : in std_logic_vector(15 downto 0);
			outdata : out std_logic_vector(15 downto 0));
			
end RAM2;

architecture Behavioral of RAM2 is
	signal status:std_logic_vector(2 downto 0):="000";
begin
process(clk)
begin
	if (clk'event and clk='1')then
		if( readSignal='1')then
			if(status="000")then
				ram2data<="ZZZZZZZZZZZZZZZZ";
				OE<='0';
				WE<='1';
				EN<='0';
				status<="001";
			elsif(status="001")then
				RAM2addr<="00" & addr;
				status<="010";
			elsif(status="010" )then
				outdata<=ram2data;
				status<="000";
				OE<='1';
				WE<='1';
				EN<='0';
			end if;
		elsif(writeSignal='0')then
			if(status="000")then
				ram2data<=indata;
				ram2addr<="00" & addr;
				OE<='1';
				WE<='1';
				EN<='0';
				status<="001";
			elsif(status="001")then
				OE<='1';
				WE<='0';
				EN<='0';
				status<="010";
			elsif(status="010")then
				OE<='1';
				WE<='1';
				EN<='0';
				status<="000";
			end if;
		end if;
	end if;
end process;

end Behavioral;

