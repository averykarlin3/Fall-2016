;; Multiplication program
;; C = A*B
;; R0 = A, R1 = B, R2 = C

	.DATA		; This is a code segment
	.ADDR  0x4000	; Start filling in instructions at address 0x00
	.BLKW #15
	.FILL 0x1
	.CODE
	.ADDR 0x0000
	CONST R1, #2
	CONST R0, #3
	CONST R2, #0    ; Initialize C to 0
	

LOOP

	CMPI R1, #0	; Compare B to 0
	Sell2
	BRNZ END 
	STEP3	; if (B <= 0) Branch to the end

	ADD R2, R2, R0	; C = C + A

STEP4
	Add R1, R1, #-1	; B =  B - 1

	BR LOOP	; Go back to the beginning of the loop

END


;.ADDR sets the current memory address being set by the code for storing instructions/data in assembly
;Labels are put unindented before a line to signify that line being written as a label
;.Fill automatically does .ADDR + 1 after
;.FALIGN moves to next multiple of 16
;CODE and DATA determine where can be written at any given time
;.BLKW moves the cursor to after the block, setting all to 0 in between
;Tabs don't matter, but new lines do
;Labels and functions are automatically made all capital if not put so, except BRnzp, the three (or less) are put lower case
;BR = BRnpz
;BLKW starts with the current unincremented location - Makes it so assembler can't set other - Software can, not assembler

; STRINGZ adds a 0 character at the end to designate the end
;MOD not working

;R1 vs r1 - both ok

;PSR - 2:0 = NZP, 15 = Supervisor Mode
;x0000-x1FFF - User Code
;x2000-x3FFF - Global Variables (User-defined)
;x4000-x6FFF - Dynamic Storage/Heap (User-defined)
;x7000-x7FFF - Local Storage/Stack (User-defined)
;x8000-x80FF - Trap Vector Table (Do Not Disturb)
;x8200-xBFFF - OS (Do Not Disturb)
;xC000-xFDFF - Video Output/Memory (Maps to pixels)
;xFE00-xFFFF - I/O Device Register Addresses

;CONST adds a signed value, (-FF-1, FF), HICONST adds xFF_00, removing the sign bit from the original

;Script file assumes decimal, uses hex otherwise

;= PC + 1 means incremented PC, not incremented twice

;.CONST/UCONST replaced by assembler during assembly - LC is for constant, not for variable
