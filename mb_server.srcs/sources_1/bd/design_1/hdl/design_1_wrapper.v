//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Thu May  9 00:55:28 2019
//Host        : LAPTOP-GORTITDH running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (DDR2_0_addr,
    DDR2_0_ba,
    DDR2_0_cas_n,
    DDR2_0_ck_n,
    DDR2_0_ck_p,
    DDR2_0_cke,
    DDR2_0_cs_n,
    DDR2_0_dm,
    DDR2_0_dq,
    DDR2_0_dqs_n,
    DDR2_0_dqs_p,
    DDR2_0_odt,
    DDR2_0_ras_n,
    DDR2_0_we_n,
    eth_mdio_mdc_mdc,
    eth_mdio_mdc_mdio_io,
    eth_ref_clk,
    eth_rmii_crs_dv,
    eth_rmii_rx_er,
    eth_rmii_rxd,
    eth_rmii_tx_en,
    eth_rmii_txd,
    ja_0_pin10_io,
    ja_0_pin1_io,
    ja_0_pin2_io,
    ja_0_pin3_io,
    ja_0_pin4_io,
    ja_0_pin7_io,
    ja_0_pin8_io,
    ja_0_pin9_io,
    jb_pin10_io,
    jb_pin1_io,
    jb_pin2_io,
    jb_pin3_io,
    jb_pin4_io,
    jb_pin7_io,
    jb_pin8_io,
    jb_pin9_io,
    reset,
    sys_clock,
    usb_uart_rxd,
    usb_uart_txd);
  output [12:0]DDR2_0_addr;
  output [2:0]DDR2_0_ba;
  output DDR2_0_cas_n;
  output [0:0]DDR2_0_ck_n;
  output [0:0]DDR2_0_ck_p;
  output [0:0]DDR2_0_cke;
  output [0:0]DDR2_0_cs_n;
  output [1:0]DDR2_0_dm;
  inout [15:0]DDR2_0_dq;
  inout [1:0]DDR2_0_dqs_n;
  inout [1:0]DDR2_0_dqs_p;
  output [0:0]DDR2_0_odt;
  output DDR2_0_ras_n;
  output DDR2_0_we_n;
  output eth_mdio_mdc_mdc;
  inout eth_mdio_mdc_mdio_io;
  output eth_ref_clk;
  input eth_rmii_crs_dv;
  input eth_rmii_rx_er;
  input [1:0]eth_rmii_rxd;
  output eth_rmii_tx_en;
  output [1:0]eth_rmii_txd;
  inout ja_0_pin10_io;
  inout ja_0_pin1_io;
  inout ja_0_pin2_io;
  inout ja_0_pin3_io;
  inout ja_0_pin4_io;
  inout ja_0_pin7_io;
  inout ja_0_pin8_io;
  inout ja_0_pin9_io;
  inout jb_pin10_io;
  inout jb_pin1_io;
  inout jb_pin2_io;
  inout jb_pin3_io;
  inout jb_pin4_io;
  inout jb_pin7_io;
  inout jb_pin8_io;
  inout jb_pin9_io;
  input reset;
  input sys_clock;
  input usb_uart_rxd;
  output usb_uart_txd;

  wire [12:0]DDR2_0_addr;
  wire [2:0]DDR2_0_ba;
  wire DDR2_0_cas_n;
  wire [0:0]DDR2_0_ck_n;
  wire [0:0]DDR2_0_ck_p;
  wire [0:0]DDR2_0_cke;
  wire [0:0]DDR2_0_cs_n;
  wire [1:0]DDR2_0_dm;
  wire [15:0]DDR2_0_dq;
  wire [1:0]DDR2_0_dqs_n;
  wire [1:0]DDR2_0_dqs_p;
  wire [0:0]DDR2_0_odt;
  wire DDR2_0_ras_n;
  wire DDR2_0_we_n;
  wire eth_mdio_mdc_mdc;
  wire eth_mdio_mdc_mdio_i;
  wire eth_mdio_mdc_mdio_io;
  wire eth_mdio_mdc_mdio_o;
  wire eth_mdio_mdc_mdio_t;
  wire eth_ref_clk;
  wire eth_rmii_crs_dv;
  wire eth_rmii_rx_er;
  wire [1:0]eth_rmii_rxd;
  wire eth_rmii_tx_en;
  wire [1:0]eth_rmii_txd;
  wire ja_0_pin10_i;
  wire ja_0_pin10_io;
  wire ja_0_pin10_o;
  wire ja_0_pin10_t;
  wire ja_0_pin1_i;
  wire ja_0_pin1_io;
  wire ja_0_pin1_o;
  wire ja_0_pin1_t;
  wire ja_0_pin2_i;
  wire ja_0_pin2_io;
  wire ja_0_pin2_o;
  wire ja_0_pin2_t;
  wire ja_0_pin3_i;
  wire ja_0_pin3_io;
  wire ja_0_pin3_o;
  wire ja_0_pin3_t;
  wire ja_0_pin4_i;
  wire ja_0_pin4_io;
  wire ja_0_pin4_o;
  wire ja_0_pin4_t;
  wire ja_0_pin7_i;
  wire ja_0_pin7_io;
  wire ja_0_pin7_o;
  wire ja_0_pin7_t;
  wire ja_0_pin8_i;
  wire ja_0_pin8_io;
  wire ja_0_pin8_o;
  wire ja_0_pin8_t;
  wire ja_0_pin9_i;
  wire ja_0_pin9_io;
  wire ja_0_pin9_o;
  wire ja_0_pin9_t;
  wire jb_pin10_i;
  wire jb_pin10_io;
  wire jb_pin10_o;
  wire jb_pin10_t;
  wire jb_pin1_i;
  wire jb_pin1_io;
  wire jb_pin1_o;
  wire jb_pin1_t;
  wire jb_pin2_i;
  wire jb_pin2_io;
  wire jb_pin2_o;
  wire jb_pin2_t;
  wire jb_pin3_i;
  wire jb_pin3_io;
  wire jb_pin3_o;
  wire jb_pin3_t;
  wire jb_pin4_i;
  wire jb_pin4_io;
  wire jb_pin4_o;
  wire jb_pin4_t;
  wire jb_pin7_i;
  wire jb_pin7_io;
  wire jb_pin7_o;
  wire jb_pin7_t;
  wire jb_pin8_i;
  wire jb_pin8_io;
  wire jb_pin8_o;
  wire jb_pin8_t;
  wire jb_pin9_i;
  wire jb_pin9_io;
  wire jb_pin9_o;
  wire jb_pin9_t;
  wire reset;
  wire sys_clock;
  wire usb_uart_rxd;
  wire usb_uart_txd;

  design_1 design_1_i
       (.DDR2_0_addr(DDR2_0_addr),
        .DDR2_0_ba(DDR2_0_ba),
        .DDR2_0_cas_n(DDR2_0_cas_n),
        .DDR2_0_ck_n(DDR2_0_ck_n),
        .DDR2_0_ck_p(DDR2_0_ck_p),
        .DDR2_0_cke(DDR2_0_cke),
        .DDR2_0_cs_n(DDR2_0_cs_n),
        .DDR2_0_dm(DDR2_0_dm),
        .DDR2_0_dq(DDR2_0_dq),
        .DDR2_0_dqs_n(DDR2_0_dqs_n),
        .DDR2_0_dqs_p(DDR2_0_dqs_p),
        .DDR2_0_odt(DDR2_0_odt),
        .DDR2_0_ras_n(DDR2_0_ras_n),
        .DDR2_0_we_n(DDR2_0_we_n),
        .eth_mdio_mdc_mdc(eth_mdio_mdc_mdc),
        .eth_mdio_mdc_mdio_i(eth_mdio_mdc_mdio_i),
        .eth_mdio_mdc_mdio_o(eth_mdio_mdc_mdio_o),
        .eth_mdio_mdc_mdio_t(eth_mdio_mdc_mdio_t),
        .eth_ref_clk(eth_ref_clk),
        .eth_rmii_crs_dv(eth_rmii_crs_dv),
        .eth_rmii_rx_er(eth_rmii_rx_er),
        .eth_rmii_rxd(eth_rmii_rxd),
        .eth_rmii_tx_en(eth_rmii_tx_en),
        .eth_rmii_txd(eth_rmii_txd),
        .ja_0_pin10_i(ja_0_pin10_i),
        .ja_0_pin10_o(ja_0_pin10_o),
        .ja_0_pin10_t(ja_0_pin10_t),
        .ja_0_pin1_i(ja_0_pin1_i),
        .ja_0_pin1_o(ja_0_pin1_o),
        .ja_0_pin1_t(ja_0_pin1_t),
        .ja_0_pin2_i(ja_0_pin2_i),
        .ja_0_pin2_o(ja_0_pin2_o),
        .ja_0_pin2_t(ja_0_pin2_t),
        .ja_0_pin3_i(ja_0_pin3_i),
        .ja_0_pin3_o(ja_0_pin3_o),
        .ja_0_pin3_t(ja_0_pin3_t),
        .ja_0_pin4_i(ja_0_pin4_i),
        .ja_0_pin4_o(ja_0_pin4_o),
        .ja_0_pin4_t(ja_0_pin4_t),
        .ja_0_pin7_i(ja_0_pin7_i),
        .ja_0_pin7_o(ja_0_pin7_o),
        .ja_0_pin7_t(ja_0_pin7_t),
        .ja_0_pin8_i(ja_0_pin8_i),
        .ja_0_pin8_o(ja_0_pin8_o),
        .ja_0_pin8_t(ja_0_pin8_t),
        .ja_0_pin9_i(ja_0_pin9_i),
        .ja_0_pin9_o(ja_0_pin9_o),
        .ja_0_pin9_t(ja_0_pin9_t),
        .jb_pin10_i(jb_pin10_i),
        .jb_pin10_o(jb_pin10_o),
        .jb_pin10_t(jb_pin10_t),
        .jb_pin1_i(jb_pin1_i),
        .jb_pin1_o(jb_pin1_o),
        .jb_pin1_t(jb_pin1_t),
        .jb_pin2_i(jb_pin2_i),
        .jb_pin2_o(jb_pin2_o),
        .jb_pin2_t(jb_pin2_t),
        .jb_pin3_i(jb_pin3_i),
        .jb_pin3_o(jb_pin3_o),
        .jb_pin3_t(jb_pin3_t),
        .jb_pin4_i(jb_pin4_i),
        .jb_pin4_o(jb_pin4_o),
        .jb_pin4_t(jb_pin4_t),
        .jb_pin7_i(jb_pin7_i),
        .jb_pin7_o(jb_pin7_o),
        .jb_pin7_t(jb_pin7_t),
        .jb_pin8_i(jb_pin8_i),
        .jb_pin8_o(jb_pin8_o),
        .jb_pin8_t(jb_pin8_t),
        .jb_pin9_i(jb_pin9_i),
        .jb_pin9_o(jb_pin9_o),
        .jb_pin9_t(jb_pin9_t),
        .reset(reset),
        .sys_clock(sys_clock),
        .usb_uart_rxd(usb_uart_rxd),
        .usb_uart_txd(usb_uart_txd));
  IOBUF eth_mdio_mdc_mdio_iobuf
       (.I(eth_mdio_mdc_mdio_o),
        .IO(eth_mdio_mdc_mdio_io),
        .O(eth_mdio_mdc_mdio_i),
        .T(eth_mdio_mdc_mdio_t));
  IOBUF ja_0_pin10_iobuf
       (.I(ja_0_pin10_o),
        .IO(ja_0_pin10_io),
        .O(ja_0_pin10_i),
        .T(ja_0_pin10_t));
  IOBUF ja_0_pin1_iobuf
       (.I(ja_0_pin1_o),
        .IO(ja_0_pin1_io),
        .O(ja_0_pin1_i),
        .T(ja_0_pin1_t));
  IOBUF ja_0_pin2_iobuf
       (.I(ja_0_pin2_o),
        .IO(ja_0_pin2_io),
        .O(ja_0_pin2_i),
        .T(ja_0_pin2_t));
  IOBUF ja_0_pin3_iobuf
       (.I(ja_0_pin3_o),
        .IO(ja_0_pin3_io),
        .O(ja_0_pin3_i),
        .T(ja_0_pin3_t));
  IOBUF ja_0_pin4_iobuf
       (.I(ja_0_pin4_o),
        .IO(ja_0_pin4_io),
        .O(ja_0_pin4_i),
        .T(ja_0_pin4_t));
  IOBUF ja_0_pin7_iobuf
       (.I(ja_0_pin7_o),
        .IO(ja_0_pin7_io),
        .O(ja_0_pin7_i),
        .T(ja_0_pin7_t));
  IOBUF ja_0_pin8_iobuf
       (.I(ja_0_pin8_o),
        .IO(ja_0_pin8_io),
        .O(ja_0_pin8_i),
        .T(ja_0_pin8_t));
  IOBUF ja_0_pin9_iobuf
       (.I(ja_0_pin9_o),
        .IO(ja_0_pin9_io),
        .O(ja_0_pin9_i),
        .T(ja_0_pin9_t));
  IOBUF jb_pin10_iobuf
       (.I(jb_pin10_o),
        .IO(jb_pin10_io),
        .O(jb_pin10_i),
        .T(jb_pin10_t));
  IOBUF jb_pin1_iobuf
       (.I(jb_pin1_o),
        .IO(jb_pin1_io),
        .O(jb_pin1_i),
        .T(jb_pin1_t));
  IOBUF jb_pin2_iobuf
       (.I(jb_pin2_o),
        .IO(jb_pin2_io),
        .O(jb_pin2_i),
        .T(jb_pin2_t));
  IOBUF jb_pin3_iobuf
       (.I(jb_pin3_o),
        .IO(jb_pin3_io),
        .O(jb_pin3_i),
        .T(jb_pin3_t));
  IOBUF jb_pin4_iobuf
       (.I(jb_pin4_o),
        .IO(jb_pin4_io),
        .O(jb_pin4_i),
        .T(jb_pin4_t));
  IOBUF jb_pin7_iobuf
       (.I(jb_pin7_o),
        .IO(jb_pin7_io),
        .O(jb_pin7_i),
        .T(jb_pin7_t));
  IOBUF jb_pin8_iobuf
       (.I(jb_pin8_o),
        .IO(jb_pin8_io),
        .O(jb_pin8_i),
        .T(jb_pin8_t));
  IOBUF jb_pin9_iobuf
       (.I(jb_pin9_o),
        .IO(jb_pin9_io),
        .O(jb_pin9_i),
        .T(jb_pin9_t));
endmodule
