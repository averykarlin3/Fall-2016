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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;copy;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
copy
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
L27_mc
	LDR R7, R5, #-1
	LDR R3, R5, #4
	ADD R3, R7, R3
	LDR R2, R5, #3
	ADD R7, R7, R2
	LDR R7, R7, #0
	STR R7, R3, #0
L28_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #8
	CMP R7, R3
	BRn L27_mc
L26_mc
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
L31_mc
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
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	LEA R7, mL
	LDR R7, R7, #2
	STR R7, R5, #-2
	LEA R7, mL
	LDR R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #8
	CMP R7, R3
	BRnp L33_mc
	LEA R7, mL
	ADD R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, VIIIShot
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR copy
	ADD R6, R6, #2	;; free space for arguments
	JMP L34_mc
L33_mc
	LDR R7, R5, #-1
	CONST R3, #7
	CMP R7, R3
	BRnp L35_mc
	LEA R7, mL
	ADD R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, VIIShot
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR copy
	ADD R6, R6, #2	;; free space for arguments
	JMP L36_mc
L35_mc
	LDR R7, R5, #-1
	CONST R3, #6
	CMP R7, R3
	BRnp L37_mc
	LEA R7, mL
	ADD R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, VIShot
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR copy
	ADD R6, R6, #2	;; free space for arguments
	JMP L38_mc
L37_mc
	LDR R7, R5, #-1
	CONST R3, #5
	CMP R7, R3
	BRnp L39_mc
	LEA R7, mL
	ADD R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, VShot
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR copy
	ADD R6, R6, #2	;; free space for arguments
	JMP L40_mc
L39_mc
	LDR R7, R5, #-1
	CONST R3, #4
	CMP R7, R3
	BRnp L41_mc
	LEA R7, mL
	ADD R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, IVShot
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR copy
	ADD R6, R6, #2	;; free space for arguments
	JMP L42_mc
L41_mc
	LDR R7, R5, #-1
	CONST R3, #3
	CMP R7, R3
	BRnp L43_mc
	LEA R7, mL
	ADD R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, IIIShot
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR copy
	ADD R6, R6, #2	;; free space for arguments
	JMP L44_mc
L43_mc
	CONST R7, #2
	STR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRz L45_mc
	LEA R7, mL
	ADD R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, IIShot
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR copy
	ADD R6, R6, #2	;; free space for arguments
	JMP L46_mc
L45_mc
	LDR R7, R5, #-1
	CONST R3, #1
	CMP R7, R3
	BRnp L47_mc
	LEA R7, mL
	ADD R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, IShot
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR copy
	ADD R6, R6, #2	;; free space for arguments
	JMP L48_mc
L47_mc
	LEA R7, mL
	ADD R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, NoShot
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR copy
	ADD R6, R6, #2	;; free space for arguments
L48_mc
L46_mc
L44_mc
L42_mc
L40_mc
L38_mc
L36_mc
L34_mc
	LEA R7, mL
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L49_mc
	LEA R7, mL
	ADD R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, GoneCity
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR copy
	ADD R6, R6, #2	;; free space for arguments
L49_mc
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
L32_mc
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
L52_mc
	CONST R7, #10
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, cities
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L56_mc
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
	JSR copy
	ADD R6, R6, #2	;; free space for arguments
	JMP L57_mc
L56_mc
	CONST R7, #10
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, cities
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRnp L58_mc
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
	JSR copy
	ADD R6, R6, #2	;; free space for arguments
	JMP L59_mc
L58_mc
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
	JSR copy
	ADD R6, R6, #2	;; free space for arguments
L59_mc
L57_mc
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
L53_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #2
	CMP R7, R3
	BRn L52_mc
L51_mc
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
L61_mc
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRz L65_mc
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	LDR R3, R7, #1
	STR R3, R5, #-4
	LDR R3, R7, #2
	STR R3, R5, #-5
	LDR R3, R7, #3
	STR R3, R5, #-2
	LDR R7, R7, #4
	STR R7, R5, #-3
	CONST R7, #0
	HICONST R7, #124
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-5
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-4
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_line
	ADD R6, R6, #5	;; free space for arguments
L65_mc
L62_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #3
	CMP R7, R3
	BRn L61_mc
L60_mc
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
L68_mc
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRz L72_mc
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	LDR R3, R7, #1
	STR R3, R5, #-4
	LDR R3, R7, #2
	STR R3, R5, #-5
	LDR R3, R7, #3
	STR R3, R5, #-2
	LDR R7, R7, #4
	STR R7, R5, #-3
	CONST R7, #51
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-5
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-4
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_line
	ADD R6, R6, #5	;; free space for arguments
