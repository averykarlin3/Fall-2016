.FALIGN
.CODE
gcd
STR R7 R6 #-2
STR R5 R6 #-3
ADD R6 R6 #-3
ADD R5 R6 #0
ADD R0 R5 #4
LDR R0 R0 #0
STR R0 R6 #-1
ADD R6 R6 #-1
CONST R0 x0
HICONST R0 x0
STR R0 R6 #-1
ADD R6 R6 #-1
LDR R0 R6 #0
LDR R1 R6 #1
CMP R0 R1
BRnp ZERO0
CONST R2 #1
JMP AFTERZ0
ZERO0 CONST R2 #0
AFTERZ0 STR R2 R6 #1
ADD R6 R6 #1
LDR R0 R6 #0
CONST R1 x0
ADD R6 R6 #1
CMP R0 R1
BRz NOT0
ADD R0 R5 #3
LDR R0 R0 #0
STR R0 R6 #-1
ADD R6 R6 #-1
BR ENDIF0
NOT0
ADD R0 R5 #4
LDR R0 R0 #0
STR R0 R6 #-1
ADD R6 R6 #-1
ADD R0 R5 #3
LDR R0 R0 #0
STR R0 R6 #-1
ADD R6 R6 #-1
LDR R0 R6 #0
LDR R1 R6 #1
MOD R0 R0 R1
STR R0 R6 #1
ADD R6 R6 #1
ADD R0 R5 #4
LDR R0 R0 #0
STR R0 R6 #-1
ADD R6 R6 #-1
JSR gcd
ENDIF0
CONST R0 x0
HICONST R0 x80
CMP R0 R5
BRz EMAIN
LDR R0 R6 #0
STR R0 R5 #2
LDR R7 R5 #1
ADD R6 R5 #2
LDR R5 R5 #0
JMPR R7
.FALIGN
.CODE
main
CONST R5 0x00
HICONST R5 0x80
ADD R6 R5 #0
CONST R0 xCE
HICONST R0 x1
STR R0 R6 #-1
ADD R6 R6 #-1
CONST R0 x2F
HICONST R0 x4
STR R0 R6 #-1
ADD R6 R6 #-1
JSR gcd
JSR printnum
JSR endl
CONST R0 x0
HICONST R0 x80
CMP R0 R5
BRz EMAIN
LDR R0 R6 #0
STR R0 R5 #2
LDR R7 R5 #1
ADD R6 R5 #2
LDR R5 R5 #0
JMPR R7
EMAIN TRAP x25
