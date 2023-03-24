cseg at 0x0000
jmp initialize


CSEG at 0x0300
score: DB 00000011b, 10011111b, 01000101b, 00001101b , 10011001b, 00101001b, 00100001b 


initialize:
MOV DPTR, #score
MOV A, #0x03
MOV R1,#3d
MOVC A, @A+DPTR
MOV P3,A
CLR A
JMP start

start:
MOV P1,#11111101b ; P1 00000010 (Lichter)
MOV P2,#11111111b ; P2 00000000 (Schalter)
JNB P2.1,checkLights
JMP initialize

checkLights:
MOV A,P1
CJNE A,#11111110b,prüfeGewonnen
jmp looseScreen

rotateRight:
RR A
MOV P1,A
RL A
JB P2.1,checkLights
JMP rotateleft

rotateLeft:
RL A
MOV P1,A
RR A
JB P2.1,checkLights
JMP rotateRight

switchLights:
jNB P2.1,rotateright
JMP switchlights

prüfeGewonnen:
CJNE A,#01111111b,switchLights
JMP winScreen

winScreen:
MOV A,P1
RR A
MOV P1,A
JNB P2.1,addLife
JMP winScreen

looseScreen:
MOV P1,#00000000b
MOV P1,#11111111b
JNB P2.1,subtractLife
JMP looseScreen

addLife:
INC R1
JMP checkchangeScore


subtractLife:
DEC R1
JMP checkChangeScore

checkChangeScore:
CJNE R1, #6d, checkzero
JMP ende

checkzero:
CJNE R1, #0d, changeScore
JMP ende

changeScore:
;checken ob 0 oder 6 ausgewählt ist und dann beenden
MOV DPTR, #score
MOV A,R1
MOVC A, @A+DPTR
MOV P3, A
CLR A
JMP start

ende:
MOV DPTR, #score
MOV A,R1
MOVC A, @A+DPTR
MOV P3, A
MOV P1, #00000000b

end
