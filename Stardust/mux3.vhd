----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:58:41 01/09/2018 
-- Design Name: 
-- Module Name:    mux3 - Behavioral 
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

entity mux3 is
	port (
				mux3_mux2Result_in : in std_logic_vector(15 downto 0);
				mux3_immediate_in : in std_logic_vector(15 downto 0);
				mux3_result_out : out std_logic_vector(15 downto 0);
				mux3_control_in : in std_logic_vector(1 downto 0)
			);
end mux3;

architecture Behavioral of mux3 is

begin

process(mux3_mux2Result_in,mux3_immediate_in,mux3_control_in)

begin
	if(mux3_control_in = "01")then
		mux3_result_out <= mux3_mux2Result_in;
	elsif(mux3_control_in = "10")then
		mux3_result_out <= mux3_immediate_in;
	else
		null;
	end if;

end process;

end Behavioral;

