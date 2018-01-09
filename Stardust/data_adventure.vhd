----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:51:09 01/08/2018 
-- Design Name: 
-- Module Name:    data_adventure - Behavioral 
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

entity data_adventure is
	port (
				data_adventure_instruction_in : in std_logic_vector(15 downto 0);
				data_adventure_rxNumber_in : in std_logic_vector(3 downto 0);
				data_adventure_ryNumber_in : in std_logic_vector(3 downto 0);
				data_adventure_rzNumber_in : in std_logic_vector(3 downto 0);
				if_id_pause_control : out std_logic;
				id_exe_pause_control : out std_logic;
				mem_wb_pause_control :  out std_logic;
				data_adventure_mux2 : out std_logic_vector(1 downto 0);
				data_adventure_mux5 : out std_logic_vector(1 downto 0)
			);
end data_adventure;

architecture Behavioral of data_adventure is

begin
process(data_adventure_instruction_in)
variable instruction_temp1,instruction_temp2 : std_logic_vector(15 downto 0):="0000000000000000";
variable rx_temp1,ry_temp1,rz_temp1 : std_logic_vector(3 downto 0) :="0000";
variable rx_temp2,ry_temp2,rz_temp2 : std_logic_vector(3 downto 0) :="0000";
begin
	if(instruction(15 downto 11) = "10011" or instruction(15 downto 11) = "10010")then
			if(rx_temp2 = data_adventure_rxNumber_in)then
				data_adventure_mux2 <= "10";--选择内存读出来的数据
				data_adventure_mux5 <= "01";--多路选择器出来的值
				if_id_pause_control <= '1';
				id_exe_pause_control <= '1';
				mem_wb_pause_control <= '1';
				rx_temp2 := rx_temp1;
				ry_temp2 := ry_temp1;
				rz_temp2 := rz_temp1;
				rx_temp1 := data_adventure_rxNumber_in;
				ry_temp1 := data_adventure_ryNumber_in;
				rz_temp2 := data_adventure_rzNumber_in;
			elsif(ry_temp2 = data_adventure_ryNumber_in)then
				data_adventure_mux2 <= "01";--多路选择器出来的值
				data_adventure_mux5 <= "10";--选择内存读出来的数据
				if_id_pause_control <= '1';
				id_exe_pause_control <= '1';
				mem_wb_pause_control <= '1';
				rx_temp2 := rx_temp1;
				ry_temp2 := ry_temp1;
				rz_temp2 := rz_temp1;
				rx_temp1 := data_adventure_rxNumber_in;
				ry_temp1 := data_adventure_ryNumber_in;
				rz_temp2 := data_adventure_rzNumber_in;
			end if;
	else
			if(rx_temp2 = data_adventure_rxNumber_in)then
				data_adventure_mux2 <= "10";--选择内存读出来的数据
				data_adventure_mux5 <= "01";--多路选择器出来的值
				if_id_pause_control <= '0';
				id_exe_pause_control <= '0';
				mem_wb_pause_control <= '0';
				rx_temp2 := rx_temp1;
				ry_temp2 := ry_temp1;
				rz_temp2 := rz_temp1;
				rx_temp1 := data_adventure_rxNumber_in;
				ry_temp1 := data_adventure_ryNumber_in;
				rz_temp2 := data_adventure_rzNumber_in;
			elsif(ry_temp2 = data_adventure_ryNumber_in)then
				data_adventure_mux2 <= "01";--多路选择器出来的值
				data_adventure_mux5 <= "10";--选择内存读出来的数据
				if_id_pause_control <= '0';
				id_exe_pause_control <= '0';
				mem_wb_pause_control <= '0';
				rx_temp2 := rx_temp1;
				ry_temp2 := ry_temp1;
				rz_temp2 := rz_temp1;
				rx_temp1 := data_adventure_rxNumber_in;
				ry_temp1 := data_adventure_ryNumber_in;
				rz_temp2 := data_adventure_rzNumber_in;
			else
				data_adventure_mux2 <= "01";--多路选择器出来的值
				data_adventure_mux5 <= "01";--选择内存读出来的数据
				if_id_pause_control <= '0';
				id_exe_pause_control <= '0';
				mem_wb_pause_control <= '0';
				rx_temp2 := rx_temp1;
				ry_temp2 := ry_temp1;
				rz_temp2 := rz_temp1;
				rx_temp1 := data_adventure_rxNumber_in;
				ry_temp1 := data_adventure_ryNumber_in;
				rz_temp2 := data_adventure_rzNumber_in;
			end if;
	end if;
end process;
end Behavioral;

