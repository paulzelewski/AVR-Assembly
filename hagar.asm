.include "8515def.inc"
.dseg
Bufor: .byte 40
.cseg
.org $0000
.equ komenda=$1F90
.equ dane=$1F91

rjmp reset
reset:

ldi r16, high(ramend)
out sph, r16

ldi r16, low(ramend)
out spl, r16

ldi r26, $60 
clr r27      
   
ldi r18,$0  

czysc:
st x+,r18

cpi r27,$02            
brne czysc
cpi r26,$60           
brne czysc

Ldi xh, high(bufor)
Ldi xl, low(bufor)
ldi r30,40
ldi r17, 0x41
go:
st X+, r17
inc r17
dec r30
cpi r30, 0
brne go

ldi r16, 0xc0			;w³¹czenie obs³ugi przestrzeni adresowej
out mcucr, r16


ldi YH, high (komenda)	
ldi YL, low (komenda)

ldi r16, 0x38
st Y, r16	;tryb adresowania…
rcall czas
ldi r16, 0x38
st Y, r16	;tryb adresowania…
rcall czas
ldi r16, 0x38
st Y, r16	;tryb adresowania…
rcall czas
ldi r16, 0x14
st Y, r16	;obrót...
rcall czas
ldi r16, 0x0c
st Y, r16	;wyœwietlacz on/off...
rcall czas
ldi r16, 0x06;0b00000110
st Y, r16	;przesuwanie napisu...
rcall czas

ldi r16, 0x01
st Y, r16	;czyszczenie…
rcall czas
ldi r16, 0x80
st Y, r16	;ustawienie adresu pocz¹tkowego...
rcall czas
ldi YH, high (dane)	
ldi YL, low (dane)

Ldi xh, high(bufor)
Ldi xl, low(bufor)
ldi r30, 40
wpisz:
ld r16,x+
st Y, r16
rcall czas1s
dec r30
cpi r30, 24
brne wpisz	
rcall czas
rcall czas
rcall czas
rcall czas
przesun:
ldi YH, high (komenda)	
ldi YL, low (komenda)

ldi r16,0b00011000
st Y, r16 
rcall czas1s
ld r16, x+
st Y, r16
dec r30
cpi r30,0
brne przesun

koniec:
rjmp koniec


czas:

ldi r24, 5
dalej3:

ldi r21, 100
dalej2:

ldi r20, 250
dalej:
dec r20
cpi r20,0
brne dalej

dec r21
cpi r21, 0
brne dalej2

dec r24
cpi r24, 0
brne dalej3

ret

czas1s:

ldi r24, 10
adalej3:

ldi r21, 100
adalej2:

ldi r20, 250
adalej:
dec r20
cpi r20,0
brne adalej

dec r21
cpi r21, 0
brne adalej2

dec r24
cpi r24, 0
brne adalej3

ret
