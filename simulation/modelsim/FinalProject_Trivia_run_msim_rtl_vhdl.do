transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlib finalproject_trivia
vmap finalproject_trivia finalproject_trivia
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/altera_reset_controller.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/altera_reset_synchronizer.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_mm_interconnect_0.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_mm_interconnect_0_avalon_st_adapter_008.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_mm_interconnect_0_avalon_st_adapter_001.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_mm_interconnect_0_avalon_st_adapter.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/altera_avalon_sc_fifo.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/altera_up_avalon_video_vga_timing.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_video_vga_controller_0.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_video_dual_clock_buffer_0.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/altera_up_video_128_character_rom.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_video_character_buffer_with_dma_0.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_timer_0.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_sysid_qsys_0.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_pio_sseg.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_pio_output_answer.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_pio_input_key.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_onchip_memory2_0.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_nios2_gen2_0.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_nios2_gen2_0_cpu.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_nios2_gen2_0_cpu_debug_slave_sysclk.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_nios2_gen2_0_cpu_debug_slave_tck.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_nios2_gen2_0_cpu_debug_slave_wrapper.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_nios2_gen2_0_cpu_test_bench.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_new_sdram_controller_0.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_jtag_uart_0.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_altpll_0.v}
vlog -sv -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_irq_mapper.sv}
vlog -sv -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_mm_interconnect_0_avalon_st_adapter_008_error_adapter_0.sv}
vlog -sv -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_mm_interconnect_0_avalon_st_adapter_001_error_adapter_0.sv}
vlog -sv -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/altera_avalon_st_handshake_clock_crosser.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/altera_avalon_st_clock_crosser.v}
vlog -vlog01compat -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/altera_std_synchronizer_nocut.v}
vlog -sv -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/altera_merlin_width_adapter.sv}
vlog -sv -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/altera_merlin_burst_uncompressor.sv}
vlog -sv -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_mm_interconnect_0_rsp_mux_001.sv}
vlog -sv -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/altera_merlin_arbitrator.sv}
vlog -sv -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_mm_interconnect_0_rsp_mux.sv}
vlog -sv -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_mm_interconnect_0_rsp_demux.sv}
vlog -sv -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_mm_interconnect_0_cmd_mux_004.sv}
vlog -sv -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_mm_interconnect_0_cmd_mux.sv}
vlog -sv -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_mm_interconnect_0_cmd_demux_001.sv}
vlog -sv -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_mm_interconnect_0_cmd_demux.sv}
vlog -sv -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/altera_merlin_burst_adapter.sv}
vlog -sv -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/altera_merlin_burst_adapter_uncmpr.sv}
vlog -sv -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_mm_interconnect_0_router_010.sv}
vlog -sv -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_mm_interconnect_0_router_006.sv}
vlog -sv -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_mm_interconnect_0_router_003.sv}
vlog -sv -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_mm_interconnect_0_router_002.sv}
vlog -sv -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_mm_interconnect_0_router_001.sv}
vlog -sv -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/finalproject_trivia_mm_interconnect_0_router.sv}
vlog -sv -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/altera_merlin_slave_agent.sv}
vlog -sv -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/altera_merlin_master_agent.sv}
vlog -sv -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/altera_merlin_slave_translator.sv}
vlog -sv -work finalproject_trivia +incdir+Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/submodules/altera_merlin_master_translator.sv}
vcom -2008 -work finalproject_trivia {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/finalproject_trivia.vhd}
vcom -2008 -work finalproject_trivia {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/finalproject_trivia_rst_controller.vhd}
vcom -2008 -work finalproject_trivia {Z:/Documents/HDL/Quartus_Projects/FinalProject/synthesis/finalproject_trivia_rst_controller_001.vhd}
vcom -2008 -work work {Z:/Documents/HDL/Quartus_Projects/FinalProject/FinalProject_Trivia_FSM.vhd}
vcom -2008 -work work {Z:/Documents/HDL/Quartus_Projects/FinalProject/FinalProject_Trivia_DE10.vhd}
vcom -2008 -work work {Z:/Documents/HDL/Quartus_Projects/FinalProject/clock_divider.vhd}

vcom -2008 -work work {Z:/Documents/HDL/Quartus_Projects/FinalProject/FinalProject_Trivia_FSM_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -L finalproject_trivia -voptargs="+acc"  FinalProject_Trivia_FSM_tb

add wave *
view structure
view signals
run 0 ns
