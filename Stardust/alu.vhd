-- dgideas@outlook.com
-- 2018.1
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity alu is
	port
	(
		alu_op : in std_logic_vector(3 downto 0);
		alu_output : out std_logic_vector(15 downto 0);
		alu_x : in std_logic_vector(15 downto 0);
		alu_y : in std_logic_vector(15 downto 0);
		alu_jump_flag : out std_logic;
		clk: in std_logic
	);
end alu;

architecture Behavioral of alu is

begin

process(clk)
	
begin
	
	if(alu_op = "0001") then
		-- Bitwise AND
		alu_output := alu_x AND alu_y;
		alu_jump_flag <= '0';
	elsif (alu_op = "0010") then
		-- Bitwise OR
		alu_output := alu_x OR alu_y;
		alu_jump_flag <= '0';
	elsif (alu_op = "0011") then
		-- Bitwise NOT
		alu_output := NOT alu_x;
		alu_jump_flag <= '0';
	elsif (alu_op = "0100") then
		-- Bitwise XOR
		alu_output := alu_x XOR alu_y;
		alu_jump_flag <= '0';
	elsif (alu_op = "0101") then
		-- Numeric +
		alu_output := alu_x + alu_y;
		alu_jump_flag <= '0';
	elsif (alu_op = "0110") then
		-- Numeric -
		alu_output := alu_x - alu_y;
		alu_jump_flag <= '0';
	elsif (alu_op = "0111") then
		-- is op_x zero
		if (alu_x = "00000000000000") then
			alu_output := "1111111111111111";
			alu_jump_flag <= '1';
		else
			alu_output := "0000000000000000";
			alu_jump_flag <= '0';
		end if;
	elsif (alu_op = "1000") then
		-- is op_x non zero
		if (alu_x = "00000000000000") then
			alu_output := "0000000000000000";
			alu_jump_flag <= '0';
		else
			alu_output := "1111111111111111";
			alu_jump_flag <= '1';
		end if;
	elsif (alu_op = "1001") then
		-- is op_x < op_y with signal
		if (alu_x(15) = alu_y(15)) then
			if (alu_x(15) = '0') then
				if (alu_x < alu_y) then
					alu_output := "1111111111111111";
				else
					alu_output := "0000000000000000";
				end if;
			else
				if (alu_x > alu_y) then
					alu_output := "1111111111111111";
				else
					alu_output := "0000000000000000";
				end if;
			end if;
		elsif (alu_x(15) = '1' and alu_y(15) = '0') then
			alu_output := "1111111111111111";
		elsif (alu_x(15) = '0' and alu_y(15) = '1') then
			alu_output := "0000000000000000";
		end if;
		alu_jump_flag <= '0';
	elsif (alu_op = "1010") then
		-- is op_x < op_y with unsigned
		if (alu_x < alu_y) then
			alu_output := "1111111111111111";
		else
			alu_output := "0000000000000000";
		end if;
		alu_jump_flag <= '0';
	elsif (alu_op = "1011") then
		-- SLL
		alu_output := to_stdlogicvector(to_bitvector(alu_x) sll conv_integer(alu_y));
		alu_jump_flag <= '0';
	elsif (alu_op = "1100") then
		-- SRL
		alu_output := to_stdlogicvector(to_bitvector(alu_x) srl conv_integer(alu_y));
		alu_jump_flag <= '0';
	elsif (alu_op = "1101") then
		-- SRA
		alu_output := to_stdlogicvector(to_bitvector(alu_x) sra conv_integer(alu_y));
		alu_jump_flag <= '0';
	elsif (alu_op = "1110") then
		-- is Equal
		if (alu_x = alu_y) then
			alu_output := "1111111111111111";
		else
			alu_output := "0000000000000000";
		end if;
		alu_jump_flag <= '0';
	end if;
end process;

end Behavioral;