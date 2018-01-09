library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity gprs is
	port
	(
		read_rx: in std_logic_vector(3 downto 0);
		read_ry: in std_logic_vector(3 downto 0);
		write_io: in std_logic;
		write_data: in std_logic_vector(15 downto 0);
		write_rz: in std_logic_vector(3 downto 0);
		rx_data: out std_logic_vector(15 downto 0);
		ry_data: out std_logic_vector(15 downto 0);
		clk: in std_logic
	);
end gprs;

architecture Behavioral of gprs is
	signal r0: std_logic_vector(15 downto 0) := "0000000000000000";
	signal r1: std_logic_vector(15 downto 0) := "0000000000000000";
	signal r2: std_logic_vector(15 downto 0) := "0000000000000000";
	signal r3: std_logic_vector(15 downto 0) := "0000000000000000";
	signal r4: std_logic_vector(15 downto 0) := "0000000000000000";
	signal r5: std_logic_vector(15 downto 0) := "0000000000000000";
	signal r6: std_logic_vector(15 downto 0) := "0000000000000000";
	signal r7: std_logic_vector(15 downto 0) := "0000000000000000";
	signal rt: std_logic_vector(15 downto 0) := "0000000000000000";
	signal rsp: std_logic_vector(15 downto 0) := "0000000000000000";
	signal rra: std_logic_vector(15 downto 0) := "0000000000000000";
	signal rih: std_logic_vector(15 downto 0) := "0000000000000000";
	signal pervious_write_io: std_logic := '0';
begin

process(clk)
	variable is_write: std_logic;
begin
	if (rising_edge(clk)) then
		is_write := '0';
		if (pervious_write_io /= write_io) then
			is_write := '1';
			-- Need to write data
			if (write_rz = "0000") then
				r0 <= write_data;
			elsif (write_rz = "0001") then
				r1 <= write_data;
			elsif (write_rz = "0010") then
				r2 <= write_data;
			elsif (write_rz = "0011") then
				r3 <= write_data;
			elsif (write_rz = "0100") then
				r4 <= write_data;
			elsif (write_rz = "0101") then
				r5 <= write_data;
			elsif (write_rz = "0110") then
				r6 <= write_data;
			elsif (write_rz = "0111") then
				r7 <= write_data;
			elsif (write_rz = "1000") then
				rt <= write_data;
			elsif (write_rz = "1001") then
				rsp <= write_data;
			elsif (write_rz = "1010") then
				rra <= write_data;
			elsif (write_rz = "1011") then
				rih <= write_data;
			end if;
		end if;
		if (is_write = '1' and read_rx = write_rz) then
			rx_data <= write_data;
		else
			if (read_rx = "0000") then
				rx_data <= r0;
			elsif (read_rx = "0001") then
				rx_data <= r1;
			elsif (read_rx = "0010") then
				rx_data <= r2;
			elsif (read_rx = "0011") then
				rx_data <= r3;
			elsif (read_rx = "0100") then
				rx_data <= r4;
			elsif (read_rx = "0101") then
				rx_data <= r5;
			elsif (read_rx = "0110") then
				rx_data <= r6;
			elsif (read_rx = "0111") then
				rx_data <= r7;
			elsif (read_rx = "1000") then
				rx_data <= rt;
			elsif (read_rx = "1001") then
				rx_data <= rsp;
			elsif (read_rx = "1010") then
				rx_data <= rra;
			elsif (read_rx = "1011") then
				rx_data <= rih;
			elsif (read_rx = "1111") then
				rx_data <= "0000000000000000"; -- NULL Register
			end if;
		end if;
		if (is_write = '1' and read_ry = write_rz) then
			ry_data <= write_data;
		else
			if (read_ry = "0000") then
				ry_data <= r0;
			elsif (read_ry = "0001") then
				ry_data <= r1;
			elsif (read_ry = "0010") then
				ry_data <= r2;
			elsif (read_ry = "0011") then
				ry_data <= r3;
			elsif (read_ry = "0100") then
				ry_data <= r4;
			elsif (read_ry = "0101") then
				ry_data <= r5;
			elsif (read_ry = "0110") then
				ry_data <= r6;
			elsif (read_ry = "0111") then
				ry_data <= r7;
			elsif (read_ry = "1000") then
				ry_data <= rt;
			elsif (read_ry = "1001") then
				ry_data <= rsp;
			elsif (read_ry = "1010") then
				ry_data <= rra;
			elsif (read_ry = "1011") then
				ry_data <= rih;
			elsif (read_ry = "1111") then
				ry_data <= "0000000000000000"; -- NULL Register
			end if;
		end if;
		pervious_write_io <= write_io;
	end if;
end process;

end Behavioral;