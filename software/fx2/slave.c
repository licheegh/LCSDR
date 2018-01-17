#pragma noiv                    // Do not generate interrupt vectors
//-----------------------------------------------------------------------------
//   File:      slave.c
//   Contents:  Hooks required to implement USB peripheral function.
//              Code written for FX2 REVE 56-pin and above.
//              This firmware is used to demonstrate FX2 Slave FIF
//              operation.
//   Copyright (c) 2003 Cypress Semiconductor All rights reserved
//-----------------------------------------------------------------------------
#include "Fx2.h"
#include "fx2regs.h"
#include "syncdly.h"            // SYNCDELAY macro

#define LED_DEBUG bmBIT1
#define LED_INT0 bmBIT0
#define FPGA_CLK_LOCK bmBIT7

extern BOOL GotSUD;             // Received setup data flag
extern BOOL Sleep;
extern BOOL Rwuen;
extern BOOL Selfpwr;

BYTE Configuration;             // Current configuration
BYTE AlternateSetting;          // Alternate settings
static WORD __xdata LED_Count = 0;
static BYTE __xdata LED_Status = 0;
BOOL done_frm_fpga = 0;

// EZUSB FX2 PORTA = slave fifo enable(s), when IFCFG[1:0]=11
//sbit PA0 = IOA ^ 0;             // alt. func., INT0#
//sbit PA1 = IOA ^ 1;             // alt. func., INT1#
// sbit PA2 = IOA ^ 2;          // is SLOE
//sbit PA3 = IOA ^ 3;             // alt. func., WU2
// sbit PA4 = IOA ^ 4;          // is FIFOADR0
// sbit PA5 = IOA ^ 5;          // is FIFOADR1
// sbit PA6 = IOA ^ 6;          // is PKTEND
// sbit PA7 = IOA ^ 7;          // is FLAGD

// EZUSB FX2 PORTC i/o...       port NA for 56-pin FX2
// sbit PC0 = IOC ^ 0;
// sbit PC1 = IOC ^ 1;
// sbit PC2 = IOC ^ 2;
// sbit PC3 = IOC ^ 3;
// sbit PC4 = IOC ^ 4;
// sbit PC5 = IOC ^ 5;
// sbit PC6 = IOC ^ 6;
// sbit PC7 = IOC ^ 7;

// EZUSB FX2 PORTB = FD[7:0], when IFCFG[1:0]=11
// sbit PB0 = IOB ^ 0;
// sbit PB1 = IOB ^ 1;
// sbit PB2 = IOB ^ 2;
// sbit PB3 = IOB ^ 3;
// sbit PB4 = IOB ^ 4;
// sbit PB5 = IOB ^ 5;
// sbit PB6 = IOB ^ 6;
// sbit PB7 = IOB ^ 7;

// EZUSB FX2 PORTD = FD[15:8], when IFCFG[1:0]=11 and WORDWIDE=1
//sbit PD0 = IOD ^ 0;
//sbit PD1 = IOD ^ 1;
//sbit PD2 = IOD ^ 2;
//sbit PD3 = IOD ^ 3;
//sbit PD4 = IOD ^ 4;
//sbit PD5 = IOD ^ 5;
//sbit PD6 = IOD ^ 6;
//sbit PD7 = IOD ^ 7;

// EZUSB FX2 PORTE is not bit-addressable...

//-----------------------------------------------------------------------------
// Task Dispatcher hooks
// The following hooks are called by the task dispatcher.
//-----------------------------------------------------------------------------
//void LED_Off (BYTE LED_Mask);
//void LED_On (BYTE LED_Mask);

