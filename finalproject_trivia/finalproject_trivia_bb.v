
module finalproject_trivia (
	clk_clk,
	reset_reset_n,
	clk_sdram_clk,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n,
	vga_out_CLK,
	vga_out_HS,
	vga_out_VS,
	vga_out_BLANK,
	vga_out_SYNC,
	vga_out_R,
	vga_out_G,
	vga_out_B);	

	input		clk_clk;
	input		reset_reset_n;
	output		clk_sdram_clk;
	output	[12:0]	sdram_wire_addr;
	output	[1:0]	sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[15:0]	sdram_wire_dq;
	output	[1:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
	output		vga_out_CLK;
	output		vga_out_HS;
	output		vga_out_VS;
	output		vga_out_BLANK;
	output		vga_out_SYNC;
	output	[3:0]	vga_out_R;
	output	[3:0]	vga_out_G;
	output	[3:0]	vga_out_B;
endmodule
