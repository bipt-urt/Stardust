library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity decoder is
	port
	(
		switch: in std_logic_vector(15 downto 0);
		led: out std_logic_vector(0 to 15)
	);
end decoder;

architecture behavioral of decoder is
	signal instruction: std_logic_vector(15 downto 0);
	-- GPRs and other registers
	-- 0000-0111 Genernal Proporse Registers
	-- 1000 T Signal Register
	-- 1001 IH Int Halt Register
	-- 1010 RA Return Value Register
	-- 1011 SP Stack Point Register
	signal rx: std_logic_vector(3 downto 0);
	signal ry: std_logic_vector(3 downto 0);
	signal rz: std_logic_vector(3 downto 0); -- Used for writeback value
	signal imm: std_logic_vector(15 downto 0);
	signal halt: std_logic := '1'; -- 0 for halt
	signal error_number: std_logic_vector(15 downto 0) := "0000000000000000"; -- Error Number
begin

process(switch)
	variable instruction_now: std_logic_vector(15 downto 0);
begin
	instruction <= switch;
	instruction_now := switch;
	if (instruction_now(15 downto 11) = "00000") then
		-- ADDSP3 00000xxxiiiiiiii
		rx <= "0" & instruction_now(10 downto 8);
		if (instruction_now(7) = '1') then -- Signed ext to imm
			imm <= "11111111" & instruction_now(7 downto 0);
		else
			imm <= "00000000" & instruction_now(7 downto 0);
		end if;
	elsif (instruction_now(15 downto 11) = "00001") then
		if (instruction_now(10 downto 0) = "00000000000") then
			-- NOP
		else
			-- Error
		end if;
	elsif (instruction_now(15 downto 11) = "00010") then
		-- B 00010iiiiiiiiiii
		if (instruction_now(10) = '1') then --Signed ext to imm
			imm <= "11111" & instruction_now(10 downto 0);
		else
			imm <= "00000" & instruction_now(10 downto 0);
		end if;
	elsif (instruction_now(15 downto 11) = "00100") then
		-- BEQZ 00100xxxiiiiiiii
		rx <= "0" & instruction_now(10 downto 8);
		if (instruction_now(7) = '1') then
			imm <= "11111111" & instruction_now(7 downto 0);
		else
			imm <= "00000000" & instruction_now(7 downto 0);
		end if;
	elsif (instruction_now(15 downto 11) = "00101") then
		-- BNEZ 00101xxxiiiiiiii
		rx <= "0" & instruction_now(10 downto 8);
		if (instruction_now(7) = '1') then
			imm <= "11111111" & instruction_now(7 downto 0);
		else
			imm <= "00000000" & instruction_now(7 downto 0);
		end if;
	elsif (instruction_now(15 downto 11) = "00110") then
		-- SLL 00110xxxyyyiii00
		-- SRL 00110xxxyyyiii10
		-- SRA 00110xxxyyyiii11
		rz <= "0" & instruction_now(10 downto 8);
		rx <= "0" & instruction_now(7 downto 5); -- ALU Shift Number
		if (instruction_now(4 downto 2) = "000") then
			imm <= "0000000000001000";
		else
			imm <= "0000000000000" & instruction_now(4 downto 2);
		end if;
	elsif (instruction_now(15 downto 11) = "01000") then
		-- ADDIU3 01000xxxyyy0iiii
		rx <= "0" & instruction_now(10 downto 8);
		if (instruction_now(3) = '1') then
			imm <= "111111111111" & instruction_now(3 downto 0);
		else
			imm <= "000000000000" & instruction_now(3 downto 0);
		end if;
		rz <= "0" & instruction_now(7 downto 5);
	elsif (instruction_now(15 downto 11) = "01001") then
		-- ADDIU 01001xxxiiiiiiii
		rx <= "0" & instruction_now(10 downto 8);
		if (instruction_now(7) = '1') then
			imm <= "11111111" & instruction_now(7 downto 0);
		else
			imm <= "00000000" & instruction_now(7 downto 0);
		end if;
		rz <= "0" & instruction_now(10 downto 8);
	elsif (instruction_now(15 downto 11) = "01010") then
		-- SLTI 01010xxxiiiiiiii
		rx <= "0" & instruction_now(10 downto 8);
		rz <= "1000"; -- Signal register T
		if (instruction_now(7) = '1') then
			imm <= "11111111" & instruction_now(7 downto 0);
		else
			imm <= "00000000" & instruction_now(7 downto 0);
		end if;
	elsif (instruction_now(15 downto 11) = "01011") then
		-- SLTUI 01011xxxiiiiiiii
		rx <= "0" & instruction_now(10 downto 8);
		rz <= "1000"; --Signal register T
		imm <= "00000000" & instruction_now(7 downto 0);
	elsif (instruction_now(15 downto 11) = "01100") then
		if (instruction_now(10 downto 8) = "011") then
			-- ADDSP 01100011iiiiiiii
			if (instruction_now(7) = '1') then
				imm <= "11111111" & instruction_now(7 downto 0);
			else
				imm <= "00000000" & instruction_now(7 downto 0);
			end if;
			rx <= "1001"; -- Stack Point Register
			rz <= "1001"; -- Stack Point Register
		elsif (instruction_now(10 downto 8) = "000") then
			-- BTEQZ 01100000iiiiiiii
			if (instruction_now(7) = '1') then -- Immediate in BTEQZ is used for bias for PC
				imm <= "11111111" & instruction_now(7 downto 0);
			else
				imm <= "00000000" & instruction_now(7 downto 0);
			end if;
			rx <= "1000"; -- Signal Register T
			ry <= "1111"; -- NULL Register
		elsif (instruction_now(10 downto 8) = "001") then
			-- BTNEZ 01100001iiiiiiii
			if (instruction_now(7) = '1') then -- Immediate in BTEQZ is used for bias for PC
				imm <= "11111111" & instruction_now(7 downto 0);
			else
				imm <= "00000000" & instruction_now(7 downto 0);
			end if;
			rx <= "1000"; -- Signal Register T
			ry <= "1111"; -- NULL Register
		elsif (instruction_now(10 downto 8) = "100") then
			-- MTSP 01100100xxx00000
			rx <= "0" & instruction_now(7 downto 5);
			ry <= "1111"; -- NULL Register
			rz <= "1001"; -- Stack Point Register
		elsif (instruction_now(10 downto 8) = "010") then
			-- SW_RS 01100010iiiiiiii
			rx <= "1001"; -- Stack Point Register
			if (instruction_now(7) = '1') then
				imm <= "11111111" & instruction_now(7 downto 0);
			else
				imm <= "00000000" & instruction_now(7 downto 0);
			end if;
			ry <= "1010"; -- Return Value Register: used for content which would write to mem
		end if;
	elsif (instruction_now(15 downto 11) = "01101") then
		-- LI 01101xxxiiiiiiii
		rx <= "1111"; -- NULL Register
		imm <= "00000000" & instruction_now(7 downto 0);
		rz <= "0" & instruction_now(10 downto 8);
	elsif (instruction_now(15 downto 11) = "01110") then
		-- CMPI 01110xxxiiiiiiii
		rx <= "0" & instruction_now(10 downto 8);
		if (instruction_now(7) = '1') then
			imm <= "11111111" & instruction_now(7 downto 0);
		else
			imm <= "00000000" & instruction_now(7 downto 0);
		end if;
		rz <= "1000"; -- Signal Register T
	elsif (instruction_now(15 downto 11) = "01111") then
		-- MOVE 01111xxxyyy00000
		rx <= "0" & instruction_now(7 downto 5);
		ry <= "1111"; -- NULL Register
		rz <= "0" & instruction_now(10 downto 8);
	elsif (instruction_now(15 downto 11) = "10010") then
		-- LW_SP 10010xxxiiiiiiii
		rx <= "1001"; -- Stack Point Register
		if (instruction_now(7) = '1') then
			imm <= "11111111" & instruction_now(7 downto 0);
		else
			imm <= "00000000" & instruction_now(7 downto 0);
		end if;
		rz <= "0" & instruction_now(10 downto 8);
	elsif (instruction_now(15 downto 11) = "10011") then
		-- LW 10011xxxyyyiiiii
		rx <= "0" & instruction_now(10 downto 8);
		if (instruction_now(4) = '1') then
			imm <= "11111111111" & instruction_now(4 downto 0);
		else
			imm <= "00000000000" & instruction_now(4 downto 0);
		end if;
		rz <= "0" & instruction_now(7 downto 5);
	elsif (instruction_now(15 downto 11) = "11010") then
		-- SW_SP 11010xxxiiiiiiii
		rx <= "1001"; -- Stack Point Register
		if (instruction_now(7) = '1') then
			imm <= "11111111" & instruction_now(7 downto 0);
		else
			imm <= "00000000" & instruction_now(7 downto 0);
		end if;
		ry <= "0" & instruction_now(10 downto 8);
	elsif (instruction_now(15 downto 11) = "11011") then
		-- SW 11011xxxyyyiiiii
		rx <= "0" & instruction_now(10 downto 8);
		if (instruction_now(4) = '1') then
			imm <= "11111111111" & instruction_now(4 downto 0);
		else
			imm <= "00000000000" & instruction_now(4 downto 0);
		end if;
		ry <= "0" & instruction_now(7 downto 5);
	elsif (instruction_now(15 downto 11) = "11100") then
		if (instruction_now(1 downto 0) = "01") then
			-- ADDU 11100xxxyyyzzz01
			rx <= "0" & instruction_now(10 downto 8);
			ry <= "0" & instruction_now(7 downto 5);
			rz <= "0" & instruction_now(4 downto 2);
		elsif (instruction_now(1 downto 0) = "11") then
			-- SUBU 11100xxxyyyzzz11
			rx <= "0" & instruction_now(10 downto 8);
			ry <= "0" & instruction_now(7 downto 5);
			rz <= "0" & instruction_now(4 downto 2);
		end if;
	elsif (instruction_now(15 downto 11) = "11101") then
		if (instruction_now(4 downto 0) = "01100") then
			-- AND 11101xxxyyy01100
			rx <= "0" & instruction_now(10 downto 8);
			ry <= "0" & instruction_now(7 downto 5);
			rz <= "0" & instruction_now(10 downto 8);
		elsif (instruction_now(4 downto 0) = "01010") then
			-- CMP 11101xxxyyy01010
			rx <= "0" & instruction_now(10 downto 8);
			ry <= "0" & instruction_now(7 downto 5);
			rz <= "1000"; -- Signal Register T
		elsif (instruction_now(4 downto 0) = "01011") then
			-- NEG 11101xxxyyy01011
			rx <= "1111"; -- NULL Register
			ry <= "0" & instruction_now(7 downto 5);
			rz <= "0" & instruction_now(10 downto 8);
		elsif (instruction_now(4 downto 0) = "01111") then
			-- NOT 11101xxxyyy01111
			rx <= "0" & instruction_now(7 downto 5);
			rz <= "0" & instruction_now(10 downto 8);
		elsif (instruction_now(4 downto 0) = "01101") then
			-- OR 11101xxxyyy01101
			rx <= "0" & instruction_now(10 downto 8);
			ry <= "0" & instruction_now(7 downto 5);
			rz <= "0" & instruction_now(10 downto 8);
		elsif (instruction_now(4 downto 0) = "00100") then
			-- SLLV 11101xxxyyy00100
			rx <= "0" & instruction_now(7 downto 5);
			ry <= "0" & instruction_now(10 downto 8);
			rz <= "0" & instruction_now(7 downto 5);
		elsif (instruction_now(4 downto 0) = "00010") then
			-- SLT 11101xxxyyy00010
			rx <= "0" & instruction_now(10 downto 8);
			ry <= "0" & instruction_now(7 downto 5);
			rz <= "1000"; -- Signal Register T
		elsif (instruction_now(4 downto 0) = "00011") then
			-- SLTU 11101xxxyyy00011
			rx <= "0" & instruction_now(10 downto 8);
			ry <= "0" & instruction_now(7 downto 5);
			rz <= "1000"; -- Signal Register T
		elsif (instruction_now(4 downto 0) = "00111") then
			-- SRAV 11101xxxyyy00111
			rx <= "0" & instruction_now(7 downto 5);
			ry <= "0" & instruction_now(10 downto 8);
			rz <= "0" & instruction_now(7 downto 5);
		elsif (instruction_now(4 downto 0) = "00110") then
			-- SRLV 11101xxxyyy00110
			rx <= "0" & instruction_now(7 downto 5);
			ry <= "0" & instruction_now(10 downto 8);
			rz <= "0" & instruction_now(7 downto 5);
		elsif (instruction_now(4 downto 0) = "01110") then
			-- XOR 11101xxxyyy01110
			rx <= "0" & instruction_now(10 downto 8);
			ry <= "0" & instruction_now(7 downto 5);
			rz <= "0" & instruction_now(10 downto 8);
		end if;
	elsif (instruction_now(15 downto 11) = "11110") then
		if (instruction_now(7 downto 0) = "00000000") then
			-- MFIH 11110xxx00000000
			rx <= "1011"; -- IH Register
			ry <= "1111"; -- NULL Register
			rz <= "0" & instruction_now(10 downto 8);
		elsif (instruction_now(7 downto 0) = "00000001") then
			-- MTIH 11110xxx00000001
			rx <= "0" & instruction_now(10 downto 8);
			ry <= "1111"; -- NULL Register
			rz <= "1011"; -- IH Register
		end if;
	end if;
	led <= switch;
end process;

end behavioral;