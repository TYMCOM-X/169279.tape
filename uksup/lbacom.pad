:Sometimes the NPA message sent by the Tymcom to the Supe seems to get lost.
:This patch will safe gaurd against this situation which should not occur.
: When the Tymcom send the NPA message, it sets a bit so that it does not
:keep re sending every 4 seconds (4 sec being the re check time for port
:availability). The bit array that record if the message has been sent is 
:called HNPA and is indexed by SORD number. If an incomming needle requests
:a host that has no ports available, then we can assume that the Supe has
:not received the NPA message. We will therfore in effect sent this message
:each time an unprocessable login request occurs.

PATCH(880113,1200,LEEWAKE,ICN310+08,,6)

	J	PA1PTR,,
CONPATCH(PA1PTR,,16)
	JAL	R5,QOCS,,
	RBT	R8,HNPA,,		:RESET NPA ARRAY
	J	ICN250,,
ENDPATCH(RESEND NPA MSG IF WE STILL RECEIVE A NEEDLE IN NPA STATE)

: When a host has all its' ports down or active, the tymcom does not
:shut itself or send a "no ports available" message to the supe.
:The routine that checks port status every 4 seconds, contains some
:errors in the indexing of two instructions.
: SOLUTION.
:Bit array CAN, contains Canidate ports that are available for assignment.
:Bit array HPTS, contains ports that are assigned to a perticular sord.
:The two arrays are ANDed to produce a positive value if ports are
:available, or a zero value if ports are not available.
: Due to indexing errors, the code pulled in incorrect vales for the two
:arrays and so correct host status handling never occured.
: The indexing is corrected bellow.
:
:   *****  THIS PATCH HAS BEEN REPLACED BY (UKSUP:26)ACOM03.J02  ***
:
:
:	PATCH(880301,1400,LEEWAKE,PAR030,,4)
:
:	J	PA1PTR
:CONPATCH(PA1PTR,,20)
:	LH	R7,CAN,,
:	NH	R7,HPTS,R10,,
:	OR	R5,R7
:	J	PAR030+0C,,
:ENDPATCH(CORRECT INDEXING OF BIT ARRAYS FOR CORRECT HOST SHUT AND NPA)

:: When inactivity timer is enabled in Tymcom, BREAKs are accumulated
:: on a seperate counter. When 18h BREAKS are counted the user is
:: zapped. When the user inputs characters the counter should be reset
:: but the method of indexing between set and reset is inconsistent
:: This patch will set and reset on port number indexing into the
:: Break counter table


	IF	INAN+1
	PATCH(870121,1400,LEEWAKE,ICBRK,,4)

	J	PA1PTR

CONPATCH(pa1ptr,,22)
	
	lb	r7,brkact,rhp,	: Index in with port number
	ais	r7,1		: Bump up count
	stb	r7,brkact,rhp,
	clhi	r7,brklim	: is limit reached
	jn	icbrk+16
	lis	r7,0		: reset counter before disconnect
	stb	r7,brkact,rhp,
	j	donbrk		: if yes drop circuit

ENDPATCH(Correct reset of break count on user activity)

	EI

:Certain Tom ports are being hung. That is, characters typed are echoed back
:(if ECHO on), but the commands are never executed by Tom. The problem relates
:to the bit array ORIRLA. It's size is dependant upon the number of groups
:assigned multiplied by a halfword store. Testing for a file transfer port
:uses RHP indexing, which for Tom ports takes it beyond the ORIRLA bit array
:and into the next unrelated field,TERMT which is set to 40 when a Tymcom user
:logs onto port 0. The Tymcom therefore uses this value when testing for RHP's
:beyond the number of groups defined ie. Tom isis ports.
:The ORIRLA bit array is checked in the isis message scanner at ISDATA+0E.
:Solution:-
:This patch checks for a Tom login and if true, skips the testing for
:FTU circuit origination (ORIRLA), since for Tom ports it is not required.
:If this is not a Tom port, test as normal.
:
PATCH(030987,1430,LEEWAKE,ISDATA+0E,,4)
	J	PA1PTR,,
:
CONPATCH(PA1PTR,,24)
	LH	R8,SORD,RHP,RHP	:get SORD number
	LR	R8,R8		:if TOM don't bother to check for FT
	JE	ISDATA+16,,	:just skip test, and return
	TBT	RHP,ORIRLA	:if not TOM host then check for FT
	JN	ISFTDT,,	:jump to file transfer
	J	ISDATA+16,,	:RETURN
:
ENDPATCH(FIX TOM HUNG PORTS - BYPASS ORIRLA BIT TEST)

:
: Patch to force high order bit of username terminator to 0
: when forwarded by the GUNAM sub-host option
:
	IF	OP|E8BTM.|
	IF	OP|GUNAM.|
	PATCH(871124,1330,LEEWAKE,PUN010,,4)

	J	PA1PTR,,
CONPATCH(PA1PTR,,24)
	GL	HERE

PUN010	LHI	R3,8D
	JAL	R4,GETCH,,
	CR	R0,R3
	JNFS	HERE
	LHI	R0,0D
HERE	JAL	R5,PPCDR,,
	SIS	R11,1
	JGBS	PUN010
	J	SUN020,,

	ENDPATCH(ONLY FOR C/R - CONVERT MARK TO SPACE WHEN GUNAM USED)

	EI
	EI	OP|E8BTM.|
:
: ATCSIX.PAT 06/17/87 PC ACOM V 3.00
: NSR 1382, patch fix to not send SIIX if no TBYEMS is defined
:
PATCH(022687,1400,P/CHU,ISDXM1+0E,,2)
	JFS	ISDXM1+1E
