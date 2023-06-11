--------------------------------------
----FinalProject_Trivia_FSM_tb.vhdl
--
--created 10/29/2022
--Tom Rettke, Henning Patte, Chris Klobke
--
--rev 0
--------------------------------------
--
--Testbench for FinalProject_Trivia_FSM.vhdl
--Task for final Project
--
--
--------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.all;

entity FinalProject_Trivia_FSM_tb is
end entity;

architecture tb of FinalProject_Trivia_FSM_tb is
	signal CLK:					std_logic;
	signal RSTB:				std_logic;
	signal ANSWER:				std_logic_vector(1 downto 0);
	signal COUNT:				std_logic_vector(3 downto 0);
	
	constant PER:				time := 20 ns;	
	
	component FinalProject_Trivia_FSM is
		port (
			i_clk:				in std_logic;
			i_rstb:				in std_logic;
			i_answer:			in std_logic_vector(1 downto 0);
			o_count:				out std_logic_vector(3 downto 0)
		);
	end component;

begin

	DUT : FinalProject_Trivia_FSM
	port map (
		i_clk => CLK,
		i_rstb => RSTB,
		i_answer => ANSWER,
		o_count => COUNT
	);
	
	Clock : process 
	begin
		CLK <= '0';
		wait for PER/2;
		infinite: loop
			CLK <= not CLK;
			wait for PER/2;
		end loop;
	end process;
	
	process
	begin
		RSTB <= '0';
		wait for 30 ns;
		RSTB <= '1';
		ANSWER <= "11";
		wait for 30 ns;
		--Answered but wrong
		ANSWER <= "10";
		wait for 30 ns;
		--Answered correctly
		ANSWER <= "11";
		wait for 30 ns;
		--Answered but wrong
		ANSWER <= "10";
		wait for 30 ns;
		--Answered correctly
		ANSWER <= "11";
		wait for 30 ns;
		--Answered correctly
		ANSWER <= "11";
		wait for 30 ns;
		--Answered correctly
		ANSWER <= "11";
		wait for 30 ns;
		--Answered but wrong
		ANSWER <= "10";
		wait for 30 ns;
		--Answered correctly
		ANSWER <= "11";
		wait for 30 ns;
		--Answered correctly
		ANSWER <= "11";
		wait for 30 ns;
		--Answered correctly
		ANSWER <= "11";
		wait for 30 ns;
		--Answered correctly
		ANSWER <= "11";
		wait for 30 ns;
		--Answered correctly and win
		ANSWER <= "11";
		wait;
	end process;
	
end architecture; 