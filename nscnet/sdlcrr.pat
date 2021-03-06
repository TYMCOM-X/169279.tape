:****************************************************************************
: Patch name	: SDLCRR.PAT
: Function	: while using scope command in extended DDT, you can turn
:		: off/on the display of RR frames by entering C/R key.
: Author	: NIS.FURUTA
: Date		: 08-Nov-1988
: modified	: 28-May-1990 by NIS.AOKI (changed format from RX1 to RX2)
:		: 13-Nov-1990 by NIS.AOKI (added LO MAIN, FO MAIN)
:		: 27-Nov-1991 by NIS.AOKI (added PA0PTR alignment)
:****************************************************************************

	LO	MAIN
	LO	STATUS
	LO	SFGRCV

PATCH(881108,1800,NIS.FURUTA,DSC030,,6)
	J	DSCRR1,,

CONPATCH(PA1PTR,,24)
DSCRR1	CHI	R0,1		: CHECK OP CODE IS RR?
	JE	DSCRR3		: YES
DSCRR2	LI	R7,DSCSIZ	: RECOVER OPERAND
	J	DSC030+6,,	: RETURN TO MAIN AND DISP FRAME

DSCRR3	LH	R7,DSCRSW,,	: TEST RR DISP SW
	JE	DSCRR2		: OFF, DISPLAY RR
	J	DSC080,,	: SKIP DISPLAY

CONPATCH(DSC10,,6)		: TURN ON/OFF
	J	PA1PTR,,

CONPATCH(PA1PTR,,16)
	ST	R0,XMTBAS,,	: RESTORE OP
	LIS	R0,0
	STH	R0,DSCRSW,,	: INITIALIZE
	J	DSC10+6,,	: BACK TO MAIN
:
:*** REPLACE  A ROUTINE DSCKBD
:
CONPATCH(DSCKBD,,6)
	J	PA1PTR,,
CONPATCH(PA1PTR,,34)
	IF	DB.NTC		: IF NETWORK CONSOLE SW ON
	JAL	R4,DS.CHK	: TEST KYBD INPUT
	ELSE
	SVC	K.IN,0		: TEST KYBD INPUT
	EI	(DB.NTC)
	J	DSCKPE		: NO INPUT

	NHI	R0,7F		: MASK HIGH BIT
	CLHI	R0,0D		: <CR>?
	JNR	R14		: HAVE INPUT BUT NOT <CR>, RETURN
	LH	R0,DSCRSW,,	: GET RR DISPLAY SW
	XHI	R0,-1		: TOGGLE SWITCH
	STH	R0,DSCRSW,,	: STORE IT

DSCKPE	AIS	R14,4		: NORMAL 'SKIP ' RETURN +4
	JR	R14

pa0ptr	eq	((pa0ptr+3)/4)*4	:align to word boundary

CONPATCH(PA0PTR,,2)
DSCRSW	HC	0
ENDPATCH(EXTD SCOP COMMAND, RR TURN ON/OFF)
	FO	SFGRCV
	FO	STATUS
	FO	MAIN
  