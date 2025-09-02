This AVR assembly program runs on an ATmega328P and controls three LEDs connected to PB0, PB1, and PB2. At startup, it configures the pins as outputs.
Then it runs an infinite loop where:
- LED1 (PB0) turns ON → others OFF.
- Waits for a delay.
- LED2 (PB1) turns ON → others OFF.
- Waits again.
- LED3 (PB2) turns ON → others OFF.
- Waits again.

This sequence repeats continuously.
In short, the program makes three LEDs blink one after another in a loop, like a simple LED chaser or traffic light simulation.
## Code explanation
```asm
.include "m328pdef.inc"
```
Includes the device definition file for the ATmega328P, which defines register names and constants.
```asm
.cseg
.org 0x0000
```
- .cseg → Begin code segment (program memory).
- .org 0x0000 → Start writing code at program memory address 0x0000 (reset vector)
```asm
start:
    ldi r16, (1<<PORTB0) |(1<<PORTB1)|(1<<PORTB2)
	out DDRB, r16
```
- Loads r16 with a value that sets PORTB0, PORTB1, and PORTB2 as outputs.
- Writes this value to DDRB (Data Direction Register for Port B).
- These 3 pins will be connected to LEDs.
```asm
main:
	call LED1_ON
	call LED2_ON
	call delay
	call LED3_ON
	call delay
	rjmp main
```
- Infinite loop:
    - Turn LED1 ON.
    - Wait (delay).
    - Turn LED2 ON.
    - Wait.
    - Turn LED3 ON.
    - Wait.
- Then repeat forever (rjmp main).
### LED subroutine
```asm
LED1_ON:
	cbi PORTB, PORTB1   ; Clear PB1 (turn off LED2)
	cbi PORTB, PORTB2   ; Clear PB2 (turn off LED3)
	sbi PORTB, PORTB0   ; Set PB0 (turn on LED1)
	ret
```
Turns ON LED1 at PB0 and ensures PB1 and PB2 are OFF.
```asm
LED2_ON:
	cbi PORTB, PORTB0
	cbi PORTB, PORTB2
	sbi PORTB, PORTB1
	ret
```
Turns ON LED2 at PB1 and ensures PB0 and PB2 are OFF.
```asm
LED3_ON:
	cbi PORTB, PORTB0
	cbi PORTB, PORTB1
	sbi PORTB, PORTB2
	ret
```
Turns ON LED3 at PB2 and ensures PB0 and PB1 are OFF.
### Delay subroutine
```asm
delay:
	ldi r17, 100
loop1:
	ldi r18, 50
loop2:
	ldi r19, 10
loop3:
	dec r19
	brne loop3
	dec r18
	brne loop2
	dec r17
	brne loop1
	ret
```
Creates a nested loop delay:
- r19 counts down from 10.
- r18 counts down from 50.
- r17 counts down from 100.

Together, this produces a noticeable pause between LED transitions.
