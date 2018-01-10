----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:34:37 01/09/2018 
-- Design Name: 
-- Module Name:    mux5 - Behavioral 
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

entity mux5 is
	port (
				mux5_mux4Resulr_in : in std_logic_vector(15 downto 0);
				mux5_writeBackData_in : in std_logic_vector(15 downto 0);
				mux5_result_out : out std_logic_vector(15 downto 0);
				mux5_control_in : in std_logic_vector(1 downto 0)
			);
end mux5;

architecture Behavioral of mux5 is

begin

process(mux5_control_in,mux5_writeBackData_in,mux5_mux4Resulr_in)
begin
	if (mux5_control_in = "01")then
		mux5_result_out <= mux5_mux4Resulr_in;
	elsif (mux5_control_in = "10")then
		mux5_result_out <= mux5_writeBackData_in;
	else
		null;
	end if;
end process;
end Behavioral;

