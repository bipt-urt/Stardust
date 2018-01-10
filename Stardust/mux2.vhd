----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:23:39 01/09/2018 
-- Design Name: 
-- Module Name:    mux2 - Behavioral 
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

entity mux2 is
	port (
				mux2_mux1Result_in : in std_logic_vector(15 downto 0);
				mux2_writeBackData_in : in std_logic_vector(15 downto 0);
				mux2_result_out : out std_logic_vector(15 downto 0);
				mux2_control_in : in std_logic_vector(1 downto 0)
			);
end mux2;

architecture Behavioral of mux2 is

begin

process(mux2_control_in,mux2_writeBackData_in,mux2_mux1Result_in)

begin

	if(mux2_control_in = "01")then
		mux2_result_out <= mux2_mux1Result_in;
	elsif(mux2_control_in = "10")then
		mux2_result_out <= mux2_writeBackData_in;
	else
		null;
	end if;
	
end process;

end Behavioral;

