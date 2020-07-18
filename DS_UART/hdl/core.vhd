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
    --<port_name> : <direction> <type>;
	port_name1 : IN  std_logic; -- example
    port_name2 : OUT std_logic_vector(1 downto 0)  -- example
    --<other_ports>;
);
end core;
architecture architecture_core of core is
COMPONENT MSS2F is
    -- Port list
    port(
        -- Inputs
        DEVRST_N         : in  std_logic;
        GPIO_0_F2M       : in  std_logic;
        MMUART_0_RXD_F2M : in  std_logic;
        -- Outputs
        GPIO_1_M2F       : out std_logic;
        GPIO_OUT         : out std_logic_vector(7 downto 0);
        MMUART_0_TXD_M2F : out std_logic
        );
end COMPONENT;

    -- Inputs
    SIGNAL DEVRST_N         : std_logic;
    SIGNAL GPIO_0_F2M       : std_logic;
    SIGNAL MMUART_0_RXD_F2M : std_logic;
    -- Outputs
    SIGNAL GPIO_1_M2F       : std_logic;
    SIGNAL GPIO_OUT         : std_logic_vector(7 downto 0);
    SIGNAL MMUART_0_TXD_M2F : std_logic;
begin
mss: MSS2F 
    port map(
    DEVRST_N => DEVRST_N,
    GPIO_0_F2M => GPIO_0_F2M,
    MMUART_0_RXD_F2M => MMUART_0_RXD_F2M,
    
    GPIO_1_M2F => GPIO_1_M2F,
    GPIO_OUT => GPIO_OUT,
    MMUART_0_TXD_M2F => MMUART_0_TXD_M2F
    );
   -- architecture body
end architecture_core;
