# RoboticHand
In this project I helped design a system for controlling the five servos on each finger of the robotic hand in order to produce eight various hand gestures and assign an LED to each gesture using three switches on DE-nano10.


# Background Information:
PWM, which stands for Pulse Width Modulation, is a method of controlling devices by varying the pulse width. Servo motors are controlled by pulse-width modulation (PWM) signals. Pulse width, or more simply, the duration of the signal's high portion, determines the angle of the servo motor. The interval between each pulse in a servo motor is 20ms (20,000 us). Using the servo specification supplied in the next part as an illustration, a PWM pulse range of 500-2500 us indicates that if the signal is set high for 0.5ms out of a total of 20ms, the servo will move completely to 0°. If the signal is set high for 2.5ms out of a total of 20ms, the servo will turn to 180°.
 
                       
                                                
						
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


 


