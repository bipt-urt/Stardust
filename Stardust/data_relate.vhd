----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:45:53 01/07/2018 
-- Design Name: 
-- Module Name:    data_relate - Behavioral 
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

entity data_relate is
	port (
				data_relate_rxNumber_in : in std_logic_vector(3 downto 0);
				data_relate_ryNumber_in : in std_logic_vector(3 downto 0);
				data_relate_rzNumber_in : in std_logic_vector(3 downto 0);
				data_relate_mux1_out : out std_logic_vector(1 downto 0);
				data_relate_mux4_out : out std_logic_vector(1 downto 0)
			);
end data_relate;

architecture Behavioral of data_relate is

begin

process(data_relate_rxNumber_in,data_relate_ryNumber_in,data_relate_rzNumber_in)
variable rxNumber_temp,ryNumber_temp,rzNumber_temp:std_logic_vector(3 downto 0):="0000";
begin
	if(rxNumber_temp = data_relate_rzNumber_in)then
		data_relate_mux1_out <= "01";--默认rx
		data_relate_mux4_out <= "10";--选择alu运算的结果
		rxNumber_temp := data_relate_rxNumber_in;
		ryNumber_temp := data_relate_ryNumber_in;
		rzNumber_temp := data_relate_rzNumber_in;
	elsif(ryNumber_temp = data_relate_rzNumber_in)then
		data_relate_mux1_out <= "10";--选择alu运算的结果
		data_relate_mux4_out <= "01";--默认ry
		rxNumber_temp := data_relate_rxNumber_in;
		ryNumber_temp := data_relate_ryNumber_in;
		rzNumber_temp := data_relate_rzNumber_in;
	else
		rxNumber_temp := data_relate_rxNumber_in;
		ryNumber_temp := data_relate_ryNumber_in;
		rzNumber_temp := data_relate_rzNumber_in;
	end if;
end process;

end Behavioral;

