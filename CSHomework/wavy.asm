;; Wavy Numbers
;; A = Input, B = Output
;; R1 = Input, R0 = Output

	.CODE		; Begin code segment
	.ADDR  0x0000	; Start adding instructions at address 0x00
START ;Go through next number
	CMPI R1 #0 ; Check if done
	BRnz END
	ADD R2 R1 #0 ;Store current input in R2
WHILE1 ;Check if increasing
	CMPI R2 #0; Check if number finished for end of loop
	BRnz REM ;Subtract one if increasing
	CONST R7 #10 ;Initialize R7
	DIV R5 R2 R7
	CMPI R5 #0 ;Check if single digit
	BRnz REM ;Subtract one if increasing
	DIV R5 R2 R7 ;Get last digit of current input into R3
	MUL R5 R5 R7
	SUB R3 R2 R5
	DIV R2 R2 R7 ;Remove last digit
	DIV R5 R2 R7 ;Get last digit of current input into R4
	MUL R5 R5 R7
	SUB R4 R2 R5
	CMP R3 R4 ;Compare last and second to last digits
	BRn WHILE1END ;End loop
	BRzp WHILE1
WHILE1END
	ADD R2 R1 #0 ;Store current input in R2
WHILE2 ;Check if decreasing
	CMPI R2 #0; Check if number finished for end of loop
	BRnz REM ;Subtract one if decreasing
	CONST R7 #10 ;Initialize R7
	DIV R5 R2 R7
	CMPI R5 #0 ;Check if single digit
	BRnz REM ;Subtract one if increasing	
	DIV R5 R2 R7 ;Get last digit of current input into R3
	MUL R5 R5 R7
	SUB R3 R2 R5
	DIV R2 R2 R7 ;Remove last digit
	DIV R5 R2 R7 ;Get last digit of current input into R4
	MUL R5 R5 R7
	SUB R4 R2 R5
	CMP R3 R4 ;Compare last and second to last digits
	BRp WHILE2END ;End loop
	BRnz WHILE2
WHILE2END
	BRnzp NEXT 
REM
	ADD R0 R0 #-1 ;Balance out output adding
NEXT
	ADD R0 R0 #1 ;Output adding
	ADD R1 R1 #-1 ;Next number
	BRnzp START ;Return to start of loop
END
