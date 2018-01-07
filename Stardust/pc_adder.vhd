----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:12:17 01/05/2018 
-- Design Name: 
-- Module Name:    pc_adder - Behavioral 
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pc_adder is
    Port ( pc_adder_in : in  STD_LOGIC_VECTOR (15 downto 0);
           pc_adder_out : out  STD_LOGIC_VECTOR (15 downto 0));
end pc_adder;

architecture Behavioral of pc_adder is

begin
process(pc_adder_in)
begin
	pc_adder_out<=pc_adder_in+'1';
end process;
end Behavioral;

