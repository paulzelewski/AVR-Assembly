
.include "8515def.inc"
.dseg
Bufor1:		.byte 40

.cseg
.org $0000
.equ komenda=$1F90
.equ dane=$1F91

.org $0000  
rjmp reset
.org $0001  
rjmp ext_int0
.org $0002  
rjmp ext_int1



reset:
ldi r16, high(ramend)
out sph, r16
ldi r16, low(ramend)
out spl, r16


ldi r21,0b00000000;wejscia- port D
OUT DDRD, R21
ldi r23,0b11111111;podwieszenie
OUT portd, R23

ldi YH, high (komenda)	
ldi YL, low (komenda)

ldi r16, 0xc0 			;w³¹czenie obs³ugi przestrzeni adresowej
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
ldi r16, 0x06
st Y, r16	;przesuwanie napisu...
rcall czas
ldi r16, 0x01
st Y, r16	;czyszczenie…
rcall czas
ldi r26, 0x80
st Y, r16	;ustawienie adresu pocz¹tkowego...
rcall czas





EEPROM_read:
sbic EECR, EEWE
rjmp EEPROM_read

ldi r18, 0
ldi r17, 100
out EEARH, r18
out EEARL, r17

sbi EECR, EERE
in r16, EEDR


ldi YH, high (dane)	
ldi YL, low (dane)

;ldi r16, 0x41  	;0x41 jest kodem ASCII litery A
st Y, r16	
rcall czas 



;ldi r23,0b11111111
;OUT DDRb, R23 ; wyjscia -portB

;ldi R24,0b11111111; zgaszenie diod w porcie B
;out PORTB,r24

in r25, mcucr
ori r25, 0b00001010
out MCUCR,r25

ldi r25,0b11000000
out GIMSK,r25










sei
koniec:

rjmp koniec
;__________________________________________________________________________________________

czas:
ldi r18, 5
ldi r19, 10
ldi r20, 10
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


ext_int0:
 

EEPROM_write:
sbic EECR, EEWE
rjmp EEPROM_write

ldi r18, 0
ldi r17, 100
out EEARH, r18
out EEARL, r17

ldi r18, 0x41
out EEDR, r18

sbi EECR, EEMWE
sbi EECR, EEWE

rjmp czas

reti
;___________________________________________________________________________________________
ext_int1:



EEPROM_write1:
sbic EECR, EEWE
rjmp EEPROM_write

ldi r18, 0
ldi r17, 100
out EEARH, r18
out EEARL, r17

ldi r18, 0x42
out EEDR, r18

sbi EECR, EEMWE
sbi EECR, EEWE
rjmp czas

reti
;__________________________________________________________________________________________