.CODE
.FALIGN
main
	;; prologue
	STR R7, R6, #-2
	STR R5, R6, #-3
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	ADD R6, R6, #-1
	CONST R0, #3
	HICONST R0, #0
	STR R0, R6, #0
	ADD R6, R6, #-1
	CONST R0, #5
	HICONST R0, #0
	STR R0, R6, #0
	LDR R0, R6, #0
	LDR R1, R6, #1
	CMP R0, R1
	BRp testssimple2_COMP_GOOD_0
	CONST R0, #0
	JMP testssimple2_COMP_END_0
testssimple2_COMP_GOOD_0
	CONST R0, #1
testssimple2_COMP_END_0
	ADD R6, R6, #1
	STR R0, R6, #0
	LEA R7 printnum
	JSRR R7
	LEA R7 endl
	JSRR R7
	ADD R6, R6, #-1
	CONST R0, #180
	HICONST R0, #0
	STR R0, R6, #0
	ADD R6, R6, #-1
	CONST R0, #190
	HICONST R0, #252
	STR R0, R6, #0
	LDR R0, R6, #0
	AND R1, R0, #15
	SRL R0, R0, #4
	AND R0, R0, #15
	SLL R0, R0, #4
	OR R0, R0, R1
	STR R0, R6, #0
	LDR R0, R6, #0
	LDR R1, R6, #1
	CMP R0, R1
	BRn testssimple2_COMP_GOOD_1
	CONST R0, #0
	JMP testssimple2_COMP_END_1
testssimple2_COMP_GOOD_1
	CONST R0, #1
testssimple2_COMP_END_1
	ADD R6, R6, #1
	STR R0, R6, #0
	LEA R7 printnum
	JSRR R7
	LEA R7 endl
	JSRR R7
	;; function epilogue
	LDR R0, R6, #0
	STR R0, R5, #2
	ADD R6, R5, #0
	ADD R6, R6, #2
	LDR R7, R5, #1
	LDR R5, R5, #0
	RET
