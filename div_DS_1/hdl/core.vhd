--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: core.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::SmartFusion2> <Die::M2S005> <Package::144 TQ>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;

entity core is
port (
    clk:  IN  std_logic;
	sw_input : IN  std_logic;
    led : OUT std_logic;
    LED1 : OUT std_logic
);
end core;
architecture architecture_core of core is
   -- signal, component etc. declarations
COMPONENT sw_register is
port(
        -- Inputs
        clk:  IN  std_logic;
        sw  : in  std_logic;
        -- Outputs
        mss : out std_logic
        );
END COMPONENT;

COMPONENT led_register is
port(
        -- Inputs
        clk:  IN  std_logic;
        mss_led  : in  std_logic;
        -- Outputs
        led_reg : out std_logic
        );
END COMPONENT;

COMPONENT MSS2F is
port(
        -- Inputs
        DEVRST_N         : in  std_logic;
        GPIO_1           : in  std_logic;
        MMUART_0_CLK_F2M : in  std_logic;
        MMUART_0_RXD_F2M : in  std_logic;
        RX               : in  std_logic;
        -- Outputs
        GPIO_0           : out std_logic;
        MMUART_0_TXD_M2F : out std_logic;
        TX               : out std_logic
        );
end COMPONENT;

SIGNAL sw: std_logic;
SIGNAL mss: std_logic;

SIGNAL mss_led: std_logic;
SIGNAL led_reg: std_logic;

SIGNAL DEVRST_N: std_logic;
SIGNAL GPIO_1: std_logic;
SIGNAL GPIO_0: std_logic;
SIGNAL MMUART_0_CLK_F2M: std_logic;
SIGNAL MMUART_0_RXD_F2M: std_logic;
SIGNAL RX: std_logic;
begin

--LED1 <= '0';

sw_r : sw_register
    port map( 
        -- Input
        clk => clk,
        sw         => sw,
        -- Output
        mss        => mss
        );
    sw <= sw_input;
   
led_r : led_register
    port map(
        -- Input
        clk => clk,
        mss_led         => mss_led,
        -- Output
        led_reg        => led_reg
        );
    led <= led_reg;

mc : MSS2F
    port map(
        -- Inputs
        DEVRST_N => DEVRST_N,
        GPIO_1 => GPIO_1,
        MMUART_0_CLK_F2M => MMUART_0_CLK_F2M,
        MMUART_0_RXD_F2M => MMUART_0_RXD_F2M,
        RX => RX,
        -- Outputs
        GPIO_0 => GPIO_0,
        MMUART_0_TXD_M2F => OPEN,--MMUART_0_TXD_M2F,
        TX => OPEN--TX
        );
    GPIO_1 <= mss;
    mss_led <= GPIO_0;
end architecture_core;
