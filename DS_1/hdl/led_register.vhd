--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: led_register.vhd
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

entity led_register is
port (
	-- Inputs
    clk : IN std_logic;
    mss_led  : in  std_logic;
    -- Outputs
    led_reg : out std_logic
);
end led_register;
architecture architecture_led_register of led_register is

begin

   led_reg <= mss_led;
end architecture_led_register;
