
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY ram_block IS
   PORT (addra: IN std_logic_VECTOR(9 DOWNTO 0);
         addrb: IN std_logic_VECTOR(9 DOWNTO 0);
         clka:  IN std_logic;
         clkb:  IN std_logic;
         douta: OUT std_logic_VECTOR(15 DOWNTO 0);
         doutb: OUT std_logic_VECTOR(15 DOWNTO 0);
         ena:   IN std_logic;
         enb:   IN std_logic);
END ram_block;


architecture low_level_definition of ram_block is
    COMPONENT ram_dp_reg is
        generic (   data_width : integer;
                    address_width :integer);
        port (      data_a:in std_logic_vector(data_width-1 downto 0);
                    data_b:in std_logic_vector(data_width-1 downto 0);
                    addr_a:in std_logic_vector(address_width-1 downto 0);
                    addr_b:in std_logic_vector(address_width-1 downto 0);
                    wren_a:in std_logic;
                    wren_b:in std_logic;
                    clk:in std_logic;
                    q_a:out std_logic_vector(data_width-1 downto 0);
                    q_b:out std_logic_vector(data_width-1 downto 0) 
        );
    end COMPONENT;
begin

   uprom: ram_dp_reg
   --INIT values repeated to define contents for functional simulation
   generic map (   data_width => 16,
                    address_width => 10)
    PORT MAP ( q_a   => douta,
               q_b   => doutb,
               addr_a => addra,
               addr_b => addrb,
               clk  => clka,
               data_a   => (OTHERS => '0'),
               data_b   => (OTHERS => '0'),
               wren_a   => '0',
               wren_b   => '0');

end low_level_definition;