L72_mc
L69_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #1
	CMP R7, R3
	BRn L68_mc
L67_mc
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
L74_mc
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
L75_mc
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
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	JSR reset
	ADD R6, R6, #0	;; free space for arguments
	LEA R7, cursor
	CONST R3, #64
	STR R3, R7, #0
	CONST R3, #62
	STR R3, R7, #1
	LEA R7, cities
	CONST R3, #2
	STR R3, R7, #0
	CONST R3, #20
	STR R3, R7, #1
	LEA R7, cities
	ADD R7, R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, LiveCity
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR copy
	ADD R6, R6, #2	;; free space for arguments
	LEA R7, cities
	CONST R3, #2
	STR R3, R7, #10
	LEA R7, cities
	CONST R3, #100
	STR R3, R7, #11
	LEA R7, cities
	ADD R7, R7, #12
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, LiveCity
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR copy
	ADD R6, R6, #2	;; free space for arguments
	LEA R7, mL
	CONST R3, #2
	STR R3, R7, #0
	CONST R3, #60
	STR R3, R7, #2
	LEA R7, mL
	ADD R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, VIIIShot
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR copy
	ADD R6, R6, #2	;; free space for arguments
	LEA R7, mL
	CONST R3, #8
	STR R3, R7, #1
	CONST R7, #0
	STR R7, R5, #-1
L77_mc
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
L78_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #1
	CMP R7, R3
	BRn L77_mc
	CONST R7, #0
	STR R7, R5, #-1
L81_mc
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
L82_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #3
	CMP R7, R3
	BRn L81_mc
L76_mc
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
	ADD R6, R6, #-4	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-3
	CONST R7, #0
	STR R7, R5, #-3
	JMP L89_mc
L86_mc
	LDR R7, R5, #3
	LDR R3, R7, #3
	LDR R2, R7, #5
	SUB R3, R3, R2
	STR R3, R5, #-2
	LDR R3, R7, #4
	LDR R7, R7, #6
	SUB R7, R3, R7
	STR R7, R5, #-1
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR abs
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-4
	LDR R3, R5, #-2
	ADD R6, R6, #-1
	STR R3, R6, #0
	JSR abs
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	LDR R3, R5, #-4
	CMP R3, R7
	BRn L90_mc
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRnz L92_mc
	LDR R7, R5, #3
	ADD R7, R7, #4
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
L92_mc
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRzp L94_mc
	LDR R7, R5, #3
	ADD R7, R7, #4
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
L94_mc
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRnp L91_mc
	LDR R7, R5, #3
	CONST R3, #0
	STR R3, R7, #0
	JMP L91_mc
L90_mc
	LDR R7, R5, #-2
	CONST R3, #0
	CMP R7, R3
	BRnz L98_mc
	LDR R7, R5, #3
	ADD R7, R7, #3
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
L98_mc
	LDR R7, R5, #-2
	CONST R3, #0
	CMP R7, R3
	BRzp L100_mc
	LDR R7, R5, #3
	ADD R7, R7, #3
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
L100_mc
	LDR R7, R5, #-2
	CONST R3, #0
	CMP R7, R3
	BRnp L102_mc
	LDR R7, R5, #3
	CONST R3, #0
	STR R3, R7, #0
L102_mc
L91_mc
L87_mc
	LDR R7, R5, #-3
	ADD R7, R7, #1
	STR R7, R5, #-3
L89_mc
	LDR R7, R5, #-3
	CONST R3, #1
	LDR R2, R5, #4
	MUL R3, R3, R2
	CMP R7, R3
	BRn L86_mc
L85_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;missileStatus;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
missileStatus
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-7	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-2
L105_mc
	CONST R7, #0
	STR R7, R5, #-1
L109_mc
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRz L113_mc
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R3, R7, R3
	LEA R2, incoming
	ADD R3, R3, R2
	LDR R3, R3, #3
	LDR R2, R5, #-1
	MUL R7, R7, R2
	LEA R2, outgoing
	ADD R7, R7, R2
	LDR R7, R7, #3
	SUB R7, R3, R7
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR abs
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-3
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R3, R7, R3
	LEA R2, incoming
	ADD R3, R3, R2
	LDR R3, R3, #4
	LDR R2, R5, #-1
	MUL R7, R7, R2
	LEA R2, outgoing
	ADD R7, R7, R2
	LDR R7, R7, #4
	SUB R7, R3, R7
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR abs
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-4
	LDR R7, R5, #-3
	LDR R3, R5, #-4
	MUL R7, R7, R7
	MUL R3, R3, R3
	ADD R7, R7, R3
	STR R7, R5, #-5
	LDR R7, R5, #-5
	CONST R3, #100
	CMP R7, R3
	BRzp L115_mc
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
	LDR R7, R5, #3
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
L115_mc
L113_mc
L110_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #1
	CMP R7, R3
	BRn L109_mc
	CONST R7, #0
	STR R7, R5, #-1
