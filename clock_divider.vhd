--------------------------------------
----clk_divider.vhdl
--
--created 11/03/2022
--Tom Rettke, Henning Patte, Chris Klobke
--
--rev 0
--------------------------------------
--
--Creates a clock divider with X Hz
--
--Task for lab practical
--
---------------------------------------
--
--Inputs: i_restb, i_clk_50MHz
--Output: o_clk_XHz
--
--------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity clock_divider is
	port (
		i_clk_50MHz:	in std_logic;
		i_rstb:			in std_logic;
		
		o_clk_XHz:		out std_logic
	);
end entity;

architecture behavioral of clock_divider is
	constant CLOCKS_PER_HALF_PERIOD: signed(25 downto 0) := to_signed((((50_000_000 / 2) /1) - 2), 26);
	
	signal cnt:			signed(25 downto 0);
	signal clk_sig:	std_logic;
	
begin
	process(i_clk_50Mhz, i_rstb)
		begin
		if (i_rstb = '0') then
			cnt <= CLOCKS_PER_HALF_PERIOD;
			clk_sig <= '0';
		elsif(rising_edge(i_clk_50MHz)) then
			cnt <= cnt - 1;
			
			-- check if half way
			if (cnt < 0) then
				cnt <= CLOCKS_PER_HALF_PERIOD;
				clk_sig <= not clk_sig;
			end if;
		end if;
	end process;
	
	o_clk_XHz <= clk_sig;
	
end behavioral;