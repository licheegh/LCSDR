;;-----------------------------------------------------------------------------
;;   File:      dscr.a51
;;   Contents:  This file contains descriptor data tables.
;;
;; $Archive: /USB/Examples/Fx2lp/bulkloop/dscr.a51 $
;; $Date: 9/01/03 8:51p $
;; $Revision: 3 $
;;
;;
;;-----------------------------------------------------------------------------
;; Copyright 2003, Cypress Semiconductor Corporation
;;-----------------------------------------------------------------------------;;-----------------------------------------------------------------------------
   
DSCR_DEVICE   =   1   ;; Descriptor type: Device
DSCR_CONFIG   =   2   ;; Descriptor type: Configuration
DSCR_STRING   =   3   ;; Descriptor type: String
DSCR_INTRFC   =   4   ;; Descriptor type: Interface
DSCR_ENDPNT   =   5   ;; Descriptor type: Endpoint
DSCR_DEVQUAL  =   6   ;; Descriptor type: Device Qualifier

DSCR_DEVICE_LEN   =   18
DSCR_CONFIG_LEN   =    9
DSCR_INTRFC_LEN   =    9
DSCR_ENDPNT_LEN   =    7
DSCR_DEVQUAL_LEN  =   10

ET_CONTROL   =   0   ;; Endpoint type: Control
ET_ISO       =   1   ;; Endpoint type: Isochronous
ET_BULK      =   2   ;; Endpoint type: Bulk
ET_INT       =   3   ;; Endpoint type: Interrupt

.module DSCR
.globl     _DeviceDscr, _DeviceQualDscr, _HighSpeedConfigDscr, _FullSpeedConfigDscr, _StringDscr, _UserDscr

;DSCR   SEGMENT   CODE PAGE
.area DSCR (CODE,ABS)
.org 0x100
;;-----------------------------------------------------------------------------
;; Global Variables
;;-----------------------------------------------------------------------------
;      rseg DSCR      ;; locate the descriptor table in on-part memory.

.even        ; descriptors must be 2-byte aligned for SUDPTR{H,L} to work
_DeviceDscr:   
      .db   DSCR_DEVICE_LEN      ;; Descriptor length
      .db   DSCR_DEVICE   ;; Decriptor type
      .dw   0x0002      ;; Specification Version (BCD)
      .db   0x00        ;; Device class
      .db   0x00         ;; Device sub-class
      .db   0x00         ;; Device sub-sub-class
      .db   64         ;; Maximum packet size
      .dw   0xB404      ;; Vendor ID
      .dw   0xF100      ;; Product ID (Sample Device)
      .dw   0x0000      ;; Product version ID
      .db   1         ;; Manufacturer string index
      .db   2         ;; Product string index
      .db   0         ;; Serial number string index
      .db   1         ;; Number of configurations
      
.even        ; descriptors must be 2-byte aligned for SUDPTR{H,L} to work
_DeviceQualDscr:
      .db   DSCR_DEVQUAL_LEN   ;; Descriptor length
      .db   DSCR_DEVQUAL   ;; Decriptor type
      .dw   0x0002      ;; Specification Version (BCD)
      .db   0x00        ;; Device class
      .db   0x00         ;; Device sub-class
      .db   0x00         ;; Device sub-sub-class
      .db   64         ;; Maximum packet size
      .db   1         ;; Number of configurations
      .db   0         ;; Reserved
      
.even        ; descriptors must be 2-byte aligned for SUDPTR{H,L} to work
_HighSpeedConfigDscr:   
      .db   DSCR_CONFIG_LEN               ;; Descriptor length
      .db   DSCR_CONFIG                  ;; Descriptor type
      .db   (HighSpeedConfigDscr_End-_HighSpeedConfigDscr) % 256 ;; Total Length (LSB)
      .db   (HighSpeedConfigDscr_End-_HighSpeedConfigDscr)  /  256 ;; Total Length (MSB)
      .db   1      ;; Number of interfaces
      .db   1      ;; Configuration number
      .db   0      ;; Configuration string
      .db   0xA0   ;; Attributes (b7 - buspwr, b6 - selfpwr, b5 - rwu)
      .db   50      ;; Power r=irement (div 2 ma)

;; Interface Descriptor
      .db   DSCR_INTRFC_LEN      ;; Descriptor length
      .db   DSCR_INTRFC         ;; Descriptor type
      .db   0               ;; Zero-based index of this interface
      .db   0               ;; Alternate setting
      .db   2               ;; Number of end points 
      .db   0xff            ;; Interface class
      .db   0x00               ;; Interface sub class
      .db   0x00               ;; Interface sub sub class
      .db   0               ;; Interface descriptor string index
      
;; Endpoint Descriptor
      .db   DSCR_ENDPNT_LEN      ;; Descriptor length
      .db   DSCR_ENDPNT         ;; Descriptor type
      .db   0x02               ;; Endpoint number, and direction
      .db   ET_BULK            ;; Endpoint type
      .db   0x00               ;; Maximun packet size (LSB)
      .db   0x02               ;; Max packect size (MSB)
      .db   0x00               ;; Polling interval