//-----------------------------------------------------------------------------
// Task Dispatcher hooks
//   The following hooks are called by the task dispatcher.
//-----------------------------------------------------------------------------
void TD_Init( void )
{ // Called once at startup

  CPUCS = 0x00; // CLKSPD[1:0]=00, for 12MHz operation, output CLKOUT disable
  SYNCDELAY;
//  FIFOPINPOLAR |= 0x03;

  //FF: Full, EF: Empty, PF: Program
  //00:EP2 10:EP6 EPs are used.
  PINFLAGSAB = 0xE8;			// FLAGA 8 - EP2EF, FLAGB E - EP6FF
  SYNCDELAY;
  PINFLAGSCD = 0x00;			// address selected.
  SYNCDELAY;
  /*PORTACFG |= 0x80;*/         // settings for ints and flagd slcs
    /*SYNCDELAY;*/
  IFCONFIG = 0xC3; // for async? for sync? 0x83 11000011 0xE3 11100011
                    // settings for other porta config.
  SYNCDELAY;

  /*CPUCS |= 0x02;*/

  // IFCLKSRC=1   , FIFOs executes on internal clk source 
  // xMHz=1       , 48MHz operation
  // IFCLKOE=1    ,Drive IFCLK pin signal at 48MHz
  // IFCLKPOL=0   , Don't invert IFCLK pin signal from internal clk
  // ASYNC=0      , master samples synchronous
  // GSTATE=0     , Don't drive GPIF states out on PORTE[2:0], debug WF
  // IFCFG[1:0]=11, FX2 in slave FIFO mode


  // Registers which require a synchronization delay, see section 15.14
  // FIFORESET        FIFOPINPOLAR
  // INPKTEND         OUTPKTEND
  // EPxBCH:L         REVCTL
  // GPIFTCB3         GPIFTCB2
  // GPIFTCB1         GPIFTCB0
  // EPxFIFOPFH:L     EPxAUTOINLENH:L
  // EPxFIFOCFG       EPxGPIFFLGSEL
  // PINFLAGSxx       EPxFIFOIRQ
  // EPxFIFOIE        GPIFIRQ
  // GPIFIE           GPIFADRH:L
  // UDMACRCH:L       EPxGPIFTRIG
  // GPIFTRIG
  
  // Note: The pre-REVE EPxGPIFTCH/L register are affected, as well...
  //      ...these have been replaced by GPIFTC[B3:B0] registers


  
 

  // EP4 and EP8 are not used in this implementation...
                   
  EP2CFG = 0xA0;                //out 512 bytes, 4x, bulk 
  SYNCDELAY;                    
  EP6CFG = 0xE0;                //in 512 bytes, 4x, bulk
  SYNCDELAY;              
  EP4CFG = 0x02;                //clear valid bit
  SYNCDELAY;                     
  EP8CFG = 0x02;                //clear valid bit
  SYNCDELAY;   

  SYNCDELAY;
  FIFORESET = 0x80;             // activate NAK-ALL to avoid race conditions
  SYNCDELAY;                    // see TRM section 15.4
  FIFORESET = 0x82;             // reset, FIFO 2
  SYNCDELAY;                    // 
  FIFORESET = 0x84;             // reset, FIFO 4
  SYNCDELAY;                    // 
  FIFORESET = 0x86;             // reset, FIFO 6
  SYNCDELAY;                    // 
  FIFORESET = 0x88;             // reset, FIFO 8
  SYNCDELAY;                    // 
  FIFORESET = 0x00;             // deactivate NAK-ALL


  // handle the case where we were already in AUTO mode...
  // ...for example: back to back firmware downloads...
  SYNCDELAY;                    // 
  EP2FIFOCFG = 0x00;            // AUTOOUT=0, WORDWIDE=0
  
  // core needs to see AUTOOUT=0 to AUTOOUT=1 switch to arm endp's
  
  SYNCDELAY;                    // 
  EP2FIFOCFG = 0x11;            // AUTOOUT=1, WORDWIDE=1
  
  SYNCDELAY;                    // 
  EP6FIFOCFG = 0x0D;            // AUTOIN=1, ZEROLENIN=1, WORDWIDE=1

  SYNCDELAY;

  //OEx default to 0, disable out buffer.
  OEA|=LED_DEBUG | LED_INT0; //Declare PA.1 as output, LED
  IOA|=LED_DEBUG | LED_INT0; //output 1 on PA.1

  /*OEC|=0x01; //PC.0 as output (SYNC signal)*/
  /*SYNCDELAY;*/
  /*IOC|=0x00; //output 0 on PC.0...SYNC signal is LOW */
  /*SYNCDELAY;*/

  /*OEC&=0xFD; //PC.1 as input (Clock changing signal)*/
  /*SYNCDELAY;*/

}

unsigned int counter=0;
void TD_Poll( void )
{ // Called repeatedly while the device is idle

  // ...nothing to do... slave fifo's are in AUTO mode...
 
	/*	if((IOC & 0x02 ))
		{;}
		else
		{
 		//IOA&=0xFD;
  		IOC|=0x01;
		}*/
		if((IOA & FPGA_CLK_LOCK) == 0)
		{
            done_frm_fpga = 1;
		}
		if ((done_frm_fpga) && (IOA & FPGA_CLK_LOCK))
		{
			IFCONFIG = 0x03;
			SYNCDELAY;
		
			IOA&=(~LED_DEBUG); //output 1 on PC.0...SYNC signal is HIGH 
			SYNCDELAY;
			done_frm_fpga = 0;
			
		}
        counter++;
        if (counter >= 40000)
        {
            counter = 0;
            if (IOA & LED_INT0)
            {
                IOA &= (~LED_INT0);
            } else {
                IOA |= LED_INT0;
            }
        }

}

BOOL TD_Suspend( void )          
{ // Called before the device goes into suspend mode
   return( TRUE );
}

BOOL TD_Resume( void )          
{ // Called after the device resumes
   return( TRUE );
}

