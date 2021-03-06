----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:48:36 01/09/2018 
-- Design Name: 
-- Module Name:    mux1 - Behavioral 
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

entity mux1 is
	port (	
				mux1_rx_in : in std_logic_vector(15 downto 0);
				mux1_aluResult_in : in std_logic_vector(15 downto 0);
				mux1_result_out : out std_logic_vector(15 downto 0);
				mux1_control_in : in std_logic_vector(1 downto 0)
			);
end mux1;

architecture Behavioral of mux1 is

begin

process(mux1_control_in,mux1_aluResult_in,mux1_rx_in)

begin

	if(mux1_control_in = "01")then
		mux1_result_out <= mux1_rx_in;
	elsif(mux1_control_in = "10")then
		mux1_result_out <= mux1_aluResult_in;
	else
		null;
	end if;

end process;
end Behavioral;

