--------------------------------------
----FinalProject_Trivia_FSM.vhdl
--
--created 10/27/2022
--Tom Rettke, Henning Patte, Chris Klobke
--
--rev 0
--------------------------------------
--
--FSM for state of level for trivia
--
--Task for final Project
--
---------------------------------------
--
--Inputs: CLK, SW
--Output: LEDR
--
--------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.all;

entity FinalProject_Trivia_FSM is
	port (
		i_clk:				in std_logic;
		i_rstb:				in std_logic;
		i_answer:			in std_logic_vector(1 downto 0);
		o_count:				out std_logic_vector(3 downto 0)
	);
end entity;

architecture behavioral of FinalProject_Trivia_FSM is
type state_type is			(state_idle, state_question, state_wait, state_win);

--First bit of answer indicates if question is answered already
--signal question_answered:		std_logic := i_answer(1); 
--Second bit indicates if question is answered correctly
--signal answer_correct:			std_logic := i_answer(0); 

signal s_cnt:						integer;
signal state_next:				state_type;
signal state:						state_type;
signal i_state:					unsigned(3 downto 0);

begin

	NSL: process(all)
	begin
		case state is
			when state_idle =>
				if (i_answer(1) = '1' and i_answer(0) = '1') then
					state_next <= state_question;
				else
					state_next <= state_idle;
				end if;
				
			when state_question =>
				if (i_answer(1) = '1' and i_answer(0) = '1') then
					if (s_cnt = 6) then
						state_next <= state_win;
					else
						state_next <= state_question;
					end if;
				elsif(i_answer(1) = '0') then
					state_next <= state_wait;
				else
					state_next <= state_idle;
				end if;
				
			when state_win =>
				if ((i_answer(1) = '1' and i_answer(0) = '1')) then
					state_next <= state_win;
				else
					state_next <= state_idle;
				end if;
				
			when state_wait =>
				if ((i_answer(1) = '1' and i_answer(0) = '1')) then
					state_next <= state_question;
				elsif (i_answer(1) = '0') then
					state_next <= state_wait;
				else
					state_next <= state_idle;
				end if;
			
			when others =>
				state_next <= state_idle;
			end case;
	end process;
	
	process(i_clk, i_rstb)
	begin
		if (i_rstb = '0') then
			state <= state_idle;
			s_cnt <= 0;
		elsif (rising_edge(i_clk)) then
			state <= state_next;
			if (state_next = state_question) then
				s_cnt <= s_cnt + 1;
			elsif (state_next = state_idle) then
				s_cnt <= 0;
			end if;
		end if;
	end process;

	o_count <= std_logic_vector(to_unsigned(s_cnt, o_count'length));
end architecture;