//-----------------------------------------------------------------------------
// Device Request hooks
//   The following hooks are called by the end point 0 device request parser.
//-----------------------------------------------------------------------------
BOOL DR_GetDescriptor( void )
{
   return( TRUE );
}

BOOL DR_SetConfiguration( void )   
{ // Called when a Set Configuration command is received
  
  if( EZUSB_HIGHSPEED( ) )
  { // ...FX2 in high speed mode
    EP6AUTOINLENH = 0x02;
    SYNCDELAY;
    EP8AUTOINLENH = 0x02;   // set core AUTO commit len = 512 bytes
    SYNCDELAY;
    EP6AUTOINLENL = 0x00;
    SYNCDELAY;
    EP8AUTOINLENL = 0x00;
  }
  else
  { // ...FX2 in full speed mode
    EP6AUTOINLENH = 0x00;
    SYNCDELAY;
    EP8AUTOINLENH = 0x00;   // set core AUTO commit len = 64 bytes
    SYNCDELAY;
    EP6AUTOINLENL = 0x40;
    SYNCDELAY;
    EP8AUTOINLENL = 0x40;
  }
      
  Configuration = SETUPDAT[ 2 ];
  return( TRUE );        // Handled by user code
}

BOOL DR_GetConfiguration( void )   
{ // Called when a Get Configuration command is received
   EP0BUF[ 0 ] = Configuration;
   EP0BCH = 0;
   EP0BCL = 1;
   return(TRUE);          // Handled by user code
}

BOOL DR_SetInterface( void )       
{ // Called when a Set Interface command is received
   AlternateSetting = SETUPDAT[ 2 ];
   return( TRUE );        // Handled by user code
}

BOOL DR_GetInterface( void )       
{ // Called when a Set Interface command is received
   EP0BUF[ 0 ] = AlternateSetting;
   EP0BCH = 0;
   EP0BCL = 1;
   return( TRUE );        // Handled by user code
}

BOOL DR_GetStatus( void )
{
   return( TRUE );
}

BOOL DR_ClearFeature( void )
{
   return( TRUE );
}

BOOL DR_SetFeature( void )
{
   return( TRUE );
}

BOOL DR_VendorCmnd( void )
{
  return( TRUE );
}

//-----------------------------------------------------------------------------
// USB Interrupt Handlers
//   The following functions are called by the USB interrupt jump table.
//-----------------------------------------------------------------------------

// Setup Data Available Interrupt Handler
void ISR_Sudav( void ) __interrupt 0
{
   GotSUD = TRUE;         // Set flag
   EZUSB_IRQ_CLEAR( );
   USBIRQ = bmSUDAV;      // Clear SUDAV IRQ
}

// Setup Token Interrupt Handler
void ISR_Sutok( void ) __interrupt 0
{
   EZUSB_IRQ_CLEAR( );
   USBIRQ = bmSUTOK;      // Clear SUTOK IRQ
}

void ISR_Sof( void ) __interrupt 0
{
   EZUSB_IRQ_CLEAR( );
   USBIRQ = bmSOF;        // Clear SOF IRQ
}

void ISR_Ures( void ) __interrupt 0
{
   if ( EZUSB_HIGHSPEED( ) )
   {
      pConfigDscr = pHighSpeedConfigDscr;
      pOtherConfigDscr = pFullSpeedConfigDscr;
   }
   else
   {
      pConfigDscr = pFullSpeedConfigDscr;
      pOtherConfigDscr = pHighSpeedConfigDscr;
   }
   
   EZUSB_IRQ_CLEAR( );
   USBIRQ = bmURES;       // Clear URES IRQ
}

void ISR_Susp( void ) __interrupt 0
{
   Sleep = TRUE;
   EZUSB_IRQ_CLEAR( );
   USBIRQ = bmSUSP;
}

