;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; File:    USER_DRAW_LINE.ASM
;;; Purpose: Draw a horizontal line starting at x=COL, y=ROW
;;;	     Uses trap: TRAP_DRAW_PIXEL in os.asm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;  Define constants the user could set prior to running program
ROW .CONST 40	; start at y=40
COL .CONST 40	; start at x=40
RE .CONST 87
CE .CONST 53
LEN .CONST 40	; draw a 40 pixel long horizontal line

;;;  Define some colors
RED   .UCONST x4000	; 0 11111 00000 00000
GREEN .UCONST x03E0	; 0 00000 11111 00000
BLUE  .UCONST x001F	; 0 00000 00000 11111
WHITE .UCONST x7FFF	; 0 11111 11111 11111
.DATA
.ADDR x4000
.STRINGZ "Hello World"
.CODE
.ADDR x0000

	;; setup initial arguments for TRAP
	;;
	LC R0, RED		; set row to draw on
	LC R1, COL		; set first column to draw on
	LC R4, RED		; set color for line
	LC R2, RE		; initalize loop counter
	LC R3, CE
	TRAP x02		; call TRAP_DRAW_PIXEL
END
