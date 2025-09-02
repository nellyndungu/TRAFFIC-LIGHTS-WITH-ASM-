.include "m328pdef.inc"

.cseg
.org 0x0000

start:
	ldi r16, (1<<PORTB0) |(1<<PORTB1)|(1<<PORTB2)
	out DDRB, r16
main:
	call LED1_ON
	call delay
	call LED2_ON
	call delay
	call LED3_ON
	call delay
	rjmp main

LED1_ON:
	cbi PORTB, PORTB1
	cbi PORTB, PORTB2
	sbi PORTB, PORTB0
	ret
LED2_ON:
	cbi PORTB, PORTB0
	cbi PORTB, PORTB2
	sbi PORTB, PORTB1
	ret
LED3_ON:
	cbi PORTB, PORTB0
	cbi PORTB, PORTB1
	sbi PORTB, PORTB2
	ret
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