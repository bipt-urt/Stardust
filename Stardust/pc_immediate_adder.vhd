----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:16:20 01/07/2018 
-- Design Name: 
-- Module Name:    pc_immediate_adder - Behavioral 
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

entity pc_immediate_adder is
	port (
				pc_immediate_adder_pc_in : in std_logic_vector(15 downto 0);
				pc_immediate_adder_imm_in : in std_logic_vector(15 downto 0);
				pc_immediate_adder_result : out std_logic_vector(15 downto 0)
			);			
end pc_immediate_adder;

architecture Behavioral of pc_immediate_adder is

begin
	pc_immediate_adder_result<=pc_immediate_adder_pc_in + pc_immediate_adder_imm_in;
end Behavioral;

