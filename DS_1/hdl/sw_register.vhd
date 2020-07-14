--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: sw_register.vhd
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

entity sw_register is
port (
    --<port_name> : <direction> <type>;
    clk : IN std_logic;
	sw : IN  std_logic; -- example
    mss : OUT std_logic  -- example
    --<other_ports>;
);
end sw_register;
architecture architecture_sw_register of sw_register is

begin
    mss <= sw;
   -- architecture body
end architecture_sw_register;
