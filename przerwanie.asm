
.include "8515def.inc"
.cseg
.org $0000  
rjmp reset
.org $0001  
rjmp ext_int0
;.org $0002  
;rjmp ext_int1

reset:
ldi r16, high(ramend)
out sph, r16
ldi r16, low(ramend)
out spl, r16

ldi r21,0b00000000;wejscia- port D
OUT DDRD, R21
ldi r23,0b11111111;podwieszenie
OUT portd, R23

ldi r23,0b11111111
OUT DDRb, R23 ; wyjscia -portB

ldi R24,0b11111111 ; zgaszenie diod
out PORTB,r24

ldi r27,0b11111111

ldi r25,0b00000010
out MCUCR,r25

ldi r26,0b11000000
out GIMSK,r26

sei
koniec:

rjmp koniec

ext_int0:

rcall pprg1 


dec r27
out portb,r27

reti
;ext_int1:

;ldi R27,0b1111101
;out PORTB,r27
;reti

pprg1:
ldi r18, 32
ldi r19, 69
ldi r20, 135
porownanie:
	porownanie1:
			porownanie2:
		dec r20
		cpi  r20,0
		brne porownanie2
	ldi r20, 135
	dec r19
	cpi r19 ,0
	brne porownanie1
	ldi r19, 69
	dec r18	
cpi  r18,0
brne porownanie

ret