----------------------------------------------------------------------
-- Created by SmartDesign Thu Jun 11 14:20:56 2020
-- Version: v12.2 12.700.0.22
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL;

library smartfusion2;
use smartfusion2.all;
----------------------------------------------------------------------
-- ram_test entity declaration
----------------------------------------------------------------------
entity ram_test is
    -- Port list
    PORT (addra: IN std_logic_VECTOR(9 DOWNTO 0);
         addrb: IN std_logic_VECTOR(9 DOWNTO 0);
         clka:  IN std_logic;
         clkb:  IN std_logic;
         douta: OUT std_logic_vector(17 downto 0);
         doutb: OUT std_logic_vector(17 downto 0);
         ena:   IN std_logic;
         enb:   IN std_logic);
end ram_test;
----------------------------------------------------------------------
-- ram_test architecture body
----------------------------------------------------------------------
architecture RTL of ram_test is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- DPSRAM
COMPONENT ram_dp is
    -- Port list
    port(
        -- Inputs
        A_ADDR : in  std_logic_vector(9 downto 0);
        A_CLK  : in  std_logic;
        A_DIN  : in  std_logic_vector(17 downto 0);
        A_WEN  : in  std_logic;
        B_ADDR : in  std_logic_vector(9 downto 0);
        B_CLK  : in  std_logic;
        B_DIN  : in  std_logic_vector(17 downto 0);
        B_WEN  : in  std_logic;
        -- Outputs
        A_DOUT : out std_logic_vector(17 downto 0);
        B_DOUT : out std_logic_vector(17 downto 0)
        );
end COMPONENT;

SIGNAL counter: integer range 0 to 2**8-1;
SIGNAL a_data: std_logic_vector(17 downto 0) := "000000000000000000";
SIGNAL b_data: std_logic_vector(17 downto 0) := "000000000000000000";
SIGNAL awen: std_logic := '0';
SIGNAL bwen: std_logic := '0';
SIGNAL filled: std_logic := '0';
begin

----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- DPSRAM
ram : ram_dp
    port map( 
        -- Inputs
        A_ADDR        => addra,
        A_CLK         => clka,
        A_DIN         => a_data,
        A_WEN         => awen,
        B_ADDR        => addrb,
        B_CLK         => clkb,
        B_DIN         => b_data,
        B_WEN         => bwen,
        -- Outputs
        A_DOUT        => douta,
        B_DOUT        => doutb
        );
        
-- Fill RAM
PROCESS (ena, enb) is
begin
    if ena = '1' and enb = '1' and filled = '0' then
        awen <= '1';
        bwen <= '1';
        if counter = 255 then
            filled <= '1';
            awen <= '0';
            bwen <= '0';
        end if;
        
        counter <= (counter+1) mod 2**8;
    else
    
    end if;
end process;

end RTL;
