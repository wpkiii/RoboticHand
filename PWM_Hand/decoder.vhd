-----------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;
--Additional standard or custom libraries go here 

ENTITY decoder IS
    PORT (
        --You will replace these with your actual inputs and outputs
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        data_in : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        pwm_pos_out : OUT STD_LOGIC_VECTOR (14 DOWNTO 0);
        led_out : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
    );
END ENTITY decoder;
ARCHITECTURE data_flow OF decoder IS
    --Signals and components go here 
    SIGNAL temp_led : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL temp_pos : STD_LOGIC_VECTOR (14 DOWNTO 0);
	 SIGNAL change_led : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL change_pos : STD_LOGIC_VECTOR (14 DOWNTO 0);
    SIGNAL waitTime : INTEGER := 0;
	 SIGNAL tick :  STD_LOGIC;
BEGIN

    temp_led <= "00000001" WHEN data_in = "0000" ELSE
        "00000010" WHEN data_in = "0001" ELSE
        "00000100" WHEN data_in = "0010" ELSE
        "00001000" WHEN data_in = "0011" ELSE
        "00010000" WHEN data_in = "0100" ELSE
        "00100000" WHEN data_in = "0101" ELSE
        "01000000" WHEN data_in = "0110" ELSE
        "10000000" WHEN data_in = "0111" ELSE
        change_led;

    temp_pos <= "001001001001011" WHEN data_in = "0000" ELSE --fist
        "001001100100011" WHEN data_in = "0001" ELSE --yeah
        "011001001011011" WHEN data_in = "0010" ELSE --rock
        "001000000010010" WHEN data_in = "0011" ELSE --point
        "100100100100000" WHEN data_in = "0100" ELSE --paw
        "011011011001011" WHEN data_in = "0101" ELSE --ok
        "011001001001001" WHEN data_in = "0110" ELSE --six
        "001001001001001" WHEN data_in = "0110" ELSE --good
        change_pos;

    PROCESS (clk, reset)
    BEGIN
        IF reset = '0' THEN
            change_pos <= "100011010001000";
				tick <= '1';
        ELSIF rising_edge(clk) THEN
            IF waitTime < 40000000 THEN
                waitTime <= waitTime + 1;
					 tick <= '0';
            ELSE
                waitTime <= 0;
					 tick <= '1';
            END IF;
				
				if tick = '1' then 
				    change_led <= std_logic_vector( unsigned(change_led) + 1 );
					 change_pos(2 downto 0) <= std_logic_vector( unsigned(change_pos(2 downto 0) )+ 1 );
					 change_pos(5 downto 3) <= std_logic_vector( unsigned(change_pos(5 downto 3) )+ 1 );
					 change_pos(8 downto 6) <= std_logic_vector( unsigned(change_pos(8 downto 6) )+ 1 );
					 change_pos(11 downto 9) <= std_logic_vector( unsigned(change_pos(11 downto 9) )+ 1 );
					 change_pos(14 downto 12) <= std_logic_vector( unsigned(change_pos(14 downto 12) )+ 1 );
				end if;
        END IF;

    END PROCESS;

    led_out <= temp_led;
    pwm_pos_out <= temp_pos;

END ARCHITECTURE data_flow;
-----------------------------------------------------------------------------