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
    clk : IN std_logic;
	switch : IN  std_logic_vector(7 DOWNTO 0); -- example
    LED : OUT std_logic_vector(1 downto 0)  -- example
    --<other_ports>;
); 
end core;
architecture architecture_core of core is
COMPONENT MSS2F is
    -- Port list
    port(
        -- Inputs
        DEVRST_N     : in  std_logic;
        GPIO_1_F2M   : in  std_logic;
        HADDR_M1     : in  std_logic_vector(31 downto 0);
        HBURST_M1    : in  std_logic_vector(2 downto 0);
        HCLK         : in  std_logic;
        HMASTLOCK_M1 : in  std_logic;
        HPROT_M1     : in  std_logic_vector(3 downto 0);
        HRESETN      : in  std_logic;
        HSIZE_M1     : in  std_logic_vector(2 downto 0);
        HTRANS_M1    : in  std_logic_vector(1 downto 0);
        HWDATA_M1    : in  std_logic_vector(31 downto 0);
        HWRITE_M1    : in  std_logic;
        MSS_INT_F2M  : in  std_logic_vector(15 downto 0);
        REMAP_M0     : in  std_logic;
        -- Outputs
        FIC_0_CLK    : out std_logic;
        FIC_0_LOCK   : out std_logic;
        GPIO_0_M2F   : out std_logic;
        HRDATA_M1    : out std_logic_vector(31 downto 0);
        HREADY_M1    : out std_logic;
        HRESP_M1     : out std_logic_vector(1 downto 0)
        );
end COMPONENT;
        -- Inputs
    SIGNAL    DEVRST_N     : std_logic;
    SIGNAL    GPIO_1_F2M   : std_logic;
    SIGNAL    HADDR_M1     : std_logic_vector(31 downto 0);
    SIGNAL    HBURST_M1    : std_logic_vector(2 downto 0);
    SIGNAL    HCLK         : std_logic;
    SIGNAL    HMASTLOCK_M1 : std_logic;
    SIGNAL    HPROT_M1     : std_logic_vector(3 downto 0);
    SIGNAL    HRESETN      : std_logic;
    SIGNAL    HSIZE_M1     : std_logic_vector(2 downto 0);
    SIGNAL    HTRANS_M1    : std_logic_vector(1 downto 0);
    SIGNAL    HWDATA_M1    : std_logic_vector(31 downto 0);
    SIGNAL    HWRITE_M1    : std_logic;
    SIGNAL    MSS_INT_F2M  : std_logic_vector(15 downto 0);
    SIGNAL    REMAP_M0     : std_logic;
    
        -- Outputs
    SIGNAL    FIC_0_CLK    : std_logic;
    SIGNAL    FIC_0_LOCK   : std_logic;
    SIGNAL    GPIO_0_M2F   : std_logic;
    SIGNAL    HRDATA_M1    : std_logic_vector(31 downto 0);
    SIGNAL    HREADY_M1    : std_logic;
    SIGNAL    HRESP_M1     : std_logic_vector(1 downto 0);

begin
MSS : MSS2F
    port map( 
        -- Inputs
        HADDR_M1     => HADDR_M1,
        HTRANS_M1    => HTRANS_M1,
        HWRITE_M1    => HWRITE_M1,
        HSIZE_M1     => HSIZE_M1,
        HBURST_M1    => HBURST_M1,
        HPROT_M1     => HPROT_M1,
        HWDATA_M1    => HWDATA_M1,
        HMASTLOCK_M1 => HMASTLOCK_M1,
        MSS_INT_F2M  => MSS_INT_F2M,
        REMAP_M0     => REMAP_M0,
        HRESETN      => HRESETN,
        DEVRST_N     => DEVRST_N,
        GPIO_1_F2M   => GPIO_1_F2M,
        HCLK         => clk,
        -- Outputs
        FIC_0_CLK    => FIC_0_CLK,
        FIC_0_LOCK   => FIC_0_LOCK,
        GPIO_0_M2F   => GPIO_0_M2F,
        HRDATA_M1    => HRDATA_M1,
        HREADY_M1    => HREADY_M1,
        HRESP_M1     => HRESP_M1
        );
   -- architecture body
end architecture_core;