L117_mc
	LDR R7, R5, #-1
	CONST R3, #2
	CMP R7, R3
	BRnp L121_mc
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	LDR R7, R7, #3
	LEA R3, mL
	LDR R3, R3, #2
	SUB R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR abs
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-3
	JMP L122_mc
L121_mc
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	LDR R7, R7, #3
	CONST R3, #10
	LDR R2, R5, #-1
	MUL R3, R3, R2
	LEA R2, cities
	ADD R3, R3, R2
	LDR R3, R3, #1
	SUB R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR abs
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-3
L122_mc
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	LDR R7, R7, #4
	CONST R3, #116
	SUB R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR abs
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-4
	LDR R7, R5, #-3
	LDR R3, R5, #-4
	MUL R7, R7, R7
	MUL R3, R3, R3
	ADD R7, R7, R3
	STR R7, R5, #-5
	LDR R7, R5, #-5
	CONST R3, #100
	CMP R7, R3
	BRzp L123_mc
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
	LDR R7, R5, #-1
	CONST R3, #2
	CMP R7, R3
	BRnp L125_mc
	LEA R7, mL
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRz L125_mc
	LEA R7, mL
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
	JMP L126_mc
L125_mc
	CONST R7, #10
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, cities
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRz L127_mc
	CONST R7, #10
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, cities
	ADD R7, R7, R3
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
L127_mc
L126_mc
L123_mc
L118_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #3
	CMP R7, R3
	BRn L117_mc
L106_mc
	LDR R7, R5, #-2
	ADD R7, R7, #1
	STR R7, R5, #-2
	LDR R7, R5, #-2
	CONST R3, #3
	CMP R7, R3
	BRn L105_mc
	CONST R7, #0
	STR R7, R5, #-2
L129_mc
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L133_mc
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #3
	MOD R7, R7, R3
	STR R7, R5, #-7
	LDR R7, R5, #-7
	CONST R3, #2
	CMP R7, R3
	BRnp L135_mc
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	LEA R3, mL
	LDR R3, R3, #2
	STR R3, R7, #5
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	CONST R3, #116
	STR R3, R7, #6
	JMP L136_mc
L135_mc
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	CONST R3, #10
	LDR R2, R5, #-7
	MUL R3, R3, R2
	LEA R2, cities
	ADD R3, R3, R2
	LDR R3, R3, #1
	STR R3, R7, #5
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	CONST R3, #116
	STR R3, R7, #6
L136_mc
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-6
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	LDR R3, R5, #-6
	STR R3, R7, #3
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	LDR R3, R5, #-6
	STR R3, R7, #1
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #2
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #4
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	CONST R3, #1
	STR R3, R7, #0
L133_mc
L130_mc
	LDR R7, R5, #-2
	ADD R7, R7, #1
	STR R7, R5, #-2
	LDR R7, R5, #-2
	CONST R3, #3
	CMP R7, R3
	BRn L129_mc
L104_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;multiplerCalc;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
multiplerCalc
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	CONST R7, #3
	LDR R3, R5, #3
	SLL R3, R3, #1
	CONST R2, #8
	DIV R3, R3, R2
	SUB R7, R7, R3
L137_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;main;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
main
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-5	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-2
	CONST R7, #1
	STR R7, R5, #-4
	LEA R7, L139_mc
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L140_mc
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JSR ResetGame
	ADD R6, R6, #0	;; free space for arguments
	JMP L142_mc
L141_mc
	CONST R7, #10
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_getc_timer
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-5
	LDR R7, R5, #-5
	CONST R3, #119
	CMP R7, R3
	BRnp L144_mc
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR multiplerCalc
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	LEA R3, cursor
	ADD R3, R3, #1
	LDR R2, R3, #0
	SUB R7, R2, R7
	STR R7, R3, #0
L144_mc
	LDR R7, R5, #-5
	CONST R3, #97
	CMP R7, R3
	BRnp L146_mc
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR multiplerCalc
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	LEA R3, cursor
	LDR R2, R3, #0
	SUB R7, R2, R7
	STR R7, R3, #0
