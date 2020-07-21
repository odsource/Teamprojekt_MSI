----------------------------------------------------------------------
-- Created by SmartDesign Tue Jul 21 12:28:23 2020
-- Version: v12.2 12.700.0.22
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library smartfusion2;
use smartfusion2.all;
----------------------------------------------------------------------
-- mult18x18_v2 entity declaration
----------------------------------------------------------------------
entity mult18x18_v2 is
    -- Port list
    port(
        -- Inputs
        A0    : in  std_logic_vector(17 downto 0);
        B0    : in  std_logic_vector(17 downto 0);
        -- Outputs
        CDOUT : out std_logic_vector(43 downto 0);
        P     : out std_logic_vector(35 downto 0)
        );
end mult18x18_v2;
----------------------------------------------------------------------
-- mult18x18_v2 architecture body
----------------------------------------------------------------------
architecture RTL of mult18x18_v2 is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- HARD_MULT_C2
component HARD_MULT_C0
    -- Port list
    port(
        -- Inputs
        A0    : in  std_logic_vector(17 downto 0);
        B0    : in  std_logic_vector(17 downto 0);
        -- Outputs
        CDOUT : out std_logic_vector(43 downto 0);
        P     : out std_logic_vector(35 downto 0)
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal CDOUT_net_0 : std_logic_vector(43 downto 0);
signal P_net_0     : std_logic_vector(35 downto 0);
signal CDOUT_net_1 : std_logic_vector(43 downto 0);
signal P_net_1     : std_logic_vector(35 downto 0);

begin
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 CDOUT_net_1        <= CDOUT_net_0;
 CDOUT(43 downto 0) <= CDOUT_net_1;
 P_net_1            <= P_net_0;
 P(35 downto 0)     <= P_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- HARD_MULT_C2_0
HARD_MULT_C2_0 : HARD_MULT_C0
    port map( 
        -- Inputs
        A0    => A0,
        B0    => B0,
        -- Outputs
        P     => P_net_0,
        CDOUT => CDOUT_net_0 
        );

end RTL;
