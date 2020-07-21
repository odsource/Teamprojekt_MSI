--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: tri.vhd
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

entity tri is
port (
    --<port_name> : <direction> <type>;
	switch : IN  std_logic; -- example
    light : OUT std_logic;  -- example
    sw_light : OUT std_logic
    --<other_ports>;
);
end tri;
architecture architecture_tri of tri is
   -- signal, component etc. declarations
	signal an : std_logic := '1';

begin


    light <= an;
    sw_light <= switch;
   -- architecture body
end architecture_tri;
