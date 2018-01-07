----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:37:16 01/05/2018 
-- Design Name: 
-- Module Name:    pc - Behavioral 
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

entity pc is
    Port ( pc_in : in  STD_LOGIC_VECTOR (15 downto 0);
           pc_out : out  STD_LOGIC_VECTOR (15 downto 0);
			  pc_clk : in STD_LOGIC;
			  pc_rst : in STD_LOGIC);
end pc;

architecture Behavioral of pc is
signal pc_temp:std_logic_vector(15 downto 0):="0000000000000000";
begin
process(pc_in)
begin
	pc_temp<=pc_in;
end process;

process(pc_temp,pc_rst)
begin
	pc_out<=pc_temp;
end process;

end Behavioral;