;; Endpoint Descriptor
      .db   DSCR_ENDPNT_LEN      ;; Descriptor length
      .db   DSCR_ENDPNT         ;; Descriptor type
      .db   0x86               ;; Endpoint number, and direction
      .db   ET_BULK            ;; Endpoint type
      .db   0x00               ;; Maximun packet size (LSB)
      .db   0x02               ;; Max packect size (MSB)
      .db   0x00               ;; Polling interval


HighSpeedConfigDscr_End:   

.even        ; descriptors must be 2-byte aligned for SUDPTR{H,L} to work
_FullSpeedConfigDscr:   
      .db   DSCR_CONFIG_LEN               ;; Descriptor length
      .db   DSCR_CONFIG                  ;; Descriptor type
      .db   (FullSpeedConfigDscr_End-_FullSpeedConfigDscr) % 256 ;; Total Length (LSB)
      .db   (FullSpeedConfigDscr_End-_FullSpeedConfigDscr)  /  256 ;; Total Length (MSB)
      .db   1      ;; Number of interfaces
      .db   1      ;; Configuration number
      .db   0      ;; Configuration string
      .db   0xA0   ;; Attributes (b7 - buspwr, b6 - selfpwr, b5 - rwu)
      .db   50      ;; Power r=irement (div 2 ma)

;; Interface Descriptor
      .db   DSCR_INTRFC_LEN      ;; Descriptor length
      .db   DSCR_INTRFC         ;; Descriptor type
      .db   0               ;; Zero-based index of this interface
      .db   0               ;; Alternate setting
      .db   2               ;; Number of end points 
      .db   0xff            ;; Interface class
      .db   0x00               ;; Interface sub class
      .db   0x00               ;; Interface sub sub class
      .db   0               ;; Interface descriptor string index
      
;; Endpoint Descriptor
      .db   DSCR_ENDPNT_LEN      ;; Descriptor length
      .db   DSCR_ENDPNT         ;; Descriptor type
      .db   0x04               ;; Endpoint number, and direction
      .db   ET_BULK            ;; Endpoint type
      .db   0x40               ;; Maximun packet size (LSB)
      .db   0x00               ;; Max packect size (MSB)
      .db   0x00               ;; Polling interval


;; Endpoint Descriptor
      .db   DSCR_ENDPNT_LEN      ;; Descriptor length
      .db   DSCR_ENDPNT         ;; Descriptor type
      .db   0x88               ;; Endpoint number, and direction
      .db   ET_BULK            ;; Endpoint type
      .db   0x40               ;; Maximun packet size (LSB)
      .db   0x00               ;; Max packect size (MSB)
      .db   0x00               ;; Polling interval

FullSpeedConfigDscr_End:   

.even        ; descriptors must be 2-byte aligned for SUDPTR{H,L} to work
_StringDscr:

.even        ; descriptors must be 2-byte aligned for SUDPTR{H,L} to work
_StringDscr0:   
      .db   StringDscr0_End-_StringDscr0      ;; String descriptor length
      .db   DSCR_STRING
      .db   0x09,0x04
StringDscr0_End:

.even        ; descriptors must be 2-byte aligned for SUDPTR{H,L} to work
_StringDscr1:   
      .db   StringDscr1_End-_StringDscr1      ;; String descriptor length
      .db   DSCR_STRING
      .db   'C',00
      .db   'y',00
      .db   'p',00
      .db   'r',00
      .db   'e',00
      .db   's',00
      .db   's',00
StringDscr1_End:

.even        ; descriptors must be 2-byte aligned for SUDPTR{H,L} to work
_StringDscr2:   
      .db   StringDscr2_End-_StringDscr2      ;; Descriptor length
      .db   DSCR_STRING
      .db   'E',00
      .db   'Z',00
      .db   '-',00
      .db   'U',00
      .db   'S',00
      .db   'B',00
      .db   ' ',00
      .db   'F',00
      .db   'X',00
      .db   '2',00
      .db   ' ',00
      .db   'G',00
      .db   'P',00
      .db   'I',00
      .db   'F',00
      .db   ' ',00
      .db   't',00
      .db   'o',00
      .db   ' ',00
      .db   'E',00
      .db   'x',00
      .db   't',00
      .db   ' ',00
      .db   'F',00
      .db   'I',00
      .db   'F',00
      .db   'O',00
      .db   ' ',00
      .db   'E',00
      .db   'x',00
      .db   'a',00
      .db   'm',00
      .db   'p',00
      .db   'l',00
      .db   'e',00
      .db   ' ',00
      .db   'u',00
      .db   's',00
      .db   'i',00
      .db   'n',00
      .db   'g',00
      .db   ' ',00
      .db   'S',00
      .db   'i',00
      .db   'n',00
      .db   'g',00
      .db   'l',00
      .db   'e',00
      .db   ' ',00
      .db   'T',00
      .db   'r',00
      .db   'a',00
      .db   'n',00
      .db   's',00
      .db   'a',00
      .db   'c',00
      .db   't',00
      .db   'i',00
      .db   'o',00
      .db   'n',00
      .db   's',00
StringDscr2_End:

.even        ; descriptors must be 2-byte aligned for SUDPTR{H,L} to work
_UserDscr:      
      .dw   0x0000

      
