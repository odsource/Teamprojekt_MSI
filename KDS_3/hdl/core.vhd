LIBRARY ieee, unisim;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_arith.ALL;
USE unisim.VComponents.ALL;
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

	COMPONENT ram_block IS
    PORT (addra: IN  std_logic_VECTOR(9 DOWNTO 0);
         addrb:  IN  std_logic_VECTOR(9 DOWNTO 0);
         clka:   IN  std_logic;
         clkb:   IN  std_logic;
         douta:  OUT std_logic_VECTOR(15 DOWNTO 0);
         doutb:  OUT std_logic_VECTOR(15 DOWNTO 0);
         ena:    IN  std_logic;
         enb:    IN  std_logic);
	END COMPONENT;
	
	type TState IS (IDLE, RM, RMA, A, M, SET);
	SIGNAL state: TState := IDLE;
	
	SIGNAL addra: std_logic_VECTOR(9 DOWNTO 0);
    SIGNAL addrb: std_logic_VECTOR(9 DOWNTO 0);
	SIGNAL douta: std_logic_VECTOR(15 DOWNTO 0);
	SIGNAL doutb: std_logic_VECTOR(15 DOWNTO 0);
	SIGNAL extdouta: std_logic_VECTOR(17 DOWNTO 0);
	SIGNAL extdoutb: std_logic_VECTOR(17 DOWNTO 0);
    SIGNAL enr:   std_logic;
	SIGNAL enadd: std_logic;	
	
	SIGNAL multres: std_logic_vector(35 DOWNTO 0);
	SIGNAL result: std_logic_vector(43 DOWNTO 0);
	SIGNAL counter: std_logic_vector(7 DOWNTO 0);
	
	

BEGIN

	rb: ram_block
	PORT MAP(
		douta 	=> douta,
        doutb	=> doutb,
        addra	=> addra,
        addrb	=> addrb,
        clka	=> clk,
        clkb	=> clk,
        ena		=> enr,
        enb		=> enr
	);
	extdouta <= SXT(douta,18);
	extdoutb <= SXT(doutb,18);
	mult: MULT18X18
	PORT MAP(
		A		=> extdouta,
		B		=> extdoutb,
		--C		=> clk,
		--CE		=> ce,
		--R		=> rst,
		P		=> multres
	);
	
	
	
			 
	steuerwerk: PROCESS(rst, clk)
	BEGIN
		if rst = RSTDEF then
			state <= IDLE;
			enr <= '0';
			done <= '0';
			enadd <= '0';
			res <= (others => '0');
		elsif rising_edge(clk) then
				case state is
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
								enr <= '1';
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
					state <= IDLE;
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
				result <= result + SXT(multres, 44);
			else
				result <= (others => '0');
			end if;
			if swrst = RSTDEF then
				result <= (others => '0');
			end if;
		end if;
	END PROCESS;
		
END structure;