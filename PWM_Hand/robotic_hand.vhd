LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;

ENTITY robotic_hand IS

    PORT (
        clk : IN STD_LOGIC;

        reset : IN STD_LOGIC;

        SW : IN STD_LOGIC_vector(3 downto 0);

		  pwm : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);

        LED : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)

    );

END robotic_hand;

ARCHITECTURE Behavioral OF robotic_hand IS

    SIGNAL led_t, led_c : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
	 SIGNAL servo : STD_LOGIC_VECTOR(14 DOWNTO 0) := "000000000000000";
    SIGNAL pwm_t, pwm_c : STD_LOGIC_VECTOR(14 DOWNTO 0) := "000000000000000";
    SIGNAL event_clk : STD_LOGIC;

    COMPONENT pwm_servo IS
        PORT (
            clk : IN STD_LOGIC;

            reset : IN STD_LOGIC;

            deg: IN Std_logic_vector(2 downto 0);

            pwm : OUT STD_LOGIC);
    END COMPONENT;
	 
	 COMPONENT decoder IS
        PORT (
		      clk : in std_logic;
            reset: in std_logic;
            data_in : in std_logic_vector (3 downto 0);
            pwm_pos_out: out std_logic_vector (14 downto 0);
            led_out : out std_logic_vector (7 downto 0));
    END COMPONENT;

BEGIN
 
 
    deo: decoder
	 PORT MAP(
	     clk => clk,
        reset => reset,
        data_in => SW,
        pwm_pos_out => pwm_t,
        led_out => led_t
    );
	 
	 g1: For i In 0 to 4 generate
	 begin 
	 sv4 : pwm_servo
    PORT MAP(
        clk => clk,
        reset => reset,
        deg => servo((3*i + 2) downto (3*i)),
        pwm => pwm(i)
    );
	 End generate;


    PROCESS (clk, reset)
    BEGIN
        IF reset = '0' THEN
            led_c <= (OTHERS => '0');
            pwm_c <= "001001001001011";-- fist
        ELSIF rising_edge(clk) THEN
            pwm_c <= pwm_t;
            led_c <= led_t;
        END IF;

    END PROCESS;
	   servo <= pwm_c;
      LED <= led_c;
END Behavioral;