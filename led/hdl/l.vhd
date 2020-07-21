--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: l.vhd
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

entity l is
port (
    --<port_name> : <direction> <type>;
    sw : IN std_logic;
    led : OUT std_logic;  -- example
    led2 : OUT std_logic
    --<other_ports>;
);
end l;
architecture architecture_l of l is
COMPONENT tri is
port(
    switch : IN  std_logic; -- example
    light : OUT std_logic;  -- example
    sw_light : OUT std_logic
);
end COMPONENT;
SIGNAL one : std_logic := '1';
begin

t: tri
port map(
    switch => sw,
    light => led,
    sw_light => led2
);
   -- architecture body
end architecture_l;
