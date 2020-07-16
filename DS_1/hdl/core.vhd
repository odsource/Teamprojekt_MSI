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
        AMBA_MASTER_0_HADDR_M0     : in  std_logic_vector(31 downto 0);
        AMBA_MASTER_0_HBURST_M0    : in  std_logic_vector(2 downto 0);
        AMBA_MASTER_0_HMASTLOCK_M0 : in  std_logic;
        AMBA_MASTER_0_HPROT_M0     : in  std_logic_vector(3 downto 0);
        AMBA_MASTER_0_HSIZE_M0     : in  std_logic_vector(2 downto 0);
        AMBA_MASTER_0_HTRANS_M0    : in  std_logic_vector(1 downto 0);
        AMBA_MASTER_0_HWDATA_M0    : in  std_logic_vector(31 downto 0);
        AMBA_MASTER_0_HWRITE_M0    : in  std_logic;
        DEVRST_N                   : in  std_logic;
        GPIO_1_F2M                 : in  std_logic;
        -- Outputs
        AMBA_MASTER_0_HRDATA_M0    : out std_logic_vector(31 downto 0);
        AMBA_MASTER_0_HREADY_M0    : out std_logic;
        AMBA_MASTER_0_HRESP_M0     : out std_logic_vector(1 downto 0);
        GPIO_0_M2F                 : out std_logic
        );
end COMPONENT;
    -- Inputs
	signal AMBA_MASTER_0_HADDR_M0     : std_logic_vector(31 downto 0);
    signal AMBA_MASTER_0_HBURST_M0    : std_logic_vector(2 downto 0);
    signal AMBA_MASTER_0_HMASTLOCK_M0 : std_logic;
    signal AMBA_MASTER_0_HPROT_M0     : std_logic_vector(3 downto 0);
    signal AMBA_MASTER_0_HSIZE_M0     : std_logic_vector(2 downto 0);
    signal AMBA_MASTER_0_HTRANS_M0    : std_logic_vector(1 downto 0);
    signal AMBA_MASTER_0_HWDATA_M0    : std_logic_vector(31 downto 0);
    signal AMBA_MASTER_0_HWRITE_M0    : std_logic;
    signal DEVRST_N                   : std_logic;
    signal GPIO_1_F2M                 : std_logic;
    
    -- Outputs
    signal AMBA_MASTER_0_HRDATA_M0    : std_logic_vector(31 downto 0);
    signal AMBA_MASTER_0_HREADY_M0    : std_logic;
    signal AMBA_MASTER_0_HRESP_M0     : std_logic_vector(1 downto 0);
    signal GPIO_0_M2F                 : std_logic;

begin

   -- architecture body
end architecture_core;
