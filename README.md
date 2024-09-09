# RoboticHand
In this project I helped design a system for controlling the five servos on each finger of the robotic hand in order to produce eight various hand gestures and assign an LED to each gesture using three switches on DE-nano10.


Background Information:
PWM, which stands for Pulse Width Modulation, is a method of controlling devices by varying the pulse width. Servo motors are controlled by pulse-width modulation (PWM) signals. Pulse width, or more simply, the duration of the signal's high portion, determines the angle of the servo motor. The interval between each pulse in a servo motor is 20ms (20,000 us). Using the servo specification supplied in the next part as an illustration, a PWM pulse range of 500-2500 us indicates that if the signal is set high for 0.5ms out of a total of 20ms, the servo will move completely to 0°. If the signal is set high for 2.5ms out of a total of 20ms, the servo will turn to 180°.
 
                          Figure 1. PWM signal for servo motor. 




Degree	Pulse: ms(p)
0	0.5
45	1
90	1.5
135	2
180	2.5

As stated previously, the period between each pulse is 20ms (20,000 us), which converts to 50Hz. Using a 50MHz clock requires a 10^6 counter to adjust the pulse interval. The following equation can be used to calculate the number of counts out of 10^6 that the signal should be high:
                       (Min PWM Pulse +  Angle/(Rotate Range)  × PWM Pulse Range(ms)) ×  〖10^6〗^ /(20(ms))
Based on the Servo Specification, this servo's rotation range is 180°, and its PWM pulse range is between 0.5 and 2.5ms (500-2500us). Hence, the count of the signal that must be high in order to rotate the servo 45 degrees is:   
                              (0.5ms +  45/180  × (2.5ms - 0.5ms)) ×  〖10^6〗^ /(20(ms))=50000    
This indicates that, for each 10^6 Count, the PWM signal should be high for 50000 counts and low for the remaining period.            
                                                
    Servo Specification:
Type: LFD-01 Servo
Stall current: 700mA
Control method: PWM
PWM pulse: 500-2500us(0-180°)
Rotate speed: 0.12sec/60°4.8V, 0.10sec/60°6V
Stall torque: 1.5KG.cm 4.8V, 1.8KG.cm 6V
No-load current: 50mA
Weight: 10g
Size: 32.5*12*29.85mm
Working voltage: 4.8V-6V
Servo wire: 26cm
Rotate range: 0-180°

Lab description:
	Create a new Project
	In Quartus, launch a new project. The top-level entity should be named "robotic_hand" and this project will include two more entities: one for producing the PWM signal for servo and another for decoding the four buttons used to control hand movements and LED.
----------------------------------------------------------------------------- 
library IEEE; 
use IEEE.std_logic_1164.all; 
--Additional standard or custom libraries go here 
entity robotic_hand is 
port( 
--You will replace these with your actual inputs and outputs
inputs : in std_logic;
 outputs : out std_logic ); 
    		end entity robotic_hand; 
architecture structural of robotic_hand is
 --Signals and components go here 
begin
 --Structural design goes here
 end architecture structural; -----------------------------------------------------------------------------
	Remember to set this entity as the top level before you compile, as the compilation tools in Quartus Prime will always return an error if there is no entity set as the top level. Although you do not need to complete the top-level entity at this time, you must include necessary information such as input, output, port map, and more when working on subsequent entities.
	In Quartus Prime, click “start analysis & synthesis”  . You may expect warnings, but there should be no errors. 

	Create pwm_servo entity
	Open a new VHDL file and create a new entity named “pwm_servo.” Add the basic structure as the one given above for the robotic_hand entity. Remember to save this file as pwm_servo and add this file to the project. Right click “File”  > l eft click “add/remove files in project…” 
	Design the PWM_servo entity so that it generates a PWM signal with a standard frequency of 50 Hz for servo control. Recall that the period between each pulse in a servo motor is 20ms, which equates to 50 Hz. You must construct this entity so that it can create at least five distinct angles.
