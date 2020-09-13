;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
		.data
List:	.byte 100, 25, 75, 80, 35, 2, 127, 60, 18, 40, 15, 66, 90, 66, 10, 115, 59, 50, 28, 41
numListElements:
		.byte 20
                                            
		.text
	clr.b R4
	clr.b R5
	clr.b R6
	clr.b R7
	clr.b R8
	mov.b #-1, R4

next:
	tst.b R4
	jz    end
	mov.b #0, R7
	mov.b #1, R8
	mov.b #0, R4

sort:
	mov.b @R7(List), R5
	mov.b @R8(List), R6
	cmp.b R5, R6
	jge   incNums

swapNums:
	mov.b R6, @R7(List)
	mov.b R5, @R8(List)
	inc.b R4

incNums:
	inc.b R7
	inc.b R8
	cmp.b R8, numListElements
	jz    next
	jmp   sort

end:
	NOP
;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
