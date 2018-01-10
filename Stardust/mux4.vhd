----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:04:22 01/09/2018 
-- Design Name: 
-- Module Name:    mux4 - Behavioral 
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

entity mux4 is
	port (
				mux4_aluResult_in : in std_logic_vector(15 downto 0);
				mux4_rx_in : in std_logic_vector(15 downto 0);
				mux4_result_out : in std_logic_vector(15 downto 0);
				mux4_control_in : in std_logic_vector(1 downto 0)
			);
end mux4;

architecture Behavioral of mux4 is

begin

process(mux4_aluResult_in,mux4_rx_in,mux4_result_out)
begin
	if (mux4_control_in = "01")then
		mux4_result_out <= mux4_aluResult_in;
	elsif (mux4_control_in = "10")then
		mux4_result_out <= mux4_aluResult_in;
	else
		null;
	end if;
end process;

end Behavioral;

