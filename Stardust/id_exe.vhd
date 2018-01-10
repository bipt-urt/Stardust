----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:50:51 01/06/2018 
-- Design Name: 
-- Module Name:    id_exe - Behavioral 
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

entity id_exe is
	port (
				id_exe_pc_in : in std_logic_vector(15 downto 0);
				id_exe_pc_out : out std_logic_vector(15 downto 0);
				id_exe_instruction_in : in std_logic_vector(15 downto 0);
				id_exe_instruction_out : out std_logic_vector(15 downto 0);
				id_exe_immediate_in : in std_logic_vector(15 downto 0);
				id_exe_immediate_out : out std_logic_vector(15 downto 0);
				id_exe_pcAddImm_in : in std_logic_vector(15 downto 0);
				id_exe_pcAddImm_out : out std_logic_vector(15 downto 0);
				id_exe_rx_in : in std_logic_vector(15 downto 0);
				id_exe_rx_out : out std_logic_vector(15 downto 0);
				id_exe_ry_in : in std_logic_vector(15 downto 0);
				id_exe_ry_out : out std_logic_vector(15 downto 0);
				id_exe_rz_in : in std_logic_vector(15 downto 0);
				id_exe_rz_out : out std_logic_vector(15 downto 0);
				id_exc_aluOP_in : in std_logic_vector(3 downto 0);
				id_exe_aluOP_out : out std_logic_vector(3 downto 0);
				id_exe_memWrite_in : in std_logic;
				id_exe_memWrite_out : out std_logic;
				id_exe_memRead_in : in std_logic;
				id_exe_memRead_out : out std_logic;
				id_exe_clean : in std_logic;
				id_exe_pause : in std_logic;
				id_exe_clk50 : in std_logic; 
				id_exe_mux1_in : in std_logic_vector(1 downto 0);
				id_exe_mux1_out : out std_logic_vector(1 downto 0);
				id_exe_mux2_in : in std_logic_vector(1 downto 0);
				id_exe_mux2_out : out std_logic_vector(1 downto 0);
				id_exe_mux3_in : in std_logic_vector(1 downto 0);
				id_exe_mux3_out : out std_logic_vector(1 downto 0);
				id_exe_mux4_in : in std_logic_vector(1 downto 0);
				id_exe_mux4_out : out std_logic_vector(1 downto 0);
				id_exe_mux5_in : in std_logic_vector(1 downto 0);
				id_exe_mux5_out : out std_logic_vector(1 downto 0);
				id_exe_mux6_in : in std_logic_vector(1 downto 0);
				id_exe_mux6_out : out std_logic_vector(1 downto 0));
end id_exe;	
				
architecture Behavioral of id_exe is
signal id_exe_pc_temp,id_exe_instruction_temp : std_logic_vector(15 downto 0):="0000000000000000";
signal id_exe_immediate_temp,id_exe_rx_temp : std_logic_vector(15 downto 0):="0000000000000000";
signal id_exe_ry_temp,id_exe_rz_temp,id_exe_pcAddImm_temp : std_logic_vector(15 downto 0):="0000000000000000";
signal id_exe_aluOP_temp : std_logic_vector(3 downto 0):="0000";
signal id_exe_memWrite_temp,id_exe_memRead_temp : std_logic:='0';
signal id_exe_mux1_temp,id_exe_mux2_temp : std_logic_vector:="00";
signal id_exe_mux3_temp,id_exe_mux4_temp : std_logic_vector:="00";
signal id_exe_mux5_temp,id_exe_mux6_temp : std_logic_vector:="00";
begin

process(clk50,id_exe_clean)
begin
	if(id_exe_clean = '0')then
		id_exe_pc_temp <= id_exe_pc_in;
		id_exe_instruction_temp <= id_exe_instruction_in;
		id_exe_immediate_temp <= id_exe_immediate_in;
		id_exe_rx_temp <= id_exe_rx_in;
		id_exe_ry_temp <= id_exe_ry_in;
		id_exe_rz_temp <= id_exe_rz_in;
		id_exe_aluOP_temp <= id_exc_aluOP_in;
		id_exe_memWrite_temp <= id_exe_memWrite_in;
		id_exe_memRead_temp <= id_exe_memRead_in;
		id_exe_mux1_temp <= id_exe_mux1_in;
		id_exe_mux2_temp <= id_exe_mux2_in;
		id_exe_mux3_temp <= id_exe_mux3_in;
		id_exe_mux4_temp <= id_exe_mux4_in;
		id_exe_mux5_temp <= id_exe_mux5_in;
		id_exe_mux6_temp <= id_exe_mux6_in;
		id_exe_pcAddImm_temp <= id_exe_pcAddImm_in;
	else
		id_exe_pc_temp <= "0000000000000000";
		id_exe_instruction_temp <= "0000000000000000";
		id_exe_immediate_temp <= "0000000000000000";
		id_exe_rx_temp <= "0000000000000000";
		id_exe_ry_temp <= "0000000000000000";
		id_exe_rz_temp <= "0000000000000000";
		id_exe_aluOP_temp <= "0000";
		id_exe_memWrite_temp <= '0';
		id_exe_memRead_temp <= '0';
		id_exe_mux1_temp <= "00";
		id_exe_mux2_temp <= "00";
		id_exe_mux3_temp <= "00";
		id_exe_mux4_temp <= "00";
		id_exe_mux5_temp <= "00";
		id_exe_mux6_temp <= "00";
		id_exe_pcAddImm_temp <= "0000000000000000";
	end if;
end process;

process(id_exe_clean,id_exe_pause)
begin
	if(id_exe_clean='1' and id_exe_pause='0')then
		id_exe_pc_out <= "0000000000000000";
		id_exe_instruction_out <= "0000000000000000";
		id_exe_immediate_out <= "0000000000000000";
		id_exe_rx_out <= "0000000000000000";
		id_exe_ry_out <= "0000000000000000";
		id_exe_rz_out <= "0000000000000000";
		id_exe_aluOP_out <= "0000";
		id_exe_memWrite_out <= '0';
		id_exe_memRead_out <= '0';
		id_exe_mux1_out <= "00";
		id_exe_mux2_out <= "00";
		id_exe_mux3_out <= "00";
		id_exe_mux4_out <= "00";
		id_exe_mux5_out <= "00";
		id_exe_mux6_out <= "00";
		id_exe_pcAddImm_out <= "0000000000000000";
	elsif(id_exe_clean='0' and id_exe_pause='1')then
		null;
	elsif(id_exe_clean='0' and id_exe_pause='0')then
		id_exe_pc_out <= id_exe_pc_temp;
		id_exe_instruction_out <= id_exe_instruction_temp;
		id_exe_immediate_out <= id_exe_immediate_temp;
		id_exe_rx_out <= id_exe_rx_temp;
		id_exe_ry_out <= id_exe_ry_temp;
		id_exe_rz_out <= id_exe_rz_temp;
		id_exe_aluOP_out <= id_exe_aluOP_temp;
		id_exe_memWrite_out <= id_exe_memWrite_temp;
		id_exe_memRead_out <= id_exe_memRead_temp;
		id_exe_mux1_out <= id_exe_mux1_temp;
		id_exe_mux2_out <= id_exe_mux2_temp;
		id_exe_mux3_out <= id_exe_mux3_temp;
		id_exe_mux4_out <= id_exe_mux4_temp;
		id_exe_mux5_out <= id_exe_mux5_temp;
		id_exe_mux6_out <= id_exe_mux6_temp;
		id_exe_pcAddImm_out <= id_exe_pcAddImm_temp;
	else
		null;
	end if;
end process;
end Behavioral;

