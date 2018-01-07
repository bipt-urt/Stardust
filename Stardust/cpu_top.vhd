----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:55:50 01/05/2018 
-- Design Name: 
-- Module Name:    cpu_top - Behavioral 
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

entity cpu_top is
    Port ( top_clk_key : in  STD_LOGIC;
           top_clk50 : in  STD_LOGIC;
			  top_rst : in  STD_LOGIC;
           top_sw : in  STD_LOGIC_VECTOR (15 downto 0);
           top_ram1_data : inout  STD_LOGIC_VECTOR (15 downto 0);
           top_ram2_data : inout  STD_LOGIC_VECTOR (15 downto 0);
           top_ram1_en : out  STD_LOGIC;
           top_ram1_we : out  STD_LOGIC;
           top_ram1_oe : out  STD_LOGIC;
           top_ram2_en : out  STD_LOGIC;
           top_ram2_we : out  STD_LOGIC;
           top_ram2_oe : out  STD_LOGIC;
           top_led : out  STD_LOGIC_VECTOR (15 downto 0);
           top_ram1_addr : out  STD_LOGIC_VECTOR (17 downto 0);
           top_ram2_addr : out  STD_LOGIC_VECTOR (17 downto 0);
           top_left_dyp : out  STD_LOGIC_VECTOR (6 downto 0);
           top_rigth_dyp : out  STD_LOGIC_VECTOR (6 downto 0));
end cpu_top;

architecture Behavioral of cpu_top is



begin



end Behavioral;