L146_mc
	LDR R7, R5, #-5
	CONST R3, #115
	CMP R7, R3
	BRnp L148_mc
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR multiplerCalc
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	LEA R3, cursor
	ADD R3, R3, #1
	LDR R2, R3, #0
	ADD R7, R2, R7
	STR R7, R3, #0
L148_mc
	LDR R7, R5, #-5
	CONST R3, #100
	CMP R7, R3
	BRnp L150_mc
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR multiplerCalc
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	LEA R3, cursor
	LDR R2, R3, #0
	ADD R7, R2, R7
	STR R7, R3, #0
L150_mc
	LDR R7, R5, #-5
	CONST R3, #114
	CMP R7, R3
	BRnp L152_mc
	LEA R7, mL
	LDR R7, R7, #1
	CONST R3, #0
	CMP R7, R3
	BRz L154_mc
	CONST R7, #0
	STR R7, R5, #-1
L156_mc
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L160_mc
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	LEA R3, cursor
	LDR R3, R3, #0
	STR R3, R7, #5
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	LEA R3, cursor
	LDR R3, R3, #1
	STR R3, R7, #6
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	LEA R3, mL
	LDR R3, R3, #2
	STR R3, R7, #3
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	LEA R3, mL
	LDR R3, R3, #2
	STR R3, R7, #1
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	CONST R3, #116
	STR R3, R7, #2
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	CONST R3, #116
	STR R3, R7, #4
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	CONST R3, #1
	STR R3, R7, #0
	LEA R7, mL
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
	JMP L158_mc
L160_mc
L157_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #1
	CMP R7, R3
	BRn L156_mc
L158_mc
L154_mc
L152_mc
	ADD R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR missileStatus
	ADD R6, R6, #1	;; free space for arguments
	CONST R7, #0
	STR R7, R5, #-1
L162_mc
	LDR R7, R5, #-4
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR Move
	ADD R6, R6, #2	;; free space for arguments
L163_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #3
	CMP R7, R3
	BRn L162_mc
	CONST R7, #0
	STR R7, R5, #-1
L166_mc
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR multiplerCalc
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR Move
	ADD R6, R6, #2	;; free space for arguments
L167_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #1
	CMP R7, R3
	BRn L166_mc
	CONST R7, #0
	STR R7, R5, #-3
	STR R7, R5, #-1
L170_mc
	LDR R7, R5, #-1
	CONST R3, #2
	CMP R7, R3
	BRnp L174_mc
	LDR R7, R5, #-3
	LEA R3, mL
	LDR R3, R3, #0
	ADD R7, R7, R3
	STR R7, R5, #-3
	JMP L175_mc
L174_mc
	LDR R7, R5, #-3
	CONST R3, #10
	LDR R2, R5, #-1
	MUL R3, R3, R2
	LEA R2, cities
	ADD R3, R3, R2
	LDR R3, R3, #0
	ADD R7, R7, R3
	STR R7, R5, #-3
L175_mc
L171_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #3
	CMP R7, R3
	BRn L170_mc
	LDR R7, R5, #-2
	CONST R3, #8
	CMP R7, R3
	BRnp L176_mc
	LEA R7, L178_mc
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	CONST R7, #0
	STR R7, R5, #-2
	LDR R7, R5, #-4
	ADD R7, R7, #1
	STR R7, R5, #-4
	JSR ResetGame
	ADD R6, R6, #0	;; free space for arguments
L176_mc
	LDR R7, R5, #-3
	CONST R3, #0
	CMP R7, R3
	BRz L181_mc
	LEA R7, mL
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L179_mc
L181_mc
	LEA R7, L182_mc
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JSR ResetGame
	ADD R6, R6, #0	;; free space for arguments
L179_mc
	JSR Redraw
	ADD R6, R6, #0	;; free space for arguments
L142_mc
	JMP L141_mc
	CONST R7, #0
L138_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.DATA
cursor 		.BLKW 2
		.DATA
incoming 		.BLKW 21
		.DATA
outgoing 		.BLKW 7
		.DATA
mL 		.BLKW 11
		.DATA
cities 		.BLKW 20
		.DATA
L182_mc 		.STRINGZ "Game Over...\n"
		.DATA
L178_mc 		.STRINGZ "Next Level!\n"
		.DATA
L140_mc 		.STRINGZ "WASD for Movement, R to Shoot\n"
		.DATA
L139_mc 		.STRINGZ "Welcome to Missile Command!\n"
		.DATA
L21_mc 		.STRINGZ "\n"
		.DATA
L14_mc 		.STRINGZ "-32768"
		.DATA
L8_mc 		.STRINGZ "0"
