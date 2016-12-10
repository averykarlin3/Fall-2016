.CODE
.FALIGN
testIfs
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
	CONST R0, #16
	HICONST R0, #0
	STR R0, R6, #0
	LDR R0, R6, #0
	LDR R1, R6, #1
	CMP R0, R1
	BRp testsnested_ifs_COMP_GOOD_0
	CONST R0, #0
	JMP testsnested_ifs_COMP_END_0
testsnested_ifs_COMP_GOOD_0
	CONST R0, #1
testsnested_ifs_COMP_END_0
	ADD R6, R6, #1
	STR R0, R6, #0
	ADD R6, R6, #1
	LDR R0, R6, #-1
testsnested_ifs_IF_0
	BRz testsnested_ifs_ELSE_0
	LDR R0, R6, #0
	ADD R6, R6, #-1
	STR R0, R6, #0
	ADD R6, R6, #-1
	CONST R0, #8
	HICONST R0, #0
	STR R0, R6, #0
	LDR R0, R6, #0
	LDR R1, R6, #1
	CMP R0, R1
	BRp testsnested_ifs_COMP_GOOD_1
	CONST R0, #0
	JMP testsnested_ifs_COMP_END_1
testsnested_ifs_COMP_GOOD_1
	CONST R0, #1
testsnested_ifs_COMP_END_1
	ADD R6, R6, #1
	STR R0, R6, #0
	ADD R6, R6, #1
	LDR R0, R6, #-1
testsnested_ifs_IF_1
	BRz testsnested_ifs_ELSE_1
	LDR R0, R6, #0
	ADD R6, R6, #-1
	STR R0, R6, #0
	ADD R6, R6, #-1
	CONST R0, #4
	HICONST R0, #0
	STR R0, R6, #0
	LDR R0, R6, #0
	LDR R1, R6, #1
	CMP R0, R1
	BRp testsnested_ifs_COMP_GOOD_2
	CONST R0, #0
	JMP testsnested_ifs_COMP_END_2
testsnested_ifs_COMP_GOOD_2
	CONST R0, #1
testsnested_ifs_COMP_END_2
	ADD R6, R6, #1
	STR R0, R6, #0
	ADD R6, R6, #1
	LDR R0, R6, #-1
testsnested_ifs_IF_2
	BRz testsnested_ifs_ELSE_2
	ADD R6, R6, #-1
	CONST R0, #0
	HICONST R0, #0
	STR R0, R6, #0
	JMP testsnested_ifs_ENDIF_2
testsnested_ifs_ELSE_2
	ADD R6, R6, #-1
	CONST R0, #1
	HICONST R0, #0
	STR R0, R6, #0
testsnested_ifs_ENDIF_2
	JMP testsnested_ifs_ENDIF_1
testsnested_ifs_ELSE_1
	ADD R6, R6, #-1
	CONST R0, #2
	HICONST R0, #0
	STR R0, R6, #0
testsnested_ifs_ENDIF_1
	JMP testsnested_ifs_ENDIF_0
testsnested_ifs_ELSE_0
	LDR R0, R6, #0
	ADD R6, R6, #-1
	STR R0, R6, #0
	ADD R6, R6, #-1
	CONST R0, #24
	HICONST R0, #0
	STR R0, R6, #0
	LDR R0, R6, #0
	LDR R1, R6, #1
	CMP R0, R1
	BRp testsnested_ifs_COMP_GOOD_3
	CONST R0, #0
	JMP testsnested_ifs_COMP_END_3
testsnested_ifs_COMP_GOOD_3
	CONST R0, #1
testsnested_ifs_COMP_END_3
	ADD R6, R6, #1
	STR R0, R6, #0
	ADD R6, R6, #1
	LDR R0, R6, #-1
testsnested_ifs_IF_3
	BRz testsnested_ifs_ELSE_3
	LDR R0, R6, #0
	ADD R6, R6, #-1
	STR R0, R6, #0
	ADD R6, R6, #-1
	CONST R0, #20
	HICONST R0, #0
	STR R0, R6, #0
	LDR R0, R6, #0
	LDR R1, R6, #1
	CMP R0, R1
	BRp testsnested_ifs_COMP_GOOD_4
	CONST R0, #0
	JMP testsnested_ifs_COMP_END_4
testsnested_ifs_COMP_GOOD_4
	CONST R0, #1
testsnested_ifs_COMP_END_4
	ADD R6, R6, #1
	STR R0, R6, #0
	ADD R6, R6, #1
	LDR R0, R6, #-1
testsnested_ifs_IF_4
	BRz testsnested_ifs_ELSE_4
	ADD R6, R6, #-1
	CONST R0, #3
	HICONST R0, #0
	STR R0, R6, #0
	JMP testsnested_ifs_ENDIF_4
testsnested_ifs_ELSE_4
	ADD R6, R6, #-1
	CONST R0, #4
	HICONST R0, #0
	STR R0, R6, #0
testsnested_ifs_ENDIF_4
	JMP testsnested_ifs_ENDIF_3
testsnested_ifs_ELSE_3
	LDR R0, R6, #0
	ADD R6, R6, #-1
	STR R0, R6, #0
	ADD R6, R6, #-1
	CONST R0, #32
	HICONST R0, #0
	STR R0, R6, #0
	LDR R0, R6, #0
	LDR R1, R6, #1
	CMP R0, R1
	BRp testsnested_ifs_COMP_GOOD_5
	CONST R0, #0
	JMP testsnested_ifs_COMP_END_5
testsnested_ifs_COMP_GOOD_5
	CONST R0, #1
testsnested_ifs_COMP_END_5
	ADD R6, R6, #1
	STR R0, R6, #0
	ADD R6, R6, #1
	LDR R0, R6, #-1
testsnested_ifs_IF_5
	BRz testsnested_ifs_ELSE_5
	ADD R6, R6, #-1
	CONST R0, #5
	HICONST R0, #0
	STR R0, R6, #0
	JMP testsnested_ifs_ENDIF_5
testsnested_ifs_ELSE_5
	ADD R6, R6, #-1
	CONST R0, #246
	HICONST R0, #255
	STR R0, R6, #0
testsnested_ifs_ENDIF_5
testsnested_ifs_ENDIF_3
testsnested_ifs_ENDIF_0
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
	CONST R0, #5
	HICONST R0, #0
	STR R0, R6, #0
	LEA R7 testIfs
	JSRR R7
	LEA R7 printnum
	JSRR R7
	LEA R7 endl
	JSRR R7
	ADD R6, R6, #-1
	CONST R0, #11
	HICONST R0, #0
	STR R0, R6, #0
	LEA R7 testIfs
	JSRR R7
	LEA R7 printnum
	JSRR R7
	LEA R7 endl
	JSRR R7
	ADD R6, R6, #-1
	CONST R0, #28
	HICONST R0, #0
	STR R0, R6, #0
	LEA R7 testIfs
	JSRR R7
	LEA R7 printnum
	JSRR R7
	LEA R7 endl
	JSRR R7
	ADD R6, R6, #-1
	CONST R0, #35
	HICONST R0, #0
	STR R0, R6, #0
	LEA R7 testIfs
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
