:*********************************************************************
: Patch name: DELAY.604                 Product and Version: ISCS 6.04
:     Author: Bruce Shepherd                   Organization: NTS
:   Customer: HSBC                             Date Written: 09/19/90
: Description of Problem:  
:
:  This patch is intended for PICO engines ONLY !
:
:  On the PICO  engine  we  occasionally  enter a state during channel
:  initialization where the firmware goes into a transmit ending state
:  and the CONSAT stops sending any data.
:
:  Investigation of the SIO 8530 write registers shows that the CONSAT
:  has turned the transmitter  OFF thereby preventing any transmission
:  of  data (WR5=82).  This sequence ONLY occurs during channel  start
:  up.
:
:  This patch modifies  the initialization sequence to insure that the
:  there is adequate time for the initialization sequence  to complete
:  and the chip to settle down PRIOR to issuing the next SVC.
:

	IF	NSPORT
	LO	CONSAT
	LO	DATA

PATCH(900920,0700,BSHEPHERD,SINIT2+5E,,6)
	J	PA1PTR,,

CONPATCH(PA1PTR,,84)
	LA	R9,DQDAT*8,RP,		:  Make a bit pointer with bit addr
					:  and add and add SIO offset
	SVC	IO,90+R5		:  Connect
	JAL	R15,SABORT		:    Error return
	SVC	DISMISS,1		:  Dismiss to allow init to complete

:  	Now initialize the input program for this channel
	LIS	R6,0			
	SVC	IO,0B0+R5		:  Reset channel
	JAL	R15,SABORT		:    Error return
	SVC	DISMISS,1		:  Dismiss to allow reset to complete

	LA	R6,ENASIO
	SVC	IO,0B0+R5		:  Set RS true
	JAL	R15,SABORT		:    Error return
	SVC	DISMISS,1		:  Dismiss to allow reset to complete
	
	AIS	RP,1			:  Bump channel index
	CLHI	RP,.SPORT+NSPORT	:  Done?
	JL	SINIT2			:     No  - get next unit
	JR	R0			:     Yes - return


CONPATCH(QHNS4A,,6)
	J	PA1PTR,,

CONPATCH(PA1PTR,,1C)
	SIOIO(R3,0`,R5)			:  Start it up
	SVC	DISMISS,1		:  Dismiss to allow init to complete
	LHL	R6,ICMSOF-2*.SPORT,RP2	:  Get pointer
	J	QHNS4A+14		:  Return


CONPATCH(QHAN26+30,,6)
	J	PA1PTR,,

CONPATCH(PA1PTR,,18)
	SIOIO(R3,HNGSIO)		:   Drop DTR and hang port low
	SVC	DISMISS,1		:   Dismiss to allow init to complete
	LIS	R0,0			:   0 is completed status
	J	QHAN26+3A		:   Return

CONPATCH(QHANS7+14,,6)
	J	PA1PTR,,

CONPATCH(PA1PTR,,18)
	SIOIO(R3,ENASIO)		:   Reset and enable hardware
	SVC	DISMISS,1		:   Dismiss to allow init to complete
	J	QHANS7+24		:   Return

ENDPATCH(Patch to allow initialilzation sequence time to complete)

	FO	CONSAT
	EI	:NSPORT

:*********************************************************************

    