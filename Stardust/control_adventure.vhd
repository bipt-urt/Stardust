----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:23:56 01/08/2018 
-- Design Name: 
-- Module Name:    control_adventure - Behavioral 
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

entity control_adventure is
	port ( 
				control_adventure_pcAddImm_in : in std_logic_vector(15 downto 0);
				control_adventure_pcAddImm_out : out std_logic_vector(15 downto 0);
				control_adventure_zeroFlag_in : in std_logic;
				control_adventure_instruction :  in std_logic_vector(15 downto 0);
				control_adventure_mux7 : out std_logic_vector(1 downto 0);
				control_adventure_if_id_clean : out std_logic;
				control_adventure_id_exe_clean : out std_logic
				
			);	
end control_adventure;

architecture Behavioral of control_adventure is

begin

process(control_adventure_zeroFlag_in,control_adventure_instruction)

begin
		
		if(control_adventure_instruction(15 downto 11) = "00100" or control_adventure_instruction(15 downto 11) = "10011")then
			if(control_adventure_zeroFlag_in = '1')then
				control_adventure_pcAddImm_out <= control_adventure_pcAddImm_in;
				control_adventure_if_id_clean <= '1';
				control_adventure_id_exe_clean <= '1';
				control_adventure_mux7 <= "10";--选择跳转的PC
			else
				control_adventure_if_id_clean <= '0';
				control_adventure_id_exe_clean <= '0';
				control_adventure_mux7 <= "01";--选择PC+1
			end if;
		elsif(control_adventure_instruction(15 downto 8) = "01100000" or control_adventure_instruction(15 downto 8) = "01100001")then
			if(control_adventure_zeroFlag_in = '1')then
				control_adventure_pcAddImm_out <= control_adventure_pcAddImm_in;
				control_adventure_if_id_clean <= '1';
				control_adventure_id_exe_clean <= '1';
				control_adventure_mux7 <= "10";--选择跳转的PC
			else
				control_adventure_if_id_clean <= '0';
				control_adventure_id_exe_clean <= '0';
				control_adventure_mux7 <= "01";--选择PC+1
			end if;
		else
			control_adventure_if_id_clean <= '0';
			control_adventure_id_exe_clean <= '0';
			control_adventure_mux7 <= "01";--选择PC+1
		end if;
end process;
end Behavioral;

