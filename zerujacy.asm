.include "8515def.inc"
.dseg
.cseg
.org $0000



rjmp reset
reset:

ldi r16, high(ramend)
out sph, r16

ldi r16, low(ramend)
out spl, r16

ldi r26, $60 
clr r27      
   
ldi r18,$0  

etykieta:
st x+,r18

cpi r27,$02            
brne etykieta
cpi r26,$60           
brne etykieta

koniec:
rjmp koniec
