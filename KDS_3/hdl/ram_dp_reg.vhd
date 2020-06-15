library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ram_dp_reg is
    generic (   data_width : integer := 16;
                address_width :integer := 10 );
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
end ram_dp_reg;

architecture rtl of ram_dp_reg is
    type mem_array is array(0 to 2**(address_width) -1) of std_logic_vector(data_width-1 downto 0);
    signal mem : mem_array;
    attribute syn_ramstyle : string;
    attribute syn_ramstyle of mem : signal is "no_rw_check" ;
    signal addr_a_reg : std_logic_vector(address_width-1 downto 0);
    signal addr_b_reg : std_logic_vector(address_width-1 downto 0);
begin
    WRITE_RAM : process (clk)
    begin
        if rising_edge(clk) then
            if (wren_a = '1') then
                mem(to_integer(unsigned(addr_a))) <= data_a;
            end if;
            if (wren_b='1') then
                mem(to_integer(unsigned(addr_b))) <= data_b;
            end if;
            addr_a_reg <= addr_a;
            addr_b_reg <= addr_b;
        end if;
    end process WRITE_RAM;
    
    q_a <= mem(to_integer(unsigned(addr_a_reg)));
    q_b <= mem(to_integer(unsigned(addr_b_reg)));
end rtl;