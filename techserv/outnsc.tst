:---------------------------------------------------------------------
: Patch name:  OUTNSC.TST                   Product and Version:  PBT 9.03
:     Author:  PEGGY JING                   Organization:  STS
:   Customer:  AUTOSTRADE                   Date Written:  04/24/89
: Description of Problem:  
:	When a user enters the Network Service Screen by sending the
:	proper keystrokes, the PBT sends a READ BUFFER command to the
:	CU in order to save the user's current screen so it can be 
:	returned to the user when the Network Service Screen is presented
:	and exited.  This patch is a self-protection for PBT against
:	having problems when CU keep sending massive amount of data
:	as response to the READ BUFFER.  The patch will reset the line
:	and flush the accumulated data, keep the circuit on when the
:	operator gets into and leaves the Network Service Screen.
:---------------------------------------------------------------------
	LO	BSCPTP
	LO	BSCSXM
	LO	BSCRCV
	LO	BSCEXC
	LO	BSCCHR
	LO	BSCRRC
PATCH(890424,1000,P/JING,PA0PTR,,4)
TOMUCH	HS	1		: TOO_MUCH_DATA BIT ARRAY (ONE LINE/BIT)
CONPATCH(IZSECT,,6)
	J	PA1PTR,,	: 
CONPATCH(PA1PTR,,16)
	LHI	R4,0		: INITIALIZE TOO_MUCH_DATA BIT ARRAY
	STH	R4,TOMUCH,,
	JAL	R0,IZT,,	: RESTORE INSTRUCTION
	J	IZSECT+06,,
CONPATCH(RCVD01,,6)
	J	PA1PTR,,
CONPATCH(PA1PTR,,2E)
	THI	R0,ETXBIT	: IF ETX BIT ON?
	JN	NOAEXT		: NO ACTION IF ETX BIT ON
	LHL	R4,DCSAV,RDEV,RDEV	: GET NUMBER OF CHARS
	CHI	R4,1000		: IF IT EXCEEDS THE LIMIT?
	JL	NOAEXT		: NO ACTION IF IT DOESN'T EXCEED THE LIMIT
	SBT	RL,TOMUCH,,	: TURN ON TO_MUCH_DATA BIT FOR THIS LINE
NOAEXT	JAL	R4,GCL,,	: RESTORE INSTRUCTIONS
	JE	CLFULL,,	
	J	RCVD01+0C,,
CONPATCH(RSTP10+0A,,6)
	J	PA1PTR,,
CONPATCH(PA1PTR,,2E)
	LHL	R3,RSEG,R3,RST	: RESTORE INSTRUCTION
	TBT	RL,TOMUCH,,	: IF TOO_MUCH_DATA BIT IS ON FOR THIS LINE?
	JE	GETOUT		: NO ACTION IF BIT IS OFF
	RBT	RL,TOMUCH,,	: CLEAR TOO_MUCH_DATA BIT  
	THI	R0,ENQBIT	: IF ENQ BIT IS ON?
	JN	GETOUT		: NO ACTION IF BIT IS ON
	LHI	RC,0B4		: CHANGE DATA CHAR TO ENQ CHAR (2D)
	LA	R3,RPNENQ-RSEG,,: LOAD ENQ HANDLER ROUTINE ADDRESS
GETOUT	J	RSTP10+10,,	: BACK TO CALLING ROUTINE
ENDPATCH(PATCH FOR FIXING PROBLEMS WITH TOO MUCH DATA READ FROM CU)
	FO	BSCRCV
	FO	BSCEXC
	FO	BSCCHR
	FO	BSCRRC
	FO	BSCPTP
	FO	BSCSXM

    