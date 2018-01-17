;;-----------------------------------------------------------------------------
;; File: usbjmptb.a51
;; Contents: 
;;
;; $Archive: /USB/Target/Lib/lp/USBJmpTb.a51 $
;; $Date: 8/12/03 3:32p $
;; $Revision: 1 $
;;
;;
;;-----------------------------------------------------------------------------
;; Copyright 2003, Cypress Semiconductor Corporation
;;
;; This software is owned by Cypress Semiconductor Corporation (Cypress) and is
;; protected by United States copyright laws and international treaty provisions. Cypress
;; hereby grants to Licensee a personal, non-exclusive, non-transferable license to copy,
;; use, modify, create derivative works of, and compile the Cypress Source Code and
;; derivative works for the sole purpose of creating custom software in support of Licensee
;; product ("Licensee Product") to be used only in conjunction with a Cypress integrated
;; circuit. Any reproduction, modification, translation, compilation, or representation of this
;; software except as specified above is prohibited without the express written permission of
;; Cypress.
;;
;; Disclaimer: Cypress makes no warranty of any kind, express or implied, with regard to
;; this material, including, but not limited to, the implied warranties of merchantability and
;; fitness for a particular purpose. Cypress reserves the right to make changes without
;; further notice to the materials described herein. Cypress does not assume any liability
;; arising out of the application or use of any product or circuit described herein. Cypress’
;; products described herein are not authorized for use as components in life-support
;; devices.
;;
;; This software is protected by and subject to worldwide patent coverage, including U.S.
;; and foreign patents. Use may be limited by and subject to the Cypress Software License
;; Agreement.
;;-----------------------------------------------------------------------------
.module      USBJmpTbl

;extrn code (_ISR_Sudav, _ISR_Sof, _ISR_Sutok, _ISR_Susp, _ISR_Ures, _ISR_Highspeed, _ISR_Ep0ack, _ISR_Stub, _ISR_Ep0in, _ISR_Ep0out, _ISR_Ep1in, _ISR_Ep1out, _ISR_Ep2inout, _ISR_Ep4inout, _ISR_Ep6inout, _ISR_Ep8inout,_ISR_Ibn)

;extrn code (_ISR_Ep0pingnak, _ISR_Ep1pingnak, _ISR_Ep2pingnak, _ISR_Ep4pingnak, _ISR_Ep6pingnak, _ISR_Ep8pingnak, _ISR_Errorlimit, _ISR_Ep2piderror, _ISR_Ep4piderror, _ISR_Ep6piderror, _ISR_Ep8piderror, _ISR_Ep2pflag)

;extrn code (_ISR_Ep4pflag, _ISR_Ep6pflag, _ISR_Ep8pflag, _ISR_Ep2eflag, _ISR_Ep4eflag, _ISR_Ep6eflag, _ISR_Ep8eflag, _ISR_Ep2fflag, _ISR_Ep4fflag, _ISR_Ep6fflag, _ISR_Ep8fflag, _ISR_GpifComplete, _ISR_GpifWaveform)

.globl  _ISR_Sudav, _ISR_Sof, _ISR_Sutok, _ISR_Susp, _ISR_Ures, _ISR_Highspeed, _ISR_Ep0ack, _ISR_Stub, _ISR_Ep0in, _ISR_Ep0out, _ISR_Ep1in, _ISR_Ep1out, _ISR_Ep2inout, _ISR_Ep4inout, _ISR_Ep6inout, _ISR_Ep8inout,_ISR_Ibn

.globl  _ISR_Ep0pingnak, _ISR_Ep1pingnak, _ISR_Ep2pingnak, _ISR_Ep4pingnak, _ISR_Ep6pingnak, _ISR_Ep8pingnak, _ISR_Errorlimit, _ISR_Ep2piderror, _ISR_Ep4piderror, _ISR_Ep6piderror, _ISR_Ep8piderror, _ISR_Ep2pflag

.globl  _ISR_Ep4pflag, _ISR_Ep6pflag, _ISR_Ep8pflag, _ISR_Ep2eflag, _ISR_Ep4eflag, _ISR_Ep6eflag, _ISR_Ep8eflag, _ISR_Ep2fflag, _ISR_Ep4fflag, _ISR_Ep6fflag, _ISR_Ep8fflag, _ISR_GpifComplete, _ISR_GpifWaveform

;extern _ISR_Sudav 
;.globl      _USB_Int2AutoVector, _USB_Int4AutoVector, _USB_Jump_Table
.globl _USB_Jump_Table
;------------------------------------------------------------------------------
; Interrupt Vectors
;------------------------------------------------------------------------------
.area AUTOVECTOR (CODE,ABS)
.org 0x0043
      ljmp   _USB_Jump_Table   ; Autovector will replace byte 45

.org 0x0053
      ljmp   _USB_Jump_Table   ; Autovector will replace byte 55

