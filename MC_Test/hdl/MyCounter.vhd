--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: MyCounter.vhd
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
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity MyCounter is
port (
	clock : IN  std_logic; 
    Q : OUT std_logic_vector(22 downto 0);
    Aclr : in std_logic;
    Tcnt : out std_logic
);
end MyCounter;

architecture behavioral of MyCounter is
   	signal Qaux : UNSIGNED(22 downto 0);
begin
    process(Clock, Aclr)
    begin
        if (Aclr = '0') then
            Qaux <= (others => '0');
        elsif (clock'event and clock = '1') then
            Qaux <= Qaux + 1;
        end if;
    end process;
    
    Q <= std_logic_vector(Qaux);
    process(Qaux)
        variable aux : std_logic;
    begin
        aux := '0';
        if Qaux = 8 then 
            aux := '1';
        end if;
        Tcnt <= aux;
    end process;
end behavioral;
