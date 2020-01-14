.include "8515def.inc"
.cseg
.org $0000  
rjmp reset
.org $0007  
rjmp tim0_ovf
;.org $0002  
;rjmp ext_int1

reset:
ldi r16, high(ramend)
out sph, r16
ldi r16, low(ramend)
out spl, r16

ldi r21,0b00000000
OUT ddrd, R21
ldi r23,0b11111111
OUT portd, R23

ldi r23,0b11111111
OUT ddrb, R23 

ldi R24,0b11111111 
out portb,r24

ldi r27,0b11111111

ldi r20, 0b00000001
out tccr0, r20

ldi r20, 0b00000010
out timsk, r20
;ldi r25,0b00000010
;out mcucr,r25

;ldi r26,0b11000000
;out gimsk,r26


sei
koniec:

rjmp koniec

tim0_ovf:

rcall pprg1 


dec r27
out portb,r27

reti


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