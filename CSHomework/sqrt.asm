;; Square Root
;; A = Input, B = Output
;; R1 = A, R0 = B

	.CODE		; Begin code segment
	.ADDR  0x0000	; Start filling in instructions at address 0x00
	CONST R0, #0    ; Initialize B to 0
IF
	CMPI R0, #0	; Compare B to 0
	BRn ENDIF ; if (B <= 0) Branch to the end
WHILE
	MUL R2, R0, R0 ; Find B^2
	CMP R2, R1 ;Compare B^2 <= A
	BRp ENDWHILE ; If B^2 <= A, leave while
	ADD R0, R0, #1 ; B = B + 1
	BRnzp WHILE; Return to start of while loop
ENDWHILE
ENDIF
	ADD R0, R0, #-1 ; B = B - 1
END