;------------------------------------------------------------------------------
; USB Jump Table
;------------------------------------------------------------------------------
;?PR?USB_JUMP_TABLE?USBJT   segment   code page   ; Place jump table on a page boundary
;      RSEG    ?PR?USB_JUMP_TABLE?USBJT   ; autovector jump table
.area USB_JUMP_TABLEUSBJT (CODE,ABS)
.org  0x600
	  _USB_Jump_Table:   
      ljmp  _ISR_Sudav            ;(00) Setup Data Available
      .db   0
      ljmp  _ISR_Sof              ;(04) Start of Frame
      .db   0
      ljmp  _ISR_Sutok            ;(08) Setup Data Loading
      .db   0
      ljmp  _ISR_Susp             ;(0C) Global Suspend
      .db    0
      ljmp  _ISR_Ures             ;(10) USB Reset     
      .db   0
      ljmp  _ISR_Highspeed        ;(14) Entered High Speed
      .db   0
      ljmp  _ISR_Ep0ack           ;(18) EP0ACK
      .db   0
      ljmp  _ISR_Stub             ;(1C) Reserved
      .db   0
      ljmp  _ISR_Ep0in            ;(20) EP0 In
      .db   0
      ljmp  _ISR_Ep0out           ;(24) EP0 Out
      .db   0
      ljmp  _ISR_Ep1in            ;(28) EP1 In
      .db   0
      ljmp  _ISR_Ep1out           ;(2C) EP1 Out
      .db   0
      ljmp  _ISR_Ep2inout         ;(30) EP2 In/Out
      .db   0
      ljmp  _ISR_Ep4inout         ;(34) EP4 In/Out
      .db   0
      ljmp  _ISR_Ep6inout         ;(38) EP6 In/Out
      .db   0
      ljmp  _ISR_Ep8inout         ;(3C) EP8 In/Out
      .db   0
      ljmp  _ISR_Ibn              ;(40) IBN
      .db   0
      ljmp  _ISR_Stub             ;(44) Reserved
      .db   0
      ljmp  _ISR_Ep0pingnak       ;(48) EP0 PING NAK
      .db   0
      ljmp  _ISR_Ep1pingnak       ;(4C) EP1 PING NAK
      .db   0
      ljmp  _ISR_Ep2pingnak       ;(50) EP2 PING NAK
      .db   0
      ljmp  _ISR_Ep4pingnak       ;(54) EP4 PING NAK
      .db   0
      ljmp  _ISR_Ep6pingnak       ;(58) EP6 PING NAK
      .db   0
      ljmp  _ISR_Ep8pingnak       ;(5C) EP8 PING NAK
      .db   0
      ljmp  _ISR_Errorlimit       ;(60) Error Limit
      .db   0
      ljmp  _ISR_Stub             ;(64) Reserved
      .db   0
      ljmp  _ISR_Stub             ;(68) Reserved
      .db   0
      ljmp  _ISR_Stub             ;(6C) Reserved
      .db   0
      ljmp  _ISR_Ep2piderror      ;(70) EP2 ISO Pid Sequence Error
      .db   0
      ljmp  _ISR_Ep4piderror      ;(74) EP4 ISO Pid Sequence Error
      .db   0
      ljmp  _ISR_Ep6piderror      ;(78) EP6 ISO Pid Sequence Error
      .db   0
      ljmp  _ISR_Ep8piderror      ;(7C) EP8 ISO Pid Sequence Error
      .db   0
;INT4_Jump_Table
      ljmp  _ISR_Ep2pflag         ;(80) EP2 Programmable Flag
      .db   0
      ljmp  _ISR_Ep4pflag         ;(84) EP4 Programmable Flag
      .db   0
      ljmp  _ISR_Ep6pflag         ;(88) EP6 Programmable Flag
      .db   0
      ljmp  _ISR_Ep8pflag         ;(8C) EP8 Programmable Flag
      .db   0
      ljmp  _ISR_Ep2eflag         ;(90) EP2 Empty Flag
      .db   0
      ljmp  _ISR_Ep4eflag         ;(94) EP4 Empty Flag
      .db   0
      ljmp  _ISR_Ep6eflag         ;(98) EP6 Empty Flag
      .db   0
      ljmp  _ISR_Ep8eflag         ;(9C) EP8 Empty Flag
      .db   0
      ljmp  _ISR_Ep2fflag         ;(A0) EP2 Full Flag
      .db   0
      ljmp  _ISR_Ep4fflag         ;(A4) EP4 Full Flag
      .db   0
      ljmp  _ISR_Ep6fflag         ;(A8) EP6 Full Flag
      .db   0
      ljmp  _ISR_Ep8fflag         ;(AC) EP8 Full Flag
      .db   0
      ljmp  _ISR_GpifComplete     ;(B0) GPIF Operation Complete
      .db   0
      ljmp  _ISR_GpifWaveform     ;(B4) GPIF Waveform
      .db   0
      
