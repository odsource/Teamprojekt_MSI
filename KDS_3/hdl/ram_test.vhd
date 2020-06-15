----------------------------------------------------------------------
-- Created by SmartDesign Thu Jun 11 14:20:56 2020
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
-- ram_test entity declaration
----------------------------------------------------------------------
entity ram_test is
    -- Port list
    PORT (addra: IN std_logic_VECTOR(9 DOWNTO 0);
         addrb: IN std_logic_VECTOR(9 DOWNTO 0);
         clka:  IN std_logic;
         clkb:  IN std_logic;
         douta: OUT std_logic_VECTOR(15 DOWNTO 0);
         doutb: OUT std_logic_VECTOR(15 DOWNTO 0);
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
-- RAM1K18
component RAM1K18
    generic( 
        MEMORYFILE : string := "" ;
        RAMINDEX   : string := "" 
        );
    -- Port list
    port(
        -- Inputs
        A_ADDR        : in  std_logic_vector(13 downto 0);
        A_ARST_N      : in  std_logic;
        A_BLK         : in  std_logic_vector(2 downto 0);
        A_CLK         : in  std_logic;
        A_DIN         : in  std_logic_vector(17 downto 0);
        A_DOUT_ARST_N : in  std_logic;
        A_DOUT_CLK    : in  std_logic;
        A_DOUT_EN     : in  std_logic;
        A_DOUT_LAT    : in  std_logic;
        A_DOUT_SRST_N : in  std_logic;
        A_EN          : in  std_logic;
        A_WEN         : in  std_logic_vector(1 downto 0);
        A_WIDTH       : in  std_logic_vector(2 downto 0);
        A_WMODE       : in  std_logic;
        B_ADDR        : in  std_logic_vector(13 downto 0);
        B_ARST_N      : in  std_logic;
        B_BLK         : in  std_logic_vector(2 downto 0);
        B_CLK         : in  std_logic;
        B_DIN         : in  std_logic_vector(17 downto 0);
        B_DOUT_ARST_N : in  std_logic;
        B_DOUT_CLK    : in  std_logic;
        B_DOUT_EN     : in  std_logic;
        B_DOUT_LAT    : in  std_logic;
        B_DOUT_SRST_N : in  std_logic;
        B_EN          : in  std_logic;
        B_WEN         : in  std_logic_vector(1 downto 0);
        B_WIDTH       : in  std_logic_vector(2 downto 0);
        B_WMODE       : in  std_logic;
        SII_LOCK      : in  std_logic;
        -- Outputs
        A_DOUT        : out std_logic_vector(15 downto 0);
        BUSY          : out std_logic;
        B_DOUT        : out std_logic_vector(15 downto 0)
        );
end component;

begin

----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- RAM1K18_0
RAM1K18_0 : RAM1K18
    port map( 
        -- Inputs
        A_CLK         => clka,
        A_DOUT_CLK    => clka,
        A_ARST_N      => '1',
        A_DOUT_EN     => ,
        A_DOUT_ARST_N => ,
        A_DOUT_SRST_N => ,
        B_CLK         => clkb,
        B_DOUT_CLK    => clkb,
        B_ARST_N      => '1',
        B_DOUT_EN     => ,
        B_DOUT_ARST_N => ,
        B_DOUT_SRST_N => ,
        A_EN          => ena,
        A_DOUT_LAT    => ,
        A_WMODE       => ,
        B_EN          => enb,
        B_DOUT_LAT    => ,
        B_WMODE       => ,
        SII_LOCK      => ,
        A_BLK         => ,
        A_DIN         => (others => 0),
        A_ADDR        => addra & "0000",
        A_WEN         => "00",
        B_BLK         => ,
        B_DIN         => (others => 0),
        B_ADDR        => addrb & "0000",
        B_WEN         => "00",
        A_WIDTH       => "100",
        B_WIDTH       => "100",
        -- Outputs
        BUSY          => OPEN,
        A_DOUT        => douta,
        B_DOUT        => doutb 
        );

end RTL;