Pseudo Code:
----------------------------------------------------------------------------- 
--Convert 50mhz clock to 50hz
if counter < 10^6 then
counter ++;
tick <= ‘0’;
else
	Counter <= 0;
            tick <= ‘1’;
end if;
--generate PWM signal. 
if counter < duty_cycle then 
   	pwm <= ‘1’;
else
	pwm <= ‘0’;
--change angle by adjusting pulse width
if (tick = ‘1’) then 
	if angle1 then
		duty_cycle <= 50000;
            elsif angle2 then 
                        duty_cyle <= 75000;
            else 
		duty_cyle <= duty_cycle_max;
  	end if;
end if;
----------------------------------------------------------------------------- 

	Save the file. Build a new ModelSIm project and include the pwm_servo entity. Create a testbench to show the design's functionality. Please feel free to reduce the PWM servo entity's counter for wave generation and debugging purposes.
Include the wave into the report. Ensure that all essential names, values, and transitions in the report are readable. Add numerous images if this information cannot fit on a single one.
	Following testing, you may try your design on one of the robotic hand's servos for further adjustments. Before doing Analysis & Synthesis and Compilation, make sure to include the relevant information in the top-level design. See the bottom section of the lab description for detailed compilation and programming instructions.

	Create decoder entity
	Open a new VHDL file and create a new entity named “decoder.” Add the basic structure as the one given above for the robotic_hand entity. 
	Design the decoder entity to decode switch inputs (std logic vector) to LED output signals. Since there are only 8 LEDs, only three switches will be required. For instance, switch input "001" will result in output "00000001" for led, and in this case, just the rightmost led will be lit.
	Remember to save this file as decoder and add this file to the project. Right click “File”  > left click “add/remove files in project…” 
	You may try your design on de-nano10 board for further adjustments. Before doing Analysis & Synthesis and Compilation, make sure to include the relevant information in the top-level design. 
	Top level design
	Return to the "robotic_hand" entity that was initially created. Include the decoder and pwm_servo entities as components. 
	Design your top-level entity such that it can control the hand to do eight distinct gestures, and associate each of the eight LED lights with one of these gestures.
	Design and add the signal used to control the five servo motor to the entity of the decoder. Depending on your design, It could be something similar to the LED part you wrote previously. In short, the decoder will be used to determine the 8 LEDs and the 5 PWM outputs. 
	One of the eight motions should involve a continual finger movement, while the other can be static and remain in place once positioned.
	In Quartus Prime, click “start analysis & synthesis”  . Assign pins to your ports after you have successfully synthesize your design.To do so, navigate to Assignment on the menu, and then select Pin Planner under Assignment.You may not be able to add the pin successfully if the device has not been assigned to the project. If you have not yet assigned the device, click Device from the Assignment menu. Under Family, for DE-nano10, choose Cyclone V and choose 5CSEBA6U23I7. You can find the pin and other helpful information on the DE-nano10 manual. 
	Compile your project by clicking the “compilation” . Once your design has been compiled, the Quartus Prime Programming tool may be used to load it into the FPGA.  Click “programmer”  . Ensure that "USB-Blaster" is chosen next to "Hardware setup" at the top left of the programming window and selecting "USB-Blaster." Click “start” to start programming and you can see the programming progress on the top right corner. 
	When programming this project for the first time, you may only see 5CSEBA6U23 as a single device, and programming it will fail. Right-click the device and then remove the 5CSEBA6U23. Now that your device is empty.
	Click "auto-detect" and you will see that SOCVHPS has been added to the device and a window will appear allowing you to pick the device. Choose any one of them, then click the OK button. Delete the device you just picked. 
	Click "Add File" and then open the .sof file. You will see 5CSEBA6U23 with a checkmark underneath the SOCVHPS. Now you may click start to begin programming again.
 
 


