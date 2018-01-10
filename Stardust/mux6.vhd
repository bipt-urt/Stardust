----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:44:19 01/09/2018 
-- Design Name: 
-- Module Name:    mux6 - Behavioral 
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

entity mux6 is
	port (
				mux6_aluResult_in : in std_logic_vector(15 downto 0);
				mux6_memData_in : in std_logic_vector(15 downto 0);
				mux6_pc_in : in std_logic_vector(15 downto 0);
				mux6_writeBackData_out : in std_logic_vector(15 downto 0);
				mux6_control_in : in std_logic_vector(1 downto 0)
			);
end mux6;

architecture Behavioral of mux6 is

begin

process(mux6_control_in)
begin
	if(mux6_control_in = "01")then
		mux6_writeBackData_out <= mux6_aluResult_in;
	elsif (mux6_control_in = "01")then
		mux6_writeBackData_out <= mux6_memData_in;
	elsif (mux6_control_in = "11")then
		mux6_writeBackData_out <= mux6_pc_in;
	else
		null;
	end if;
end process;

end Behavioral;

