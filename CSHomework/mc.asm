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
	CONST R7, #0
	HICONST R7, #51
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
	CONST R3, #120
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
	BRn L92_mc
	LDR R7, R5, #3
	ADD R7, R7, #4
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
	JMP L91_mc
L92_mc
	LDR R7, R5, #3
	ADD R7, R7, #4
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
	JMP L91_mc
L90_mc
	LDR R7, R5, #-2
	CONST R3, #0
	CMP R7, R3
	BRn L94_mc
	LDR R7, R5, #3
	ADD R7, R7, #3
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
	JMP L95_mc
L94_mc
	LDR R7, R5, #3
	ADD R7, R7, #3
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
L95_mc
L91_mc
L87_mc
	LDR R7, R5, #-3
	ADD R7, R7, #1
	STR R7, R5, #-3
	LDR R7, R5, #-3
	CONST R3, #1
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;main;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
main
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-10	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-6
	LEA R7, L97_mc
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L98_mc
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JSR ResetGame
	ADD R6, R6, #0	;; free space for arguments
	JMP L100_mc
L99_mc
	CONST R7, #10
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_getc_timer
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-10
	LDR R7, R5, #-10
	CONST R3, #119
	CMP R7, R3
	BRnp L102_mc
	LEA R7, cursor
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
L102_mc
	LDR R7, R5, #-10
	CONST R3, #97
	CMP R7, R3
	BRnp L104_mc
	LEA R7, cursor
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
L104_mc
	LDR R7, R5, #-10
	CONST R3, #115
	CMP R7, R3
	BRnp L106_mc
	LEA R7, cursor
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
L106_mc
	LDR R7, R5, #-10
	CONST R3, #100
	CMP R7, R3
	BRnp L108_mc
	LEA R7, cursor
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
L108_mc
	LDR R7, R5, #-10
	CONST R3, #114
	CMP R7, R3
	BRnp L110_mc
	LEA R7, mL
	LDR R7, R7, #1
	CONST R3, #0
	CMP R7, R3
	BRnp L112_mc
	JMP L101_mc
L112_mc
	CONST R7, #0
	STR R7, R5, #-2
L114_mc
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L118_mc
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	LEA R3, cursor
	LDR R3, R3, #0
	STR R3, R7, #5
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	LEA R3, cursor
	LDR R3, R3, #1
	STR R3, R7, #6
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	LEA R3, mL
	LDR R3, R3, #2
	STR R3, R7, #3
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	LEA R3, mL
	LDR R3, R3, #2
	STR R3, R7, #1
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	CONST R3, #116
	STR R3, R7, #2
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	CONST R3, #116
	STR R3, R7, #4
	CONST R7, #7
	LDR R3, R5, #-2
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
	JMP L116_mc
L118_mc
L115_mc
	LDR R7, R5, #-2
	ADD R7, R7, #1
	STR R7, R5, #-2
	LDR R7, R5, #-2
	CONST R3, #1
	CMP R7, R3
	BRn L114_mc
L116_mc
L110_mc
	CONST R7, #0
	STR R7, R5, #-2
L120_mc
	CONST R7, #0
	STR R7, R5, #-1
L124_mc
	CONST R7, #7
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRz L128_mc
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
	CONST R3, #250
	CMP R7, R3
	BRzp L130_mc
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
	LDR R7, R5, #-6
	ADD R7, R7, #1
	STR R7, R5, #-6
L130_mc
L128_mc
L125_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #1
	CMP R7, R3
	BRn L124_mc
	CONST R7, #0
	STR R7, R5, #-1
L132_mc
	LDR R7, R5, #-1
	CONST R3, #2
	CMP R7, R3
	BRnp L136_mc
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
	JMP L137_mc
L136_mc
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
L137_mc
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
	CONST R3, #250
	CMP R7, R3
	BRzp L138_mc
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
	BRnp L140_mc
	LEA R7, mL
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
	JMP L141_mc
