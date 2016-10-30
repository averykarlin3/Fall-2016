		.DATA
cursorImage 		.FILL #0
		.FILL #0
		.FILL #24
		.FILL #60
		.FILL #60
		.FILL #24
		.FILL #0
		.FILL #0
		.DATA
VIIIShot 		.FILL #255
		.FILL #255
		.FILL #255
		.FILL #255
		.FILL #255
		.FILL #255
		.FILL #255
		.FILL #255
		.DATA
VIIShot 		.FILL #231
		.FILL #255
		.FILL #255
		.FILL #255
		.FILL #255
		.FILL #255
		.FILL #255
		.FILL #255
		.DATA
VIShot 		.FILL #231
		.FILL #231
		.FILL #255
		.FILL #255
		.FILL #255
		.FILL #255
		.FILL #255
		.FILL #255
		.DATA
VShot 		.FILL #231
		.FILL #231
		.FILL #231
		.FILL #255
		.FILL #255
		.FILL #255
		.FILL #255
		.FILL #255
		.DATA
IVShot 		.FILL #231
		.FILL #231
		.FILL #231
		.FILL #231
		.FILL #255
		.FILL #255
		.FILL #255
		.FILL #255
		.DATA
IIIShot 		.FILL #231
		.FILL #231
		.FILL #231
		.FILL #231
		.FILL #231
		.FILL #255
		.FILL #255
		.FILL #255
		.DATA
IIShot 		.FILL #231
		.FILL #231
		.FILL #231
		.FILL #231
		.FILL #231
		.FILL #231
		.FILL #255
		.FILL #255
		.DATA
IShot 		.FILL #231
		.FILL #231
		.FILL #231
		.FILL #231
		.FILL #231
		.FILL #231
		.FILL #231
		.FILL #255
		.DATA
NoShot 		.FILL #231
		.FILL #231
		.FILL #231
		.FILL #231
		.FILL #231
		.FILL #231
		.FILL #231
		.FILL #231
		.DATA
LiveCity 		.FILL #16
		.FILL #56
		.FILL #56
		.FILL #60
		.FILL #124
		.FILL #124
		.FILL #126
		.FILL #255
		.DATA
DeadCity 		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #126
		.FILL #255
		.DATA
GoneCity 		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;printnum;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
printnum
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-13	;; allocate stack space for local variables
	;; function body
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRnp L6_mc
	LEA R7, L8_mc
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L5_mc
L6_mc
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRzp L10_mc
	LDR R7, R5, #3
	NOT R7,R7
	ADD R7,R7,#1
	STR R7, R5, #-13
	JMP L11_mc
L10_mc
	LDR R7, R5, #3
	STR R7, R5, #-13
L11_mc
	LDR R7, R5, #-13
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRzp L12_mc
	LEA R7, L14_mc
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L5_mc
L12_mc
	ADD R7, R5, #-12
	ADD R7, R7, #10
	STR R7, R5, #-2
	LDR R7, R5, #-2
	ADD R7, R7, #-1
	STR R7, R5, #-2
	CONST R3, #0
	STR R3, R7, #0
	JMP L16_mc
L15_mc
	LDR R7, R5, #-2
	ADD R7, R7, #-1
	STR R7, R5, #-2
	LDR R3, R5, #-1
	CONST R2, #10
	MOD R3, R3, R2
	CONST R2, #48
	ADD R3, R3, R2
	STR R3, R7, #0
	LDR R7, R5, #-1
	CONST R3, #10
	DIV R7, R7, R3
	STR R7, R5, #-1
L16_mc
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRnp L15_mc
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRzp L18_mc
	LDR R7, R5, #-2
	ADD R7, R7, #-1
	STR R7, R5, #-2
	CONST R3, #45
	STR R3, R7, #0
L18_mc
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L5_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;endl;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
endl
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, L21_mc
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L20_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;abs;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
abs
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRzp L23_mc
	LDR R7, R5, #3
	NOT R7,R7
	ADD R7,R7,#1
	JMP L22_mc
L23_mc
	LDR R7, R5, #3
L22_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;rand16;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
rand16
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #127
	AND R7, R7, R3
L25_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;DrawCursor;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
DrawCursor
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	LEA R7, cursor
	LDR R7, R7, #0
	STR R7, R5, #-1
	LEA R7, cursor
	LDR R7, R7, #1
	STR R7, R5, #-2
	LEA R7, cursorImage
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #255
	HICONST R7, #255
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L26_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;DrawMissileLauncher;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
DrawMissileLauncher
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-3	;; allocate stack space for local variables
	;; function body
	LEA R7, mL
	LDR R7, R7, #2
	STR R7, R5, #-2
	LEA R7, mL
	LDR R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	STR R7, R5, #-3
	CONST R3, #1
	CMP R7, R3
	BRn L28_mc
	CONST R7, #8
	LDR R3, R5, #-3
	CMP R3, R7
	BRp L28_mc
	LEA R7, L38_mc
	ADD R7, R7, #-1
	LDR R3, R5, #-3
	ADD R7, R3, R7
	LDR R7, R7, #0
	LDR R7, R7, #0
	JMPR R7 ;unconditional
		.DATA
