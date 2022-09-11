/*
A clock divider in Verilog
*/

module cyc1000_top(
  input  CLK12M,
  input  KEY0,
  input  UART_RXD,
  output UART_TXD,
  inout  PS2_MOUSE_DAT,
  inout  PS2_MOUSE_CLK
);

  wire clk_50;
  wire uart2_rts;

  pll pll
  (
    .inclk0(CLK12M),
    .areset(1'b0),
    .c0(clk_50),
    .locked()
  );

  assign uart2_rts = UART_RXD; 
//assign uart2_rts = KEY0;    //KEY0 3V3 not pressed, 0V pressed


  MSMouseWrapper MSMouseWrapper_inst (
    .clk(clk_50),
    .ps2dta(PS2_MOUSE_DAT),
    .ps2clk(PS2_MOUSE_CLK),
    .rts(uart2_rts),
    .rd(UART_TXD)
  );

endmodule
