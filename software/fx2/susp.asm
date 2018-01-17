;;-----------------------------------------------------------------------------
;; File: susp.a51
;; Contents: 
;;
;; $Archive: /USB/Target/Lib/lp/susp.a51 $
;; $Date: 5/27/04 2:07p $
;; $Revision: 2 $
;;
;;
;;-----------------------------------------------------------------------------
;; Copyright 2003, Cypress Semiconductor Corporation
;;-----------------------------------------------------------------------------
.module     SUSP
.globl      _EZUSB_Susp

;$include (fx2regs.inc)

WAKEUPCS = 0xE682
SUSPEND = 0xE681
PCON = 0x87

;EZUSB    segment  code
.area EZUSB (CODE)

;      rseg  EZUSB    
_EZUSB_Susp: 
   mov   dptr,#WAKEUPCS    ; Clear the Wake Source bit(s) in
   movx  a,@dptr           ; the WAKEUPCS register
   orl   a,#0xC0           ; clear PA2 and WPIN
   movx  @dptr,a
   
   mov   dptr,#SUSPEND     ; 
   movx  @dptr,a           ; write any walue to SUSPEND register
   
   orl   PCON,#0x01  ; Place the processor in idle
   
   nop                     ; Insert some meaningless instruction
   nop                     ; fetches to insure that the processor
   nop                     ; suspends and resumes before RET
   nop
   nop
er_end:     ret
   

