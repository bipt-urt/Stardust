----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:52:36 01/09/2018 
-- Design Name: 
-- Module Name:    mux7 - Behavioral 
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

entity mux7 is
	port (
				mux7_pcPlusOne_in : in std_logic_vector(15 downto 0);
				mux7_pcPlusImm_in : in std_logic_vector(15 downto 0);
				mux7_pcResult_out : out std_logic_vector(15 downto 0);
				mux7_control_in : in std_logic_vector(1 downto 0)
			);
end mux7;

architecture Behavioral of mux7 is

begin

process(mux7_control_in)
begin
	if(mux7_control_in = "01")then
		mux7_pcResult_out <= mux7_pcPlusOne_in;
	elsif(mux7_control_in = "10")then
		mux7_pcResult_out <= mux7_pcPlusImm_in;
	else
		null;
	end if;
end process;

end Behavioral;

