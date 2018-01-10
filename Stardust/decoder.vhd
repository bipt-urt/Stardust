library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity decoder is
	port
	(
		switch : in std_logic_vector(15 downto 0);
		instruction_now : in std_logic_vector(15 downto 0);
		rx : out std_logic_vector(3 downto 0);
		ry : out std_logic_vector(3 downto 0);
		rz : out std_logic_vector(3 downto 0);
		imm : out std_logic_vector(15 downto 0);
		aluOP : out std_logic_vector(3 downto 0);
		mux3_control : out std_logic_vector(1 downto 0);
		mux6_control : out std_logic_vector(1 downto 0);
		ram2_write_out : out std_logic;
		ram2_read_out : out std_logic
	);
end decoder;

architecture behavioral of decoder is

begin

process(switch)
	
begin
	if (instruction_now(15 downto 11) = "00000") then
		-- ADDSP3 00000xxxiiiiiiii
		rz <= "0" & instruction_now(10 downto 8);
		rx <= "1001";
		ry <= "1110";
		mux3_control <= "10";
		mux6_control <= "01";
		ram2_write_out <= '0';
		ram2_read_out <= '0';
		aluOP <= "0101";
		if (instruction_now(7) = '1') then -- Signed ext to imm
			imm <= "11111111" & instruction_now(7 downto 0);
		else
			imm <= "00000000" & instruction_now(7 downto 0);
		end if;
	elsif (instruction_now(15 downto 11) = "00001") then
		if (instruction_now(10 downto 0) = "00000000000") then
			-- NOP
			rx <= "1110";
			ry <= "1110";
			rz <= "1110";
			imm <= "0000000000000000";
			mux3_control <= "00";
			mux6_control <= "00";
			ram2_write_out <= '0';
			ram2_read_out <= '0';
			aluOP <= "0000";			
		else
			-- Error
			null;
		end if;
	elsif (instruction_now(15 downto 11) = "00010") then
		-- B 00010iiiiiiiiiii
			rx <= "1110";
			ry <= "1110";
			rz <= "1110";
			imm <= "0000000000000000";
			mux3_control <= "00";
			mux6_control <= "00";
			ram2_write_out <= '0';
			ram2_read_out <= '0';
			aluOP <= "1110";			
		if (instruction_now(10) = '1') then --Signed ext to imm
			imm <= "11111" & instruction_now(10 downto 0);
		else
			imm <= "00000" & instruction_now(10 downto 0);
		end if;
	elsif (instruction_now(15 downto 11) = "00100") then
		-- BEQZ 00100xxxiiiiiiii
		rx <= "0" & instruction_now(10 downto 8);
		ry <= "1110";
		rz <= "1110";
		mux3_control <= "10";
		mux6_control <= "00";
		ram2_write_out <= '0';
		ram2_read_out <= '0';
		aluOP <= "0111";
		if (instruction_now(7) = '1') then
			imm <= "11111111" & instruction_now(7 downto 0);
		else
			imm <= "00000000" & instruction_now(7 downto 0);
		end if;
	elsif (instruction_now(15 downto 11) = "00101") then
		-- BNEZ 00101xxxiiiiiiii
		rx <= "0" & instruction_now(10 downto 8);
		ry <= "1110";
		rz <= "1110";
		mux3_control <= "10";
		mux6_control <= "00";
		ram2_write_out <= '0';
		ram2_read_out <= '0';
		aluOP <= "1000";
		if (instruction_now(7) = '1') then
			imm <= "11111111" & instruction_now(7 downto 0);
		else
			imm <= "00000000" & instruction_now(7 downto 0);
		end if;
	elsif (instruction_now(15 downto 11) = "00110") then
		-- SLL 00110xxxyyyiii00
		if (instruction_now(1 downto 0) = "00")then
			rz <= "0" & instruction_now(10 downto 8);
			rx <= "0" & instruction_now(7 downto 5); -- ALU Shift Number
			ry <= "1110";
			mux3_control <= "10";
			mux6_control <= "01";
			ram2_write_out <= '0';
			ram2_read_out <= '0';
			aluOP <= "1011";
			if (instruction_now(4 downto 2) = "000") then
				imm <= "0000000000001000";
			else
				imm <= "0000000000000" & instruction_now(4 downto 2);
			end if;
		-- SRL 00110xxxyyyiii10
		elsif (instruction_now(1 downto 0) = "10")then
			rz <= "0" & instruction_now(10 downto 8);
			rx <= "0" & instruction_now(7 downto 5); -- ALU Shift Number
			ry <= "1110";
			mux3_control <= "10";
			mux6_control <= "01";
			ram2_write_out <= '0';
			ram2_read_out <= '0';
			aluOP <= "1100";
			if (instruction_now(4 downto 2) = "000") then
				imm <= "0000000000001000";
			else
				imm <= "0000000000000" & instruction_now(4 downto 2);
			end if;
		-- SRA 00110xxxyyyiii11
		elsif (instruction_now(1 downto 0) = "11")then
			rz <= "0" & instruction_now(10 downto 8);
			rx <= "0" & instruction_now(7 downto 5); -- ALU Shift Number
			ry <= "1110";
			mux3_control <= "10";
			mux6_control <= "00";
			ram2_write_out <= '0';
			ram2_read_out <= '0';
			aluOP <= "1000";
			if (instruction_now(4 downto 2) = "000") then
				imm <= "0000000000001000";
			else
				imm <= "0000000000000" & instruction_now(4 downto 2);
			end if;
	elsif (instruction_now(15 downto 11) = "01000") then
		-- ADDIU3 01000xxxyyy0iiii
		rx <= "0" & instruction_now(10 downto 8);
		ry <= "1110";
		mux3_control <= "10";
		mux6_control <= "01";
		ram2_write_out <= '0';
		ram2_read_out <= '0';
		aluOP <= "0101";
		if (instruction_now(3) = '1') then
			imm <= "111111111111" & instruction_now(3 downto 0);
		else
			imm <= "000000000000" & instruction_now(3 downto 0);
		end if;
		rz <= "0" & instruction_now(7 downto 5);
	elsif (instruction_now(15 downto 11) = "01001") then
		-- ADDIU 01001xxxiiiiiiii
		rx <= "0" & instruction_now(10 downto 8);
		ry <= "1110";
		mux3_control <= "10";
		mux6_control <= "01";
		ram2_write_out <= '0';
		ram2_read_out <= '0';
		aluOP <= "0101";
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
		ry <= "1110";
		mux3_control <= "10";
		mux6_control <= "01";
		ram2_write_out <= '0';
		ram2_read_out <= '0';
		aluOP <= "1001";
		if (instruction_now(7) = '1') then
			imm <= "11111111" & instruction_now(7 downto 0);
		else
			imm <= "00000000" & instruction_now(7 downto 0);
		end if;
	elsif (instruction_now(15 downto 11) = "01011") then
		-- SLTUI 01011xxxiiiiiiii
		rx <= "0" & instruction_now(10 downto 8);
		rz <= "1000"; --Signal register T
		ry <= "1110";
		mux3_control <= "10";
		mux6_control <= "01";
		ram2_write_out <= '0';
		ram2_read_out <= '0';
		aluOP <= "1001";
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
			ry <= "1110";
			mux3_control <= "10";
			mux6_control <= "01";
			ram2_write_out <= '0';
			ram2_read_out <= '0';
			aluOP <= "0101";
		elsif (instruction_now(10 downto 8) = "000") then
			-- BTEQZ 01100000iiiiiiii
			if (instruction_now(7) = '1') then -- Immediate in BTEQZ is used for bias for PC
				imm <= "11111111" & instruction_now(7 downto 0);
			else
				imm <= "00000000" & instruction_now(7 downto 0);
			end if;
			rx <= "1000"; -- Signal Register T
			ry <= "1111"; -- NULL Register
			rz <= "1110";
			mux3_control <= "10";
			mux6_control <= "01";
			ram2_write_out <= '0';
			ram2_read_out <= '0';
			aluOP <= "0111";
		elsif (instruction_now(10 downto 8) = "001") then
			-- BTNEZ 01100001iiiiiiii
			if (instruction_now(7) = '1') then -- Immediate in BTEQZ is used for bias for PC
				imm <= "11111111" & instruction_now(7 downto 0);
			else
				imm <= "00000000" & instruction_now(7 downto 0);
			end if;
			rx <= "1000"; -- Signal Register T
			ry <= "1111"; -- NULL Register
			mux3_control <= "10";
			mux6_control <= "01";
			ram2_write_out <= '0';
			ram2_read_out <= '0';
			aluOP <= "1000";
		elsif (instruction_now(10 downto 8) = "100") then
			-- MTSP 01100100xxx00000
			rx <= "0" & instruction_now(7 downto 5);
			ry <= "1111"; -- NULL Register
			rz <= "1001"; -- Stack Point Register
			mux3_control <= "10";
			mux6_control <= "01";
			ram2_write_out <= '0';
			ram2_read_out <= '0';
			aluOP <= "0101";
			imm <= "00000000000000000";
		elsif (instruction_now(10 downto 8) = "010") then
			-- SW_RS 01100010iiiiiiii
			rx <= "1001"; -- Stack Point Register
			rz <= "1110";
			mux3_control <= "10";
			mux6_control <= "01";
			ram2_write_out <= '0';
			ram2_read_out <= '0';
			aluOP <= "0101";
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
		mux3_control <= "10";
		mux6_control <= "01";
		ram2_write_out <= '0';
		ram2_read_out <= '0';
		imm <= "00000000" & instruction_now(7 downto 0);
		rz <= "0" & instruction_now(10 downto 8);
		ry <= "1110";
		aluOP <= "0101";
	elsif (instruction_now(15 downto 11) = "01110") then
		-- CMPI 01110xxxiiiiiiii
		rx <= "0" & instruction_now(10 downto 8);
		ry <= "1110";
		mux3_control <= "10";
		mux6_control <= "01";
		ram2_write_out <= '0';
		ram2_read_out <= '0';
		aluOP <= "1110";
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
		mux3_control <= "10";
		mux6_control <= "01";
		ram2_write_out <= '0';
		ram2_read_out <= '0';
		aluOP <= "0101";
		imm <= "00000000000000000";
	elsif (instruction_now(15 downto 11) = "10010") then
		-- LW_SP 10010xxxiiiiiiii
		rx <= "1001"; -- Stack Point Register
		ry <= "1110";
		mux3_control <= "10";
		mux6_control <= "01";
		ram2_write_out <= '0';
		ram2_read_out <= '0';
		aluOP <= "0101";
		if (instruction_now(7) = '1') then
			imm <= "11111111" & instruction_now(7 downto 0);
		else
			imm <= "00000000" & instruction_now(7 downto 0);
		end if;
		rz <= "0" & instruction_now(10 downto 8);
	elsif (instruction_now(15 downto 11) = "10011") then
		-- LW 10011xxxyyyiiiii
		rx <= "0" & instruction_now(10 downto 8);
		ry <= "1110";
		mux3_control <= "10";
		mux6_control <= "01";
		ram2_write_out <= '0';
		ram2_read_out <= '0';
		aluOP <= "0101";
		if (instruction_now(4) = '1') then
			imm <= "11111111111" & instruction_now(4 downto 0);
		else
			imm <= "00000000000" & instruction_now(4 downto 0);
		end if;
		rz <= "0" & instruction_now(7 downto 5);
	elsif (instruction_now(15 downto 11) = "11010") then
		-- SW_SP 11010xxxiiiiiiii
		rx <= "1001"; -- Stack Point Register
		rz <= "1110";
		mux3_control <= "10";
		mux6_control <= "01";
		ram2_write_out <= '0';
		ram2_read_out <= '0';
		aluOP <= "0101";
		if (instruction_now(7) = '1') then
			imm <= "11111111" & instruction_now(7 downto 0);
		else
			imm <= "00000000" & instruction_now(7 downto 0);
		end if;
		ry <= "0" & instruction_now(10 downto 8);
	elsif (instruction_now(15 downto 11) = "11011") then
		-- SW 11011xxxyyyiiiii
		rx <= "0" & instruction_now(10 downto 8);
		rz <= "1110";
		mux3_control <= "10";
		mux6_control <= "01";
		ram2_write_out <= '0';
		ram2_read_out <= '0';
		aluOP <= "0101";
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
			mux3_control <= "01";
			mux6_control <= "01";
			ram2_write_out <= '0';
			ram2_read_out <= '0';
			aluOP <= "0101";
			imm <= "0000000000000000";
		elsif (instruction_now(1 downto 0) = "11") then
			-- SUBU 11100xxxyyyzzz11
			rx <= "0" & instruction_now(10 downto 8);
			ry <= "0" & instruction_now(7 downto 5);
			rz <= "0" & instruction_now(4 downto 2);
			ux3_control <= "01";
			mux6_control <= "01";
			ram2_write_out <= '0';
			ram2_read_out <= '0';
			aluOP <= "0110";
			imm <= "0000000000000000";
		end if;
	elsif (instruction_now(15 downto 11) = "11101") then
		if (instruction_now(4 downto 0) = "01100") then
			-- AND 11101xxxyyy01100
			rx <= "0" & instruction_now(10 downto 8);
			ry <= "0" & instruction_now(7 downto 5);
			rz <= "0" & instruction_now(10 downto 8);
			ux3_control <= "01";
			mux6_control <= "01";
			ram2_write_out <= '0';
			ram2_read_out <= '0';
			aluOP <= "0001";
			imm <= "0000000000000000";
		elsif (instruction_now(4 downto 0) = "01010") then
			-- CMP 11101xxxyyy01010
			rx <= "0" & instruction_now(10 downto 8);
			ry <= "0" & instruction_now(7 downto 5);
			rz <= "1000"; -- Signal Register T
			ux3_control <= "01";
			mux6_control <= "01";
			ram2_write_out <= '0';
			ram2_read_out <= '0';
			aluOP <= "1110";
			imm <= "0000000000000000";
		elsif (instruction_now(4 downto 0) = "01011") then
			-- NEG 11101xxxyyy01011
			rx <= "1111"; -- NULL Register
			ry <= "0" & instruction_now(7 downto 5);
			rz <= "0" & instruction_now(10 downto 8);
			ux3_control <= "01";
			mux6_control <= "01";
			ram2_write_out <= '0';
			ram2_read_out <= '0';
			aluOP <= "0011";
			imm <= "0000000000000000";
		elsif (instruction_now(4 downto 0) = "01111") then
			-- NOT 11101xxxyyy01111
			rx <= "0" & instruction_now(7 downto 5);
			rz <= "0" & instruction_now(10 downto 8);
			ry <= "1110";
			ux3_control <= "01";
			mux6_control <= "01";
			ram2_write_out <= '0';
			ram2_read_out <= '0';
			aluOP <= "0011";
			imm <= "0000000000000000";
		elsif (instruction_now(4 downto 0) = "01101") then
			-- OR 11101xxxyyy01101
			rx <= "0" & instruction_now(10 downto 8);
			ry <= "0" & instruction_now(7 downto 5);
			rz <= "0" & instruction_now(10 downto 8);
			ux3_control <= "01";
			mux6_control <= "01";
			ram2_write_out <= '0';
			ram2_read_out <= '0';
			aluOP <= "0010";
			imm <= "0000000000000000";
		elsif (instruction_now(4 downto 0) = "00100") then
			-- SLLV 11101xxxyyy00100
			rx <= "0" & instruction_now(7 downto 5);
			ry <= "0" & instruction_now(10 downto 8);
			rz <= "0" & instruction_now(7 downto 5);
			ux3_control <= "01";
			mux6_control <= "01";
			ram2_write_out <= '0';
			ram2_read_out <= '0';
			aluOP <= "1011";
			imm <= "0000000000000000";
		elsif (instruction_now(4 downto 0) = "00010") then
			-- SLT 11101xxxyyy00010
			rx <= "0" & instruction_now(10 downto 8);
			ry <= "0" & instruction_now(7 downto 5);
			rz <= "1000"; -- Signal Register T
			ux3_control <= "01";
			mux6_control <= "01";
			ram2_write_out <= '0';
			ram2_read_out <= '0';
			aluOP <= "1001";
			imm <= "0000000000000000";
		elsif (instruction_now(4 downto 0) = "00011") then
			-- SLTU 11101xxxyyy00011
			rx <= "0" & instruction_now(10 downto 8);
			ry <= "0" & instruction_now(7 downto 5);
			rz <= "1000"; -- Signal Register T
			ux3_control <= "01";
			mux6_control <= "01";
			ram2_write_out <= '0';
			ram2_read_out <= '0';
			aluOP <= "1001";
			imm <= "0000000000000000";
		elsif (instruction_now(4 downto 0) = "00111") then
			-- SRAV 11101xxxyyy00111
			rx <= "0" & instruction_now(7 downto 5);
			ry <= "0" & instruction_now(10 downto 8);
			rz <= "0" & instruction_now(7 downto 5);
			ux3_control <= "01";
			mux6_control <= "01";
			ram2_write_out <= '0';
			ram2_read_out <= '0';
			aluOP <= "1101";
			imm <= "0000000000000000";
		elsif (instruction_now(4 downto 0) = "00110") then
			-- SRLV 11101xxxyyy00110
			rx <= "0" & instruction_now(7 downto 5);
			ry <= "0" & instruction_now(10 downto 8);
			rz <= "0" & instruction_now(7 downto 5);
			ux3_control <= "01";
			mux6_control <= "01";
			ram2_write_out <= '0';
			ram2_read_out <= '0';
			aluOP <= "1100";
			imm <= "0000000000000000";
		elsif (instruction_now(4 downto 0) = "01110") then
			-- XOR 11101xxxyyy01110
			rx <= "0" & instruction_now(10 downto 8);
			ry <= "0" & instruction_now(7 downto 5);
			rz <= "0" & instruction_now(10 downto 8);
			ux3_control <= "01";
			mux6_control <= "01";
			ram2_write_out <= '0';
			ram2_read_out <= '0';
			aluOP <= "0100";
			imm <= "0000000000000000";
		end if;
	elsif (instruction_now(15 downto 11) = "11110") then
		if (instruction_now(7 downto 0) = "00000000") then
			-- MFIH 11110xxx00000000
			rx <= "1011"; -- IH Register
			ry <= "1111"; -- NULL Register
			rz <= "0" & instruction_now(10 downto 8);
			ux3_control <= "01";
			mux6_control <= "01";
			ram2_write_out <= '0';
			ram2_read_out <= '0';
			aluOP <= "0101";
			imm <= "0000000000000000";
		elsif (instruction_now(7 downto 0) = "00000001") then
			-- MTIH 11110xxx00000001
			rx <= "0" & instruction_now(10 downto 8);
			ry <= "1111"; -- NULL Register
			rz <= "1011"; -- IH Register
			ux3_control <= "01";
			mux6_control <= "01";
			ram2_write_out <= '0';
			ram2_read_out <= '0';
			aluOP <= "0101";
			imm <= "0000000000000000";
		end if;
	end if;
end process;

end behavioral;