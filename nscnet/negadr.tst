:--------------------------------------------------------------------------
: DATE: 02-23-89
: ESCALATION: 221067 - NIS JAPAN
: VERSION: CMTK 6.01
: AUTHOR: Richard Ho
:
: PROBLEM: Under certain conditions, the screen buffer address in the CCB
:	   table may become -1 (FFFF). When this happens,the LHL instructions
:	   would turn this negative value (-1) into a large positive value
:	   causing the slot to crash with crash type 14. LH instructions
:	   should be used instead of LHL instructions to load the screen
:	   buffer address (TBADR & DBADR) from the CCB table into a register. 
:
: SOLUTION: Change the LHL R7,DBADR,R12 and LHL R7,TBADR,R11 instructions
:	    to LH as appropriate.
:
	LO	CCB
	LO	TP
	LO	DSP
	LO	TM
	LO	PRT
	LO	OPTIM
	LO	LOGON
:
PATCH(022389,1200,R/HO,BUFA25+24,,4)
	LH	R7,DBADR,R12	
:
CONPATCH(DIN+32,,4)
	LH	R7,DBADR,R12
:
CONPATCH(DSP154,,4)
	LH	R7,TBADR,R11
:
CONPATCH(DSP715,,4)
	LH	R7,TBADR,R11
:
CONPATCH(OD105,,4)
	LH	R7,TBADR,R11
:
CONPATCH(KDM1B+4,,4)
	LH	R7,TBADR,R11
:
CONPATCH(KDMDON,,4)
	LH	R7,TBADR,R11
:
CONPATCH(EDM1B+4,,4)
	LH	R7,TBADR,R11
:
CONPATCH(OPT030+32,,4)
	LH	R7,TBADR,R11
:
CONPATCH(MENU+22,,4)
	LH	R5,TBADR,R11
:
ENDPATCH(CHANGE LHL TO LH INSTRUCTIONS TO FIX BAD SCREEN ADDRESS PROBLEM)
	FO	LOGON
	FO	OPTIM
	FO	PRT
	FO	TM
	FO	DSP
	FO	TP
	FO	CCB
