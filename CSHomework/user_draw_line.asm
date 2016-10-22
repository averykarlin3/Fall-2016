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
RED   .UCONST x6000	; 0 11111 00000 00000
GREEN .UCONST x03E0	; 0 00000 11111 00000
BLUE  .UCONST x001F	; 0 00000 00000 11111
WHITE .UCONST x7FFF	; 0 11111 11111 11111
.DATA
.ADDR x6000
.FILL x0033
.FILL x00CC
.FILL x0033
.FILL x00CC
.FILL x0033
.FILL x00CC
.FILL x0033
.FILL x00CC
.CODE
.ADDR x0000

	;; setup initial arguments for TRAP
	;;
	CONST R0 x67
	CONST R1 x14
	CONST R2 x54
	CONST R3 x23
	LC R4 GREEN
	TRAP x05
END