:
	IF	TBYEN+1
:
	IF	TBYEN
CONPATCH(ISDXM1+30,,6)
	ELSE
CONPATCH(ISDXM1+24,,6)
	EI	-TBYEN-
:
	J	PA1PTR,,
:
CONPATCH(PA1PTR,,24)
	LB	R2,0,R3
	JE	ISFLSH,,	: if no load msg defined flush rest of ISIS msg
	LR	R5,R3		: save contents of load msg string
	LHI	R2,CM.SIX	: Start of IIX msg
	JAL	R4,SLOR,,
	JAL	R4,ELOR,,
	LR	R3,R5		: restore load msg string pointer
:
	IF	TBYEN+1
	J	ISDXM1+38,,	: go back to send it
	ELSE
	J	ISDXM1+2C,,
	EI
:
ENDPATCH(NO SIIX IF LOAD MESSAGE NOT DEFINED, ACOM 3.00 ATC 3.01)
	EI	-TBYEN+1-
ENDPATCH(NO DISCONNECT MSG FOR FILE XFER, ACOM 3.00)
:
: Set switch for FTU - Only works on existance of PFILE macro ie. TX ports
:
Q	EQ	0
FTU 	EQ	0
	RE	NTPORT
	IF	\FTCH|Q|
FTU	EQ	1
	EI
Q	EQ	Q+1
	ER
:
: 01/30/87 PC
:
: THIS PATCH FIXES "NO TERMINAL TYPE MATCH" PROBLEM FOR FILE TRANSFER PORTS
: TABLE VID.ID IS USED TO MAP THE BAUD RATE INTO CCT AND SENT OUT IN THE
: PSEUDO NEEDLE REQUEST.
: FOR 4.8 LINE, THE CCT AFTER TABLE MAPPING IS 19 HEX.
: AT FILSAT, THE CCT IS ORED WITH 0C0 AND RESULTING IN 0D9.
: DESTINATION TYMCOM DOES NOT ACCEPT 0D9 AS A CCT AND THUS REJECTS
: THE CIRCUIT RESUEST.
: 
	IF	FTU
PATCH(121786,0930,P/CHU,VID.ID+0B,,1)
:
	BC	13		: 13 FOR 4800 BAUD LINE
:
CONPATCH(FLSAT1+18,,4)
:
	STB	R0,BRATE,RHP	: ONLY ONE BYTE AT A TIME
:
ENDPATCH(REDEFINE CORRECT CCT INDEX FOR 4.8K LINES, ACOM 3.00)
	EI

P0END	EQ	PA0PTR
P1END	EQ	PA1PTR

: When the Tymcom originates a circuit it does not store its' SORD number.
:This is used in other parts of the code, eg. Xon/off and Detach, for
:indexing.
: This patch calculates the sord number from the originating port and
:stores it in location SORD for futher use.

	IF	FTU 
PATCH(880128,1930,LEEWAKE,FLSA20+0A,,4)

	J	PA1PTR
CONPATCH(PA1PTR,,60)
	SBT	RHP,ORIRLA,
	JN	FLSAT1,,
	LHI	R2,1		:SKIP SORD 0, THIS IS TOM
	LHI	R1,NHPGRP*2,	:OFFSET PAST SORD 0
SORDP	TBT	RHP,HPTS,R1,	:HPTS=BIT ARRAY OF PORTS ASSIGNED TO SORDS
	JGFS	GOTIT		:WE HAVE A MATCH - JUMP!
	AHI	R2,1		:SORD COUNT
	AHI	R1,NHPGRP*2
 	JBS	SORDP
GOTIT	STH	R2,SORD,RHP,RHP	:SAVE SORD NUMBER
	RBT	RHP,DTR,,
	IF NAPORT
	RBT	RHP,NDTR,,
	RBT	RHP,DTRWT,,
	EI
	SBT	RHP,ACP,,	:SET DTR DEFORE WE SEND ACK CHAR WHEN PNEEDLE
	RBT	RHP,LOGING,,	:REPONSE (B2) ARRIVES IN IRING
	RBT	RHP,GOT.PN,,
	J	FLSA20+30,,
ENDPATCH(STORE SORD NUMBER AT CIRCUIT BUILD  AND RAISE DTR FOR FTU PORTS)
	EI

: R8 should contain the SORD number, but is being corrupted. This patch
:reloads it with the number.
:
:  *** THIS PATCH HAS BEEN AMENDED 
:
:      (UKL)ACOM03.PAD CONTAINS THE OLD INCORRECT VERSION
:      (UKL)ACOM03.PAE CONTAINS THE NEW CORRECT VERSION (THIS VERSION)
:  ***
:
COREA PATCH(890103,1600,LEEWAKE,QBK10+10,,4)
	J	PA1PTR
CONPATCH(PA1PTR,,16)
	LH	R8,SORD,RHP,RHP
	TBT	RHP,XONP,
	JE	QBK30,,
	J	QBK10+16,,
ENDPATCH(RELOAD SORD NUMBER INTO REG FOR CORRECT INDEXING)

: Tymcom originating circuits are sending accounting info on detach. This
:should be done by the destination end.
: This patch disables the accounting info.

PATCH(880310,1100,LEEWAKE,DET010,,4)
	J 	PA1PTR
CONPATCH(PA1PTR,,16)
	RBT	RHP,ORIRLA,,	:WAS IT FTU
	JE	DET011,,	:NO - SO DO ACCOUNTING
	J	DET013,,
ENDPATCH(DETACH CORRECTLY FOR FTU PORTS)