void ISR_Highspeed( void ) __interrupt 0
{
   if ( EZUSB_HIGHSPEED( ) )
   {
      pConfigDscr = pHighSpeedConfigDscr;
      pOtherConfigDscr = pFullSpeedConfigDscr;
   }
   else
   {
      pConfigDscr = pFullSpeedConfigDscr;
      pOtherConfigDscr = pHighSpeedConfigDscr;
   }

   EZUSB_IRQ_CLEAR( );
   USBIRQ = bmHSGRANT;
}
void ISR_Ep0ack( void ) __interrupt 0
{
}
void ISR_Stub( void ) __interrupt 0
{
}
void ISR_Ep0in( void ) __interrupt 0
{
}
void ISR_Ep0out( void ) __interrupt 0
{
}
void ISR_Ep1in( void ) __interrupt 0
{
}
void ISR_Ep1out( void ) __interrupt 0
{
}
void ISR_Ep2inout( void ) __interrupt 0
{
}
void ISR_Ep4inout( void ) __interrupt 0
{
}
void ISR_Ep6inout( void ) __interrupt 0
{
}
void ISR_Ep8inout( void ) __interrupt 0
{
}
void ISR_Ibn( void ) __interrupt 0
{
}
void ISR_Ep0pingnak( void ) __interrupt 0
{
}
void ISR_Ep1pingnak( void ) __interrupt 0
{
}
void ISR_Ep2pingnak( void ) __interrupt 0
{
}
void ISR_Ep4pingnak( void ) __interrupt 0
{
}
void ISR_Ep6pingnak( void ) __interrupt 0
{
}
void ISR_Ep8pingnak( void ) __interrupt 0
{
}
void ISR_Errorlimit( void ) __interrupt 0
{
}
void ISR_Ep2piderror( void ) __interrupt 0
{
}
void ISR_Ep4piderror( void ) __interrupt 0
{
}
void ISR_Ep6piderror( void ) __interrupt 0
{
}
void ISR_Ep8piderror( void ) __interrupt 0
{
}
void ISR_Ep2pflag( void ) __interrupt 0
{
}
void ISR_Ep4pflag( void ) __interrupt 0
{
}
void ISR_Ep6pflag( void ) __interrupt 0
{
}
void ISR_Ep8pflag( void ) __interrupt 0
{
}
void ISR_Ep2eflag( void ) __interrupt 0
{
}
void ISR_Ep4eflag( void ) __interrupt 0
{
}
void ISR_Ep6eflag( void ) __interrupt 0
{
}
void ISR_Ep8eflag( void ) __interrupt 0
{
}
void ISR_Ep2fflag( void ) __interrupt 0
{
}
void ISR_Ep4fflag( void ) __interrupt 0
{
}
void ISR_Ep6fflag( void ) __interrupt 0
{
}
void ISR_Ep8fflag( void ) __interrupt 0
{
}
void ISR_GpifComplete( void ) __interrupt 0
{
}
void ISR_GpifWaveform( void ) __interrupt 0
{
}

// ...debug LEDs: accessed via movx reads only ( through CPLD )
// it may be worth noting here that the default monitor loads at 0xC000
/*__xdata __at 0x8000 volatile const BYTE LED0_ON  ;*/
/*__xdata __at 0x8100 volatile const BYTE LED0_OFF ;*/
/*__xdata __at 0x9000 volatile const BYTE LED1_ON  ;*/
/*__xdata __at 0x9100 volatile const BYTE LED1_OFF ;*/
/*__xdata __at 0xA000 volatile const BYTE LED2_ON  ;*/
/*__xdata __at 0xA100 volatile const BYTE LED2_OFF ;*/
/*__xdata __at 0xB000 volatile const BYTE LED3_ON  ;*/
/*__xdata __at 0xB100 volatile const BYTE LED3_OFF ;*/

// use this global variable when (de)asserting debug LEDs...
/*BYTE __xdata ledX_rdvar = 0x00;*/
/*BYTE __xdata LED_State = 0;*/
/*void LED_Off (BYTE LED_Mask)*/
/*{*/
	/*if (LED_Mask & bmBIT0)*/
	/*{*/
		/*ledX_rdvar = LED0_OFF;*/
		/*LED_State &= ~bmBIT0;*/
	/*}*/
	/*if (LED_Mask & bmBIT1)*/
	/*{*/
		/*ledX_rdvar = LED1_OFF;*/
		/*LED_State &= ~bmBIT1;*/
	/*}*/
	/*if (LED_Mask & bmBIT2)*/
	/*{*/
		/*ledX_rdvar = LED2_OFF;*/
		/*LED_State &= ~bmBIT2;*/
	/*}*/
	/*if (LED_Mask & bmBIT3)*/
	/*{*/
		/*ledX_rdvar = LED3_OFF;*/
		/*LED_State &= ~bmBIT3;*/
	/*}*/
/*}*/

/*void LED_On (BYTE LED_Mask)*/
/*{*/
	/*if (LED_Mask & bmBIT0)*/
	/*{*/
		/*ledX_rdvar = LED0_ON;*/
		/*LED_State |= bmBIT0;*/
	/*}*/
	/*if (LED_Mask & bmBIT1)*/
	/*{*/
		/*ledX_rdvar = LED1_ON;*/
		/*LED_State |= bmBIT1;*/
	/*}*/
	/*if (LED_Mask & bmBIT2)*/
	/*{*/
		/*ledX_rdvar = LED2_ON;*/
		/*LED_State |= bmBIT2;*/
	/*}*/
	/*if (LED_Mask & bmBIT3)*/
	/*{*/
		/*ledX_rdvar = LED3_ON;*/
		/*LED_State |= bmBIT3;*/
	/*}*/
/*}*/

