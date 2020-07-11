----------------------------------------------------------------------
-- Created by SmartDesign Fri Jul 10 13:32:37 2020
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
-- mult18x18 entity declaration
----------------------------------------------------------------------
entity mult18x18 is
    -- Port list
    port(
        -- Inputs
        A    : in  std_logic_vector(17 downto 0);
        B    : in  std_logic_vector(17 downto 0);
        -- Outputs
        P : out std_logic_vector(35 downto 0)
        );
end mult18x18;
----------------------------------------------------------------------
-- mult18x18 architecture body
----------------------------------------------------------------------
architecture RTL of mult18x18 is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- HARD_MULT_C0
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
signal P_net_0 : std_logic_vector(35 downto 0);
signal P_net_1 : std_logic_vector(35 downto 0);

begin

----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 P_net_1        <= P_net_0;
 P(35 downto 0) <= P_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- HARD_MULT_C0_0
HARD_MULT_C0_0 : HARD_MULT_C0
    port map( 
        -- Inputs
        A0    => A,
        B0    => B,
        -- Outputs
        P     => P_net_0,
        CDOUT => OPEN 
        );

end RTL;
