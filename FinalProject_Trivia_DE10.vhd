--------------------------------------
----FinalProject_Trivia_DE10.vhdl
--
--created 11/1/2022
--Tom Rettke, Henning Patte, Chris Klobke
--
--rev 0
--------------------------------------
--
--DE10 for state of level for trivia
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

entity FinalProject_Trivia_DE10 is
  port (
    CLOCK_50:      	in std_logic;
	 GPIO:				in std_logic_vector(4 downto 1);
    DRAM_ADDR:			out std_logic_vector(12 downto 0);
	 DRAM_BA:			out std_logic_vector(1 downto 0);
	 DRAM_CAS_N:		out std_logic;
	 DRAM_CKE:			out std_logic;
	 DRAM_CS_N:			out std_logic;
	 DRAM_RAS_N:		out std_logic;
	 DRAM_WE_N:			out std_logic;
	 DRAM_DQ:			inout std_logic_vector(15 downto 0);
	 DRAM_UDQM:			out std_logic;
	 DRAM_LDQM:			out std_logic;
	 VGA_HS:				out std_logic;
	 VGA_VS:				out std_logic;
	 VGA_R:				out std_logic_vector(3 downto 0);
	 VGA_G:				out std_logic_vector(3 downto 0);
	 VGA_B:				out std_logic_vector(3 downto 0);
	 HEX0:				out std_logic_vector(7 downto 0);		
	 HEX1:				out std_logic_vector(7 downto 0);
	 DRAM_CLK:			out std_logic;
	 LEDR:				out std_logic_vector(4 downto 0)
  );
 end entity;

architecture behavioral of FinalProject_Trivia_DE10 is

signal S_LEVEL:				std_logic_vector(3 downto 0);
signal S_ANSWER:				std_logic_vector(1 downto 0);
signal CLK:						std_logic;
signal S_SSEG:					std_logic_vector(15 downto 0);

    component finalproject_trivia is
        port (
            clk_clk                                      : in    std_logic                     := 'X';             -- clk
            clk_sdram_clk                                : out   std_logic;                                        -- clk
            pio_input_key_external_connection_export     : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- export
            pio_input_level_external_connection_export   : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- export
            pio_output_answer_external_connection_export : out   std_logic_vector(1 downto 0);                     -- export
            pio_sseg_external_connection_export          : out   std_logic_vector(15 downto 0);                    -- export
            reset_reset_n                                : in    std_logic                     := 'X';             -- reset_n
            sdram_wire_addr                              : out   std_logic_vector(12 downto 0);                    -- addr
            sdram_wire_ba                                : out   std_logic_vector(1 downto 0);                     -- ba
            sdram_wire_cas_n                             : out   std_logic;                                        -- cas_n
            sdram_wire_cke                               : out   std_logic;                                        -- cke
            sdram_wire_cs_n                              : out   std_logic;                                        -- cs_n
            sdram_wire_dq                                : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
            sdram_wire_dqm                               : out   std_logic_vector(1 downto 0);                     -- dqm
            sdram_wire_ras_n                             : out   std_logic;                                        -- ras_n
            sdram_wire_we_n                              : out   std_logic;                                        -- we_n
            vga_out_CLK                                  : out   std_logic;                                        -- CLK
            vga_out_HS                                   : out   std_logic;                                        -- HS
            vga_out_VS                                   : out   std_logic;                                        -- VS
            vga_out_BLANK                                : out   std_logic;                                        -- BLANK
            vga_out_SYNC                                 : out   std_logic;                                        -- SYNC
            vga_out_R                                    : out   std_logic_vector(3 downto 0);                     -- R
            vga_out_G                                    : out   std_logic_vector(3 downto 0);                     -- G
            vga_out_B                                    : out   std_logic_vector(3 downto 0)                      -- B
        );
    end component finalproject_trivia;
	 
	 component clock_divider is
		port (
			i_clk_50MHz:	in std_logic;
			i_rstb:			in std_logic;
		
			o_clk_XHz:		out std_logic
		);
	 end component;
	 
	 component FinalProject_Trivia_FSM is
	 port (
				i_clk:				in std_logic;
				i_rstb:				in std_logic;
				i_answer:			in std_logic_vector(1 downto 0);
				o_count:				out std_logic_vector(3 downto 0)
	 );
	 end component;
	
begin

    u0 : component finalproject_trivia
        port map (
            clk_clk                                      => CLOCK_50,                                      --                                   clk.clk
            clk_sdram_clk                                => DRAM_CLK,                                --                             clk_sdram.clk
            reset_reset_n                                => '1',                                --                                 reset.reset_n
            sdram_wire_addr                              => DRAM_ADDR,                              --                            sdram_wire.addr
            sdram_wire_ba                                => DRAM_BA,                                --                                      .ba
            sdram_wire_cas_n                             => DRAM_CAS_N,                             --                                      .cas_n
            sdram_wire_cke                               => DRAM_CKE,                               --                                      .cke
            sdram_wire_cs_n                              => DRAM_CS_N,                              --                                      .cs_n
            sdram_wire_dq                                => DRAM_DQ,                                --                                      .dq
            sdram_wire_dqm(0)                            => DRAM_LDQM,                               --                                      .dqm
				sdram_wire_dqm(1)                            => DRAM_UDQM,                               --                                      .dqm
            sdram_wire_ras_n                             => DRAM_RAS_N,                             --                                      .ras_n
            sdram_wire_we_n                              => DRAM_WE_N,                              --                                      .we_n
            --vga_out_CLK                                  => CONNECTED_TO_vga_out_CLK,                                  --                               vga_out.CLK
            vga_out_HS                                   => VGA_HS,                                   --                                      .HS
            vga_out_VS                                   => VGA_VS,                                   --                                      .VS
            --vga_out_BLANK                                => CONNECTED_TO_vga_out_BLANK,                                --                                      .BLANK
            --vga_out_SYNC                                 => CONNECTED_TO_vga_out_SYNC,                                 --                                      .SYNC
            vga_out_R                                    => VGA_R,                                    --                                      .R
            vga_out_G                                    => VGA_G,                                    --                                      .G
            vga_out_B                                    => VGA_B,                                    --                                      .B
            pio_input_level_external_connection_export   => S_LEVEL,   --   pio_input_level_external_connection.export
            pio_output_answer_external_connection_export => S_ANSWER, -- pio_output_answer_external_connection.export
            pio_input_key_external_connection_export     => not GPIO(4 downto 1),      --     pio_input_key_external_connection.export
				pio_sseg_external_connection_export          => S_SSEG          --          pio_sseg_external_connection.export
        );
		  
	 FSM : component FinalProject_Trivia_FSM
	 port map (
				i_clk					=> CLK,
				i_rstb				=> '1',
				i_answer				=> S_ANSWER,
				o_count				=> S_LEVEL
	 );
	 
	 CLKDIV : component clock_divider
	 port map (
				i_clk_50MHz			=> CLOCK_50,
				i_rstb				=> '1',
				o_clk_XHz			=> CLK
	 );
	 
	 LEDR(3 downto 0) <= S_LEVEL;
	 HEX0 <= S_SSEG(7 downto 0);
	 HEX1 <= S_SSEG(15 downto 8);

		  
end;