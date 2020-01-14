.include "8515def.inc"
.dseg
Bufor: .byte 40
.cseg
.equ komenda=$1F90
.equ dane=$1F91

.org $0000
 rjmp reset

.org $0004 
rjmp tim1_compa


reset:
napis: .db "zakonczono"

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
ldi r25,40
ldi r17, 0x41
go:
st X+, r17
inc r17
dec r25
cpi r25, 0
brne go

ldi r16, 0b00000101
out tccr1b, r16

ldi r16, 0b01000000
out timsk, r16

ldi r16, High(40000)
out ocr1ah, r16
ldi r16, Low(40000)
out ocr1al, r16


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


;Ldi xh, high(bufor)
;Ldi xl, low(bufor)
;ldi r25, 40
;wpisz:
;ld r16,x+
;st Y, r16
;rcall czas1s
;dec r25
;cpi r25, 0
;brne wpisz	
;rcall czas
;rcall czas
;rcall czas
;rcall czas
;przesun:
;ldi YH, high (komenda)	
;ldi YL, low (komenda)
;przesun:
;ldi r16,0b00011000
;st Y, r16 
;rcall czas1s
;ld r16, x+
;st Y, r16
;dec r30
;cpi r30,0
;brne przesun
sei
koniec:
rjmp koniec


tim1_compa:
ldi YH, high (komenda)	
ldi YL, low (komenda)

ldi r16, 0x01
st Y, r16	;czyszczenie…
rcall czas

ldi ZH, high(napis*2)  	;ustala adres do etykiety napis 
ldi ZL, low(napis*2)


ldi r17, 10 			;licznik obejœæ pêtli
ldi YH, high(dane) 
ldi YL, low(dane)

petla:
lpm   				;pobierz znak spod adresu z i umieœæ go w rejestrze r0
mov r16, r0  		;	skopiuj znak do rejestru r16
st Y, r16  		;	wyœwietl znak
rcall czas		;	wywo³aj podprogram opóŸniaj¹cy
adiw ZL, 1 		;	inkrementuj adres pobierania znaków
dec r17  		;	dekrementuj licznik
brne petla
reti
;________________

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
;___________________
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