L140_mc
	CONST R7, #10
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, cities
	ADD R7, R7, R3
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
L141_mc
L138_mc
L133_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #3
	CMP R7, R3
	BRn L132_mc
L121_mc
	LDR R7, R5, #-2
	ADD R7, R7, #1
	STR R7, R5, #-2
	LDR R7, R5, #-2
	CONST R3, #3
	CMP R7, R3
	BRn L120_mc
	CONST R7, #0
	STR R7, R5, #-2
L142_mc
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L146_mc
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #3
	MOD R7, R7, R3
	STR R7, R5, #-8
	LDR R7, R5, #-8
	CONST R3, #2
	CMP R7, R3
	BRnp L148_mc
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
	JMP L149_mc
L148_mc
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	CONST R3, #10
	LDR R2, R5, #-8
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
L149_mc
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-7
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	LDR R3, R5, #-7
	STR R3, R7, #3
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	LDR R3, R5, #-7
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
L146_mc
L143_mc
	LDR R7, R5, #-2
	ADD R7, R7, #1
	STR R7, R5, #-2
	LDR R7, R5, #-2
	CONST R3, #3
	CMP R7, R3
	BRn L142_mc
	CONST R7, #0
	STR R7, R5, #-2
L150_mc
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, incoming
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR Move
	ADD R6, R6, #1	;; free space for arguments
L151_mc
	LDR R7, R5, #-2
	ADD R7, R7, #1
	STR R7, R5, #-2
	LDR R7, R5, #-2
	CONST R3, #3
	CMP R7, R3
	BRn L150_mc
	CONST R7, #0
	STR R7, R5, #-2
L154_mc
	CONST R7, #7
	LDR R3, R5, #-2
	MUL R7, R7, R3
	LEA R3, outgoing
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR Move
	ADD R6, R6, #1	;; free space for arguments
L155_mc
	LDR R7, R5, #-2
	ADD R7, R7, #1
	STR R7, R5, #-2
	LDR R7, R5, #-2
	CONST R3, #1
	CMP R7, R3
	BRn L154_mc
	CONST R7, #0
	STR R7, R5, #-9
	STR R7, R5, #-2
L158_mc
	LDR R7, R5, #-2
	CONST R3, #2
	CMP R7, R3
	BRnp L162_mc
	LDR R7, R5, #-9
	LEA R3, mL
	LDR R3, R3, #0
	ADD R7, R7, R3
	STR R7, R5, #-9
	JMP L163_mc
L162_mc
	LDR R7, R5, #-9
	CONST R3, #10
	LDR R2, R5, #-2
	MUL R3, R3, R2
	LEA R2, cities
	ADD R3, R3, R2
	LDR R3, R3, #0
	ADD R7, R7, R3
	STR R7, R5, #-9
L163_mc
L159_mc
	LDR R7, R5, #-2
	ADD R7, R7, #1
	STR R7, R5, #-2
	LDR R7, R5, #-2
	CONST R3, #3
	CMP R7, R3
	BRn L158_mc
	LDR R7, R5, #-6
	CONST R3, #8
	CMP R7, R3
	BRnp L164_mc
	CONST R7, #0
	STR R7, R5, #-6
	JSR ResetGame
	ADD R6, R6, #0	;; free space for arguments
	JMP L165_mc
L164_mc
	LDR R7, R5, #-9
	CONST R3, #0
	CMP R7, R3
	BRnp L166_mc
	LEA R7, L168_mc
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L101_mc
L166_mc
	JSR Redraw
	ADD R6, R6, #0	;; free space for arguments
L165_mc
L100_mc
	JMP L99_mc
L101_mc
	CONST R7, #0
L96_mc
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
L168_mc 		.STRINGZ "Game Over...\n"
		.DATA
L98_mc 		.STRINGZ "WASD for Movement, R to Shoot\n"
		.DATA
L97_mc 		.STRINGZ "Welcome to Missile Command!\n"
		.DATA
L21_mc 		.STRINGZ "\n"
		.DATA
L14_mc 		.STRINGZ "-32768"
		.DATA
L8_mc 		.STRINGZ "0"
