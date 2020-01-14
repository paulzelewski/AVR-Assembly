.include "8515def.inc"
.dseg 
Bufor:		.byte 10 ;rezerwacja bufotu 10 bajtow w RAMie

.cseg
.org $0000  
rjmp reset

reset:
ldi r16, high(ramend)
out sph, r16
ldi r16, low(ramend)
out spl, r16

Ldi xh, high(bufor)
Ldi xl, low(bufor)

ldi r17, 9
go:
st X+, r17
dec r17
cpi r17, 0
brne go

koniec:
rjmp koniec