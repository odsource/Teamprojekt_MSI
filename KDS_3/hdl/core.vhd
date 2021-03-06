LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY core IS
   GENERIC(RSTDEF: std_logic := '0');
   PORT(rst:   IN  std_logic;                      -- reset,          RSTDEF active
        clk:   IN  std_logic;                      -- clock,          rising edge
        swrst: IN  std_logic;                      -- software reset, RSTDEF active
        strt:  IN  std_logic;                      -- start,          high active
        sw:    IN  std_logic_vector( 7 DOWNTO 0);  -- length counter, input
        res:   OUT std_logic_vector(43 DOWNTO 0);  -- result
        done:  OUT std_logic);                     -- done,           high active
END core;


ARCHITECTURE structure OF core IS

	COMPONENT ram_test IS -- anstatt ram_block wurde ram_test benutzt (ram_block ist eigens entwickelt, ram_test ist eine generierte Komponente)
    PORT (addra: IN  std_logic_VECTOR(9 DOWNTO 0);
         addrb:  IN  std_logic_VECTOR(9 DOWNTO 0);
         clka:   IN  std_logic;
         clkb:   IN  std_logic;
         douta:  OUT std_logic_VECTOR(17 DOWNTO 0);
         doutb:  OUT std_logic_VECTOR(17 DOWNTO 0);
         ena:    IN  std_logic;
         enb:    IN  std_logic;
         data_in:   IN std_logic_vector(17 downto 0));
	END COMPONENT;
    
    COMPONENT mult18x18 is
    -- Port list
    port(
        -- Inputs
        A    : in  std_logic_vector(17 downto 0);
        B    : in  std_logic_vector(17 downto 0);
        -- Outputs
        CDOUT : out std_logic_vector(43 downto 0); -- signed 44 bit output of P
        P : out std_logic_vector(35 downto 0)
        );
    end COMPONENT;
	
	type TState IS (INIT, IDLE, RM, RMA, A, M, SET);
	SIGNAL state: TState := INIT;
	
	SIGNAL addra: std_logic_VECTOR(9 DOWNTO 0);
    SIGNAL addrb: std_logic_VECTOR(9 DOWNTO 0);
	SIGNAL douta: std_logic_VECTOR(17 DOWNTO 0);
	SIGNAL doutb: std_logic_VECTOR(17 DOWNTO 0);
	SIGNAL extdouta: std_logic_VECTOR(17 DOWNTO 0);
	SIGNAL extdoutb: std_logic_VECTOR(17 DOWNTO 0);
    SIGNAL enr:   std_logic;
	SIGNAL enadd: std_logic;	
    SIGNAL data_in: std_logic_vector(17 downto 0);
	
	SIGNAL multres: std_logic_vector(35 DOWNTO 0);
    SIGNAL multres_signed: std_logic_vector(43 DOWNTO 0);
	SIGNAL result: std_logic_vector(43 DOWNTO 0);
	SIGNAL counter: std_logic_vector(7 DOWNTO 0);
	
	SIGNAL s: std_logic := '1';

BEGIN

	rb: ram_test  -- auch hier wurde ram_test statt ram_block verwendet
	PORT MAP(
		douta 	=> douta,
        doutb	=> doutb,
        addra	=> addra,
        addrb	=> addrb,
        clka	=> clk,
        clkb	=> clk,
        ena		=> enr,
        enb		=> enr,
        data_in => data_in
	);
	--extdouta <= SXT(douta,18);
	--extdoutb <= SXT(doutb,18);
	mult: MULT18X18
	PORT MAP(
		A		=> douta, --extdouta,
		B		=> doutb, --extdoutb,
		--C		=> clk,
		--CE		=> ce,
		--R		=> rst,
        CDOUT   => multres_signed,
		P		=> multres
	);
	
	
	
			 
	steuerwerk: PROCESS(rst, clk)
	BEGIN
		if rst = RSTDEF then
			state <= INIT;
			enr <= '0';
			done <= '0';
			enadd <= '0';
            s <= '1';
			res <= (others => '0');
		elsif rising_edge(clk) then
				case state is
                    when INIT =>
                        counter <= counter + '1';
                        if s = '1' then
                            addra <= (others => '0');
                            addrb <= "0100000000";
                            data_in <= (others => '0');
                            counter <= (others => '0');
                            s <= '0';
                            enr <= '1';
                        end if;
                        addra(7 downto 0) <= counter;
                        addrb(7 downto 0) <= counter;
                        data_in(7 downto 0) <= counter;
                        if counter = 255 then
                            enr <= '0';
                            state <= IDLE;
                        end if;
					when IDLE =>
						enr <= '0';
						enadd <= '0';
						counter <= (others => '0');
						if strt = '1' then
							res <= (others => '0');
							if sw /= "00000000" then
								done <= '0';
								addra <= (others => '0');
								addrb <= "0100000000";
								--enr <= '1';
								counter <= counter + '1';
								if sw = "00000001" then
									state <= M;
								else
									state <= RM;
								end if;
							else
								state <= A;
							end if;
						end if;
					when RM =>
						addra(7 DOWNTO 0) <= counter;
						addrb(7 DOWNTO 0) <= counter;
						counter <= counter + '1';
						enadd <= '1';
						if sw = "00000010" then
							state <= M;
						else
							state <= RMA;
						end if;
					when RMA =>
						addra(7 DOWNTO 0) <= counter;
						addrb(7 DOWNTO 0) <= counter;
						counter <= counter + '1';
						if counter = sw then
							enr <= '0';
							state <= A;
						end if;
					when A =>
						state <= SET;
					when M =>
						enr <= '0';
						enadd <= '1';
						state <= A;
					when SET =>
						enadd <= '0';
						done <= '1';
						res <= result;
						state <= IDLE;
				end case;
				if swrst = RSTDEF then
					state <= INIT;
					enr <= '0';
					done <= '0';
					enadd <= '0';
					res <= (others => '0');
				end if;
		end if;
	END PROCESS;
	
	
	addierer_akk: PROCESS(rst, clk)
	BEGIN
		if rst = RSTDEF then
			result <= (others => '0');
		elsif rising_edge(clk) then
			
			if enadd = '1' then
				result <= result + SXT(multres, 44);--multres_signed;--SXT(multres, 44);
			else
				result <= (others => '0');
			end if;
			if swrst = RSTDEF then
				result <= (others => '0');
			end if;
		end if;
	END PROCESS;
		
END structure;