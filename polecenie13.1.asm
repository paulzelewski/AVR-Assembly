
.include "8515def.inc"
.cseg
.org $0000  
rjmp reset
.org $0001  
rjmp ext_int0
.org $0002  
rjmp ext_int1

reset:

ldi r20, high(ramend)
out sph, r20
ldi r20, low(ramend)
out spl, r20


ldi r20, 0b11111111;wejscie
out ddrb, r20
out portb, r20

ldi r20, 0b00000000
out ddrd, r20
ldi r20, 0b11111111
out portd, r20

ldi r20, 0b00000000;MCUCR 
out mcucr, r20

ldi r20, 0b11000000;maski
out GIMSK, r20

sei


koniec:
sbi portb, 2
sbi portb, 3
rjmp koniec


ext_int0:
cbi portb, 2
reti


ext_int1:
cbi portb, 3
reti