L38_mc 		.FILL L37_mc
		.FILL L36_mc
		.FILL L35_mc
		.FILL L34_mc
		.FILL L33_mc
		.FILL L32_mc
		.FILL L31_mc
		.FILL L30_mc
L30_mc
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, mL
	ADD R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, VIIIShot
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR memcpy
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #3	;; free space for arguments
	JMP L29_mc
L31_mc
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, mL
	ADD R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, VIIShot
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR memcpy
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #3	;; free space for arguments
	JMP L29_mc
L32_mc
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, mL
	ADD R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, VIShot
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR memcpy
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #3	;; free space for arguments
	JMP L29_mc
L33_mc
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, mL
	ADD R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, VShot
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR memcpy
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #3	;; free space for arguments
	JMP L29_mc
L34_mc
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, mL
	ADD R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, IVShot
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR memcpy
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #3	;; free space for arguments
	JMP L29_mc
L35_mc
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, mL
	ADD R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, IIIShot
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR memcpy
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #3	;; free space for arguments
	JMP L29_mc
L36_mc
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, mL
	ADD R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, IIShot
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR memcpy
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #3	;; free space for arguments
	JMP L29_mc
L37_mc
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, mL
	ADD R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, IShot
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR memcpy
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #3	;; free space for arguments
	JMP L29_mc
L28_mc
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, mL
	ADD R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, NoShot
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR memcpy
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #3	;; free space for arguments
L29_mc
	LEA R7, mL
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L39_mc
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, mL
	ADD R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, GoneCity
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR memcpy
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #3	;; free space for arguments
L39_mc
	LEA R7, mL
	ADD R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #255
	HICONST R7, #255
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #116
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #60
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L27_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;DrawCities;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
DrawCities
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
	JMP L45_mc
L42_mc
	CONST R7, #10
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, cities
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L46_mc
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #10
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, cities
	ADD R7, R7, R3
	ADD R7, R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, GoneCity
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR memcpy
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #3	;; free space for arguments
	JMP L47_mc
L46_mc
	CONST R7, #10
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, cities
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRnp L48_mc
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #10
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, cities
	ADD R7, R7, R3
	ADD R7, R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, DeadCity
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR memcpy
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #3	;; free space for arguments
	JMP L49_mc
L48_mc
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #10
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, cities
	ADD R7, R7, R3
	ADD R7, R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, LiveCity
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR memcpy
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #3	;; free space for arguments
L49_mc
L47_mc
	CONST R7, #10
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, cities
	ADD R7, R7, R3
	LDR R3, R7, #1
	STR R3, R5, #-2
	ADD R7, R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #255
	HICONST R7, #255
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #116
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L43_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
L45_mc
	LDR R7, R5, #-1
	CONST R3, #20
	CMPU R7, R3
	BRn L42_mc
L41_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;DrawIncoming;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
DrawIncoming
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-5	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
L51_mc
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	LDR R7, R7, #1
	STR R7, R5, #-2
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	LDR R7, R7, #2
	STR R7, R5, #-3
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	LDR R7, R7, #3
	STR R7, R5, #-4
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	LDR R7, R7, #4
	STR R7, R5, #-5
	CONST R7, #0
	HICONST R7, #124
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-5
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-4
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_line
	ADD R6, R6, #5	;; free space for arguments
L52_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #3
	CMP R7, R3
	BRn L51_mc
L50_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;DrawOutgoing;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
DrawOutgoing
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-5	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
L56_mc
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	LDR R7, R7, #1
	STR R7, R5, #-2
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	LDR R7, R7, #2
	STR R7, R5, #-3
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	LDR R7, R7, #3
	STR R7, R5, #-4
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	LDR R7, R7, #4
	STR R7, R5, #-5
	CONST R7, #51
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-5
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-4
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_line
	ADD R6, R6, #5	;; free space for arguments
L57_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #1
	CMP R7, R3
	BRn L56_mc
L55_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;Redraw;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
Redraw
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	JSR lc4_reset_vmem
	ADD R6, R6, #0	;; free space for arguments
	JSR DrawCursor
	ADD R6, R6, #0	;; free space for arguments
	JSR DrawMissileLauncher
	ADD R6, R6, #0	;; free space for arguments
	JSR DrawCities
	ADD R6, R6, #0	;; free space for arguments
	JSR DrawOutgoing
	ADD R6, R6, #0	;; free space for arguments
	JSR DrawIncoming
	ADD R6, R6, #0	;; free space for arguments
	JSR lc4_blt_vmem
	ADD R6, R6, #0	;; free space for arguments
L60_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;reset;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
reset
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	JSR lc4_reset_vmem
	ADD R6, R6, #0	;; free space for arguments
	JSR lc4_blt_vmem
	ADD R6, R6, #0	;; free space for arguments
L61_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;ResetGame;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
ResetGame
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;Move;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
Move
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

