LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;

ENTITY pwm_servo IS

    PORT (
        clk : IN STD_LOGIC;

        reset : IN STD_LOGIC;

        deg : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        pwm : OUT STD_LOGIC);

END pwm_servo;

ARCHITECTURE Behavioral OF pwm_servo IS
    CONSTANT period : INTEGER := 1000000;

    CONSTANT dcycle_max : INTEGER := 125000;

    CONSTANT dcycle_min : INTEGER := 25000;

    CONSTANT duty_in : INTEGER := 200;

    SIGNAL pwm_reg, pwm_next : STD_LOGIC;

    SIGNAL duty_cycle, duty_cycle_next : INTEGER := 0;

    SIGNAL counter, counter_next : INTEGER := 0;

    SIGNAL tick : STD_LOGIC;

BEGIN

    PROCESS (clk, reset)

    BEGIN

        IF reset = '0' THEN
            pwm_reg <= '0';
            counter <= 0;
            duty_cycle <= 0;
        ELSIF rising_edge(clk) THEN
            IF counter = period THEN
                counter <= 0;
            ELSE
                counter <= counter + 1;
            END IF;

            IF counter = 0 THEN
                tick <= '1';
            ELSE
                tick <= '0';
            END IF;

            IF counter < duty_cycle THEN
                pwm_reg <= '1';
            ELSE
                pwm_reg <= '0';
            END IF;

            IF tick = '1' THEN
                IF deg = "001" THEN

                    duty_cycle <= 50000;

                ELSIF deg = "010" THEN

                    duty_cycle <= 75000;

                ELSIF deg = "011" THEN

                    duty_cycle <= 100000;

                ELSIF deg = "100" THEN

                    duty_cycle <= dcycle_max;
                ELSE
                    duty_cycle <= dcycle_min;

                END IF;
            END IF;

        END IF;

    END PROCESS;

    pwm <= pwm_reg;

END Behavioral;