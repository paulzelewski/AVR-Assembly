
.include "8515def.inc"
.dseg
bufor: .byte 40
bufor1: .byte 40
bufor2: .byte 40
bufor3: .byte 40
bufor4: .byte 40

.cseg

.org $0000  
rjmp reset
  

reset:
ldi r16, high(ramend)
out sph, r16
ldi r16, low(ramend)
out spl, r16

Ldi xh, high(bufor3)
Ldi xl, low(bufor3)

Ldi yh, high(bufor4)
Ldi yl, low(bufor4)
ldi r20, 5
ldi r21,40

go2:
st Y+,r20
dec r21
cpi r21,0
brne go2

Ldi xh, high(bufor3)
Ldi xl, low(bufor3)

Ldi yh, high(bufor4)
Ldi yl, low(bufor4)

ldi r21, 40
go:
ld r20, y+		
st X+, r20
dec r21
cpi r21,0
brne go


koniec:

rjmp koniec

