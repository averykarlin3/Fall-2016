.CODE
.FALIGN
fact
	;; prologue
	STR R7, R6, #-2
	STR R5, R6, #-3
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LDR R0, R5, #3
	ADD R6, R6, #-1
	STR R0, R6, #0
	LDR R0, R6, #0
	ADD R6, R6, #-1
	STR R0, R6, #0
	ADD R6, R6, #-1
	CONST R0, #1
	HICONST R0, #0
	STR R0, R6, #0
	LDR R0, R6, #0
	LDR R1, R6, #1
	CMP R0, R1
	BRzp testsfact_COMP_GOOD_0
	CONST R0, #0
	JMP testsfact_COMP_END_0
testsfact_COMP_GOOD_0
	CONST R0, #1
testsfact_COMP_END_0
	ADD R6, R6, #1
	STR R0, R6, #0
	ADD R6, R6, #1
	LDR R0, R6, #-1
testsfact_IF_0
	BRz testsfact_ELSE_0
	ADD R6, R6, #-1
	CONST R0, #1
	HICONST R0, #0
	STR R0, R6, #0
	JMP testsfact_ENDIF_0
testsfact_ELSE_0
	LDR R0, R6, #0
	ADD R6, R6, #-1
	STR R0, R6, #0
	ADD R6, R6, #-1
	CONST R0, #1
	HICONST R0, #0
	STR R0, R6, #0
	LDR R0, R6, #0
	LDR R1, R6, #1
	STR R1, R6, #0
	STR R0, R6, #1
	LDR R0, R6, #0
	LDR R1, R6, #1
	SUB R0, R0, R1
	ADD R6, R6, #1
	STR R0, R6, #0
	LEA R7 fact
	JSRR R7
	LDR R0, R6, #0
	LDR R1, R6, #1
	STR R1, R6, #0
	STR R0, R6, #1
	ADD R6, R6, #1
	LDR R0, R6, #0
	LDR R1, R6, #1
	MUL R0, R0, R1
	ADD R6, R6, #1
	STR R0, R6, #0
testsfact_ENDIF_0
	;; function epilogue
	LDR R0, R6, #0
	STR R0, R5, #2
	ADD R6, R5, #0
	ADD R6, R6, #2
	LDR R7, R5, #1
	LDR R5, R5, #0
	RET
.FALIGN
main
	;; prologue
	STR R7, R6, #-2
	STR R5, R6, #-3
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	ADD R6, R6, #-1
	CONST R0, #4
	HICONST R0, #0
	STR R0, R6, #0
	LEA R7 fact
	JSRR R7
	LEA R7 printnum
	JSRR R7
	LEA R7 endl
	JSRR R7
	ADD R6, R6, #-1
	CONST R0, #5
	HICONST R0, #0
	STR R0, R6, #0
	LEA R7 fact
	JSRR R7
	LEA R7 printnum
	JSRR R7
	LEA R7 endl
	JSRR R7
	ADD R6, R6, #-1
	CONST R0, #6
	HICONST R0, #0
	STR R0, R6, #0
	LEA R7 fact
	JSRR R7
	LEA R7 printnum
	JSRR R7
	LEA R7 endl
	JSRR R7
	ADD R6, R6, #-1
	CONST R0, #7
	HICONST R0, #0
	STR R0, R6, #0
	LEA R7 fact
	JSRR R7
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
