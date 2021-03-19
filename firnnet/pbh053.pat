: **********************************************************************
: *                                                                    *
: *  File     : PBH053.PAT                                             *
: *  Customer : FIRN                                                   *
: *  Comments : Original file - PBH07.PAM                              *
: *           : Use in all FIRN PBH 7.05 code                          *
: *                                                                    *
: **********************************************************************

: EXTENDED DDT FOR 3270 HIF (PBH) VERSIONS 7.03 AND 7.05.
:
: REQUIRES P0SIZE OF 0B00 AND P1SIZE OF 1100 (HEX).


PATCH(841128,1400,K/LUEDER,COREST-28,,4)
	WC	DSTART		:DEFINE THE DDT ENTRY POINT

CONPATCH(PA1PTR,,16+10)
:	SUBTTL	STATUS.LIB . . . .DRIVER TO PROCESS ARBITRARY COMMANDS UNDER "?STAT"
:******************************************************************
:
:	This program is the sole property and confidential
:	information of Tymshare, Inc., and may not be copied
:	in whole or in part or disclosed to any third party
:	without the prior written consent of Tymshare.
:
:*******************************************************************

:  IF	1-\DB.STA			:DEFAULT DEBUG/STATUS TO ON
:DB.STA	EQ	1
:  EI

:  IF	DB.STA				:ASSEMBLE ONLY WITH DEBUG STATUS ON

:***
:*** NOTE:  I ASSUME THAT IF THIS PATCH IS INCLUDED, IT IS DESIRED.
:***        DB.STA VALUE IS IGNORED.

:	SEG	A.CODE
:	MO	.,MAIN
	RA	$00
	GL	DSTART,DS.ELL,DS.ILL,DS.BDN,DS.ERR,DS.DLM
	GL	DS.TOK,DS.NUM,DS.EXI,DS.QUI,DS.GCH,DS.CUC,DS.DEL

:	STATUS - User Command Handler
:
:	Version history:
:	13.2  01/27/81  <BAB>Added RADIX=0 at start of mod.  Added jump
:		following 'QUIT' SVC to allow DDT "P" (proceede) command
:		to return the user to ":>" prompt.
:	13.1  11/17/81	<BAB>Added DNEXTK support, DS.DLM (last delimeter),
:		and fixed backspace for > 4 character entry, added the
:		command thought to be invalid to invalid command message.
:	13	08/81	<JK>Maintenance assumed by BAB from John Kopf
:
:		The Status package is intended to provide an extension to DDT,
:	invokable via the "?STAT" command in DDT.  Once invoked you may re-
:	activate it (provided you have not issued any DDT "G" (go) commands)
:	by typing "P ".
:
:		There is limited editing control built into the package:
:	ESC	aborts back to command level,
:	^W	discards partial 'token' already input (word or number),
:	^A	discards last char of token (backspace).
:	^H	discards last char of token (backspace).

:		Delimiters may occur in multiple (e.g. ", " is OK).  Valid
:	delimiters are:
:	C/R	L/F	H/T	","	and BLANK.

:		Entry Points:
:	DSTART	Place to exit on completion of command.
:	DNEXTK  Get next token with out prompt.
:	DS.ILL	Place to exit on illegal command -- types "Illegal command"
:	DS.BND	Place to exit of 'bad number' message
:	DS.ERR	Place to exit on command error -- types "type '\' "
:	DS.EXI	Place to exit machine.
:	DS.QUI	Place to exit back to DDT.
:	DS.GCH	Get a character...Link on R1, char (with high-order bit forced)
:			in R0...normal return if detected ^W, skip-4 if detect
:			~A, aborts back to DSTART if detects ESC.
:	DS.DEL	Check for delimiter...Link on R2, Character in R0.  Skip-4
:			return unless this is a delimiter, then normal return.
:	DS.CUC	Convert to upper case...Link on R1, Character in R0.
:	DS.TOK	Get a string token...Link on R4, TOKEN returned in R3...
:			inputs up to 4 characters, returns them (in uppercase)
:			left justified, 0 fill
:	DS.NUM	Get a number...Link on R5, expects Radix in R4...
:			number returned in R0.  May ABORT if any character is
:			input other than valid digit or delimiter.
:	DS.DLM  Location of last delimeter entered (1 byte)

:		There are two built-in commands:
:	Quit	exit back to DDT.
:	EXIt	exit machine.

:		additional commands may be defined via the DS.CMD macro:
:	 DS.CMD(TEXT,ADDR)
:	Where:	TEXT	The (UPPERCASE) target command string.
:		ADDR	The virtual address to transfer to, to service that
:				command.
:	DS.CMD generates a 12-byte discriptor for this command, at the point
:	assembly where it is invoked.  This discriptor is on a WORD boundary.


:	DEFINE ELEMENTS FOR COMMAND BLOCK
C.NEXT	EQ	0			:POINTER TO NEXT ENTRY
C.ADDR	EQ	C.NEXT+4		:POINTER TO COMMAND HANDLER
C.STR	EQ	C.ADDR+4		:RELATIVE POSITION OF STRING

:	DEFINE MACRO TO GENERATE THIS COMMAND BLOCK
DS.CMD	MACRO(STR,ADDR)[
   IF	DS.ELL
Q	WS	0
	ORG	DS.ELL
	WC	Q
	ORG	Q
   EI
DS.ELL	WC	0,ADDR
	AC	/STR/
	BND	4
]

OUT	EQ	0B			:OUTPUT SVC
IN	EQ	0A			:INPUT SVC

DS.ELL	EQ	0			:NULL POINTER FOR END OF LINKED LIST


:	SEG	A.CODE
:	MO	.,STATUS

:	First of all, We'll define some MACROs to make the code more readable!


	KILL	IFERR,GETNUM,PRINT,DPRINT	: Insure no conflicts

:	MACRO to input a number (into R0):
:	ARG -	radix to be used

GETNUM	MACRO(RAD)[
 IF	$A RAD-15
	LHI	R4,$A RAD
 ELSE
	LIS	R4,$A RAD
 EI
	JAL	R5,DS.NUM,,
]

:	MACRO to print a number (in R0) on terminal
:	ARG	Use
:	 1	Number of Digits
:	 2	Any sum of:	.S, .B, .Z, one of [ .D, .H, or .O]

.S	EQ	80			: Signed output
.B	EQ	20			: Blank fill
.Z	EQ	40			: Zero fill
.D	EQ	0A			: Decimal
.O	EQ	08			: Octal
.H	EQ	10			: Hexidecimal
RL      EQ      R8                      : CURRENT LINE NUMBER
RL2	EQ	R9
:       ISIS'S SVC
IOCTRL  EQ      3                       : I/I CONTROL
        

DPRINT	MACRO(ND,M2)[
	LHI	R1,(ND*100)!M2
	SVC	KIO,$A 10
]

:	MACRO to print a line of text on terminal
:	ARG -	address of line of text (SC format)

PRINT	MACRO(LINE)[
	SVC	K.OUT,LINE
]

:	MACRO to print a line of text on terminal USING RX3 INSTR FORMAT
:	ARG -	address of line of text (SC format)

PRINT3	MACRO(LINE)[
	SVC	K.OUT,LINE,,
]

:	MACRO to perform test, print MSG if false
IFERR	MACRO(CND,MSG)[
	J`CND`FS	.+8
	LA	R1,MSG
	J	PERR

]

:	PERR(MSG)
:	Print ERRor:
:	NL/MSG/NL
:	R1 -	Pointer to message
:	Exits to DSTART!
PERR	PRINT3(CRLF)			: New-line
	PRINT(0`,R1)			: MSG
	PRINT3(CRLF)			: New-line
	J	DS.ERR,,		: ...and Error-exit


CONPATCH(PA0PTR,,1C+10)
:	SEG	A.DATA
DS.DLM	BS	1			:LAST DELIMETER ENCOUNTERED
R4SAV	WS	1			:SAVE AREA FOR R4 IN DS.TOK
BADSTR	SC	/'xxxx'"8D"8A/		:PLACE TO PUT BAD COMMAND
BADNUM	SC	/ Bad number /

CONPATCH(PA1PTR,,32+10)
:	SEG	A.CODE


:	TABLE OF COMMANDS, AND TARGET ROUTINES.
CMDLST	WS	0			:FORCE TO WORD BOUNDARY
	DS.CMD(Q,DS.QUI)		:EXIT BACK TO DDT
	DS.CMD(QUIT,DS.QUI)		:EXIT BACK TO DDT
	DS.CMD(EXIT,DS.EXI)		:EXIT 
	DS.CMD(EXI,DS.EXI)		:EXIT 

CONPATCH(PA0PTR,,25+10)
:	DIAGNOSTIC MESSAGES
TERR	SC	/Illegal command /
TTERR	SC	/type '\'"8D"8A/
PROMPT	SC	/"8D"8A:>/		:"CR|LF:>"
BKSPAC	SC	/"88 "88/		:BACK SPACE

CONPATCH(PA1PTR,,1C0+10)
:	SUBTTL	COMMAND SCANNER, VERIFIER, AND BITCHER

:	COMMAND INPUT HANDLER
DOIT	L	R0,C.ADDR,R1		:GO SERVICE THIS COMMAND
	JALR	R0,R0

:	NEXT COMMAND
DSTART	SVC	OUT,PROMPT,,		:ISSUE PROMPT
DNEXTK	JAL	R4,DS.TOK		:GET COMMAND TOKEN
	LA	R1,CMDLST		:SEARCH FOR STRING MATCH
DSTAR1	CL	R3,C.STR,R1
	JE	DOIT			:PROCEED IF FIND A MATCH
	L	R1,C.NEXT,R1		:ELSE CONTINUE SCAN
	JGBS	DSTAR1
DS.ILL	SVC	OUT,TERR,,		:"ILLEGAL COMMAND"
	ST	R3,BADSTR+2,,		:"XXX"<CR>
	SVC	OUT,BADSTR,,
DS.ERR	SVC	OUT,TTERR,,		:TELL USER TO TYPE FLUSH CHAR
BITCH	JAL	R1,DS.GCH		:FLUSH INPUT
	JBS	BITCH;	 NOPR	0			:^W...IGNOR
	JBS	BITCH;	 NOPR	0			:^A...IGNOR
	CLHI	R0,0	:READ UNTIL "\" IS FOUND
	JNBS	BITCH
	J	DSTART			:THEN EXIT

DS.BDN	SVC	OUT,BADNUM,,		:"BAD NUMBER"
        J       DS.ERR



:	BUILT-IN COMMANDS

:		Command EXIt
:		===========-
DS.EXI	SVC	KIO,0			:DISCONNECT


:		Command Quit (exit back to DDT)
:		=========---
DS.QUI	SVC	KIO,1			:RETURN TO DDT
	J	DSTART			:IF OPERATOR TYPED "P", GET NEXT COMMAND
:	SUBTTL	U T I L I T I E S

:	GET A COMMAND TOKEN...UP TO 4 CHARS LONG
:		SKIPS OVER EXTRA CHARACTERS TO NEXT DELIMITER
:	LINK ON R4
:	TOKEN RETURNED IN R3, LEFT JUSTIFIED, ZERO FILLED, UPPER CASE, 
:                                MARK PARITY.
DS.TOK	HS	0
	ST	R4,R4SAV,,		:SAVE R4
TOKEN0	JAL	R1,DS.GCH		:GET NEXT CHAR
	JBS	TOKEN0;	 NOPR	0			:^W...IGNORE
	JBS	TOKEN0;	 NOPR	0			:^A...IGNORE
	JAL	R2,DS.DEL		:SKIP OVER DELIMITERS
	J	TOKEN0
	JAL	R1,DS.CUC		:CONVERT TO UPPER CASE
	CHI	R0,00DC			:= "\" ?
	JE	DSTART			:YES, PRINT PROMPT, GET NEXT COMMAND
	LBR	R3,R0			:SET UP STRING ACCUMULATOR (000000CC)
	LIS	R4,1			:1 CHAR. FOUND SO FAR
TOKEN	JAL	R1,DS.GCH		:GET ANOTHER CHAR
	J	TOKEN0			:^W...START OVER
	J	TOKEN3			:^A...TOSS LAST CHAR
	JAL	R1,DS.CUC		:CONVERT TO UPPER CASE
	JAL	R2,DS.DEL		:CHECK FOR DELIMITER
	J	TOKEN1			:GOT ONE...SKIP TO LEFT JUSTIFY IT
	CHI	R0,00DC			:= "\" ?
	JE	DS.ILL			:YES, TREAT AS ILLEGAL
	AIS	R4,1			:ONE MORE CHARACTER
	CHI	R4,4			:IF => 4 CHARS, DO NOT USE THIS ONE
	JG	TOKEN			:YES...SCAN FOR DELIMITER
	SLLS	R3,8			:NO...ACCUMULATE CHARS
	STBR	R0,R3
	J	TOKEN			:AND GET ANOTHER CHAR
TOKEN1	HS	0
	L	R4,R4SAV,,		:RESTORE R4
TOKEN2	TI	R3,0FF000000		:HAVE WE 4 CHARS ALREADY?
	JNR	R4			:YES...RETURN TOKEN IN R3
	SLLS	R3,8			:NO...JUSTIFY IT
	JBS	TOKEN2			:AND REPEAT

TOKEN3	HS	0			:HANDLE BACKSPACE IN TOKEN
	SIS	R4,1			:ONE LESS CHAR
	CHI	R4,4			:IF AFTER BACKSPACE TOKEN IS => 4
	JGE	TOKEN			: JUST DECRIMENT COUNTER
	SRLS	R3,8			:ELSE... DROP 1 CHARACTER
	J	TOKEN			:AND GET NEXT CHAR.

:	UTILITY ROUTINE TO READ A NUMBER
:	USES R0-R3
:	EXPECTS RADIX IN R4
:	LINK ON R5
:	ABORTS IF FIRST NON-DELIMITER IS NOT DIGIT
:	ELSE RETURNS NUMBER IN R0
DS.NUM	JAL	R1,DS.GCH		:GET NEXT CHAR
	JBS	DS.NUM;	 NOPR	0			:^W...IGNORE
	JBS	DS.NUM;	 NOPR	0			:^A...IGNORE
	JAL	R2,DS.DEL		:CHECK FOR DELIMITER CHAR
	J	DS.NUM
	JAL	R2,DS.DIG		:TEST IF CHAR IS DIGIT
	J	DS.BDN			:NOT A DIGIT - GIVE ERROR MESSAGE
	CLR	R0,R4
	JGE	DS.BDN			:DIGIT IS BIGGER THAN RADIX...ABORT
	LR	R3,R0			:PUT FIRST DIGIT INTO ACCUMULATOR
NUMBER	JAL	R1,DS.GCH		:READ NEXT CHAR
	J	DS.NUM			:^W...START OVER
	J	DIVIDE			:^A...TOSS LAST DIGIT
	JAL	R2,DS.DEL		:CHECK FOR DELIMITER
	LR	R0,R3;	 JR	R5	  :YES
	JAL	R2,DS.DIG		:SKIP IF DIGIT
	J	DS.BDN			:NO...ABORT
	CLR	R0,R4
	JGE	DS.BDN			:RADIX ERROR...BITCH
	MR	R2,R4			:BUILD NUMBER
	AR	R3,R0			:ADD NEW DIGIT
	J	NUMBER			:GET NEXT DIGIT
DIVIDE	LIS	R2,0			:GOT A ^A...MAKE DOUBLE-PRECISION ARG.
	DR	R2,R4			:QUOTENT INTO R3, WHERE WE WANT IT
	J	NUMBER			:NOW GO BACK FOR MORE DIGITS

:	DIGIT TEST
:	CHECK CHARACTER READ...SKIP RETURN IF DIGIT
:	THEN R0=BINARY VALUE OF HEX DIGIT
:	USES R1, LINK ON R2
DS.DIG	JAL	R1,DS.CUC		:CONVERT TO UPPER CASE
	LR	R1,R0			:COPY CHAR
	SHI	R1,0B0			:IS IT "0"?
	JLR	R2			:RETURN IF LESS THAN "0"
	SIS	R1,0B9-0B0		:IS IF "9"
	JLEFS	DIGIT			:LESS THAN "9" THEN A GOOD DIGIT
	SIS	R1,0C1-0B9		:IS IT "A"?
	JLR	R2			:RETURN IF LESS THAN "A"
	SIS	R1,0C6-0C1		:IS IF "F"?
	JGR	R2			:RETURN IF GREATER THAN "F"
	SIS	R0,7			:0A - "A" (PARTIAL CONVERSION)
DIGIT	SHI	R0,0B0			:"0"
	J	4,R2			:SKIP RETURN

:	CHECK FOR DELIMITER
:	LINK	R2
:	USES	R0,R1
:	SKIP-4 RETURN UNLESS (R0) IS A DELIMITER CHARACTER
DS.DEL	LHI	R1,DLEN-1		:NUMBER OF DELIMITER CHARS
	STB	R0,DS.DLM,,		:SAVE DELIMITER
DELIM	CLB	R0,DLIST,R1		:COMPARE TO A DELIMITER
	JER	R2			:RETURN IF DELIMITER
	SIS	R1,1			:CHECK NEXT DELIMITER
	JGEBS	DELIM			:LOOP IF ANY MORE DELIMITERS
	J	4,R2			:SKIP RETURN
:	LIST OF DELIMITER CHARS
DLIST	AC	' ,'			:BLANK,COMMA
	BC	8D,8A,89		:CR,LF,HT
DLEN	EQ	.-DLIST			:NUMBER OF DELIMITER CHARS

:	INPUT A CHARACTER
:	LINK	R1
:	NORMAL RETURN:  ^W INPUT...FLUSH ENTRY
:	SKIP-4 RETURN:  ^A or ^H INPUT...FLUSH LAST CHAR
:	SKIP-8 RETURN: CHAR IN R0 (HIGH-BIT ON)
:	ABORTS TO COMMAND SCANNER ON "ESC"
DS.GCH	SVC	IN,0F			:GET THE CHAR
	J	DS.GCH
	OHI	R0,80			:SET HIGH-ORDER BIT
	CLHI	R0,9B			:CHECK FOR ESCAPE
	 JE	DSTART			:ABORT, PROCEED WITH PROMPT IF SO
	CLHI	R0,97			:CHECK FOR ^W
	 JER	R1			:NORMAL RETURN
	CLHI	R0,81			:CHECK FOR ^A
	 JE	4,R1			:SKIP-4 RETURN
	CLHI	R0,88			:CHECK FOR ^H
	 JN	8,R1			:NO, SKIP-8 RETURN, CHAR IN R0

	SVC	OUT,BKSPAC,,		:BACK SPACE
	J	4,R1			:SKIP-4 RETURN FOR ^H

:	CONVERT CHAR IN (R0) TO UPPER CASE
:	LINK ON R1
DS.CUC	CLHI	R0,0E1			:COMPARE WITH "a"
	JLR	R1			:EXIT IF IT CAN'T BE LOWERCASE
	CLHI	R0,0FA			:COMPARE WITH "z"
	JGR	R1			:NOT LOWER CASE...JUST RETURN
	SHI	R0,20			:LOWER CASE...CONVERT TO UPPER
	JR	R1			:AND RETURN

:	EM

:  EI	:(DB.STA)
:	SUBTTL	EXTENDED DDT MODULES - EXTDDT.F01
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                                                                ::
::	This program is the sole property and confidential	  ::
::	information of Tymshare, Inc., and may not be copied	  ::
::	in whole or in part or disclosed to any third party	  ::
::	without the prior written consent of Tymshare.		  ::
::                                                                ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:EXTDDT.F02  5-24-83..JXB ADD SYMGEN FOR PTP TRACE SYMBOLS


:	SEG	A.CODE
:	MO	.,MAIN
	LO	CRASH
:        LO      LINE
        LO      BSCPTP

:-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
DECB.3	EQ	032A	:WIDTH= 3, BLANK FILL, BASE=10
DECB.9	EQ	092A	:WIDTH= 9, BLANK FILL, BASE=10
HEXB.3	EQ	0330	:WIDTH= 3, BLANK FILL, BASE=16
HEXZ.4	EQ	0450	:WIDTH= 4,  ZERO FILL, BASE=16
HEXB.5	EQ	0530	:WIDTH= 5, BLANK FILL, BASE=16
HEXZ.5	EQ	0550	:WIDTH= 5,  ZERO FILL, BASE=16
HEXZ.8	EQ	0850	:WIDTH= 8,  ZERO FILL, BASE=16
HEXB.9	EQ	0930	:WIDTH= 9, BLANK FILL, BASE=16
HEXB.A	EQ	0A30	:WIDTH=10, BLANK FILL, BASE=16

CONPATCH(PA0PTR,,2+10)
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::	D A T A    A R E A S					  ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:	SEG	A.DATA
PRICNT	HS	1

CONPATCH(PA1PTR,,6E+10)
:	SEG	A.CODE

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::		DDT COMMANDS, 'ZZ' AND '\'			  ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

	DS.CMD(CB,DS.QUI)		:QUIT IF NAD TRIES TO GO INTO
	DS.CMD(CA,DS.QUI)		: ASCII OR BINARY MODE

	DS.CMD(ZZ,DS.EXI)		:ALLOW ZZ TO LOG OFF ALSO

	DS.CMD(\,DDTNOP)
DDTNOP	J	DSTART			:PRINT PROMPT, LOOK FOR NEXT TOK.

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::		HELP AND '?'					  ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

	DS.CMD(HELP,DDTHLP)
	DS.CMD(?,DDTHLP)
:
:	THIS HELP ROUTINE CAN BE USED TO OUTPUT LISTS OF MESSAGES.
:	R1 = ADDRESS OF THE LIST OF STRINGS TO OUTPUT, TERMINATED WITH ZERO.
:	R2 = LINK REGISTER FOR RETURN POINT.
:	DDTHL1 IS THE ENTRY POINT, IF YOU WANT THE ROUTINE TO RETURN
:		TO THE CALLER.
:	DDTHL2 IS THE ENTRY POINT, IF YOU WANT THE ROUTINE TO RETURN
:		TO THE DDTNOP ADDRESS, FOR THE COMMAND PROCESSOR.

DDTHLP	HS	0
	LA	R1,HLPDAT,,		:GET START OF HELP DATA
:
:(ENTRY POINT, IF WANT TO RETURN TO COMMAND PROCESSOR)
DDTHL2	LA	R2,DDTNOP		:RETURN TO COMMAND PROCESSOR
:
:(ENTRY POINT, IF WANT TO RETURN TO CALLING ROUTINE)
DDTHL1	HS	0
	LB	R0,0,R1			:TEST FOR DONE
	JEFS	DDTHL9			:ZERO = DONE
	SVC	OUT,0,R1		:OUTPUT IT
	SVC	K.OUT,CRLF,,		:PUT CR LF ON END OF LINE.
	AR	R1,R0			:GET NEXT LINE
	AIS	R1,1			:+ 1 BYTE FOR THE LENGTH
	JBS	DDTHL1			: TIL DONE
:
DDTHL9	JR	R2			:RETURN TO CALLER
:
:
CONPATCH(PA0PTR,,418+10)
	NOLIST
CRLF SC	/"8D"8A/
HLPDAT	EQ	.
   SC	/      3270 HOST VERSION 7.05 Interface Extended DDT"8A/
   SC   /--- Syntax ---   --- Action ---------------------------------------/
   SC	/HELP or ?        Print this list/
   SC	/RI     <addr>    Display Dispatcher Input Ring/
   SC   /                    From address <addr> or start of ring/
   SC	/RO     <addr>    Display Dispatcher Output Ring/
   SC   /                    From address <addr> or start of ring/
   SC   /RB               Display both Rings continuously/
   SC   /                    Type "AF to terminate Display for PT, RI, RO, or RB/
   SC   /SYM              Print a list of symbol addresses/
   SC   /STAT             Status of all lines, control units, devices/
	IF	PTPTSW
   SC   /SCOPE  <line>    Print protocol trace on lines specified by <line>/
	EI	:PTPTSW
   SC	/CRASh            Display Crash Table contents/
   SC	/QUIT or Q        Back to DDT/
   SC	/EXIT or ZZ       Log off, returning to PLEASE LOG IN/
   SC	/"8AEDITING CHARACTERS ARE:/
   SC	/ESC              Abort, returning to DDT command level/
   SC	/CONTROL-A        Character delete, backspace function/
   SC	/CONTROL-H        Character delete, backspace function/
   SC	/CONTROL-W        Discards partial token already input"8A/

   BC	0		:ZERO VALUE TERMINATES THE LIST OF STRINGS.
	LIST

SPACE1  SC      / /
SPACE2	SC	/  /
STAR	SC	/*/

	HS	0		:COMMAND TABLE MUST BE ALLIGNED
CMDTLI	AC	'bsbe'		:BREAK START, BREAK END


CONPATCH(PA1PTR,,106+10)

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                                                              ::
::  SYMBOLIC LIST                                                ::
::                                                              ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:
:  SYMBOL GENERATION MACRO
:
SYMGEN  MACRO(NAME) [
        IF      1-\SYMNAM
SYMNAM  EQ      .
SYM.NO  EQ      0
        EI
        SC      /NAME  /
SYAD|SYM.NO|    EQ      NAME
SYM.NO  EQ      SYM.NO+1
        ]
:
:  SYMBOL TABLE END
:
SYMEND  MACRO [
Q       EQ      0
SYMADR  WS      0
        RE      SYM.NO
        WC      SYAD|Q|
Q       EQ      Q+1
        ER
        WC      0       :TERMINATE LIST
        ]

        DS.CMD(SYM,DDTSYM)

DDTSYM
        LA      R2,SYMNAM               :POINT AT SYMBOL LIST
        LA      R3,SYMADR
DDTSY1
        L       R0,0,R3
        JE      DDTNOP                  :DONE
        SVC      OUT,CRLF,,
        LHI     R1,HEXZ.5
        SVC     KIO,$A10
        SVC     OUT,SPACE2,,
        SVC     OUT,0,R2
        LB      R0,0,R2
        AR      R2,R0
        AIS     R2,1
        AIS     R3,4
        J       DDTSY1

:
:  SYMBOL TABLE
:
        SYMGEN(IRING)		: IRING START ADDRESS
        SYMGEN(IRSIZE)		: SIZE OF IRING
        SYORING)		: ORING START ADDRESS
        SYMGEN(ORSIZE)		: SIZE OF ORING
        SYMGEN(CRAT)		: CRASH TABLE START ADDRESS

	LO	BBUFER
        SYMGEN(BBUFER)		: ADDRESS OF START OF BIG BUFFERLET DATA AREA
        SYMGEN(FREE1)		: POINTER TO FIRST BBUFER AVAILABLE IN CHAIN
        SYMGEN(FREE2)		: POINTER TO LAST BBUFER AVAILABLE IN CHAIN
        SYMGEN(NBBFLT)		: NUMBER OF BIG BUFFERLETS ALLOCATED

	LO BSCRCV
        SYMGEN(RRING)		: ONE HALF WORD PER LINE, IF THE VALUE IS
				: CHANGING, CLOCKS ARE PRESENT ON THE LINE.
	SYMGEN(RRINGX)		: ADDRESS TABLE OF START OF EACH SYNC 
				: LINE INPUT RING.
	SYMGEN(ISECT)		: ADDRESS OF INPUT BUFFER.


        SYMGEN(PTRBIT)
        SYMGEN(PTPTRX)
        SYMGEN(PTPTTB)
        SYMEND

:        FO      LINE
        FO      CRASH
:        EM

:	SUBTTL	EXTENDED DDT MODULES - ISIS RING INTERPRETER
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::	ISIS RING INTERPERTER					::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::								::
::	This package will decode ISIS dispatcher rings and	::
::	display them on a DDT port.  Messages thas may contain	::
::	meaningful ASCII text (data, needles, and 1DOWN) are	::
::	displayed in hex and ASCII.  All other messages are	::
::	displayed only in hex.					::
::								::
::	Requirments:						::
::		This code requires ISIS-II version 5 (or above)	::
::		and the STAT.LIB library.  It uses the message	::
::		length tables in segment F (15d) in ISIS.	::
::								::
::	Commands:						::
::		This package includes 4 commands.  With this	::
::		set of commands you may examine rings that	::
::		have, and have not wrapped.  Also any output	::
::		from these commands may be terminated by typing	::
::		any character ("\" is recomended).  All 	::
::		commands may be followed by an optional number.	::
::		This number represents the number of seconds	::
::		to wait looking for new ring activity.  This	::
::		may beused to observe rings for N seconds, in	::
::		'real time'.					::
::								::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:
LENGTH	EQ	0F0028		:SEG E AND SEG F DATA AREAS
LP0LST	EQ	0F0026
NPORTS	EQ	0E0082
IRINGP	EQ	0E0068		:CONTAINS START OF INPUT RING
ORINGP	EQ	0E006C		:CONTAINS START OF OUTPUT RING
IMAXI	EQ	0E0084		:CONTAINS INPUT RING SIZE (HALFWORD)
OMAXI	EQ	0E0086		:CONTAINS OUTPUT RING SIZE (HALFWORD)
RING	EQ	4		:4 BYTES PAST 1ST POINTER IS RING
NFMI	EQ	0		:FILL POINTER


CONPATCH(PA1PTR,,100+10)
:
: Extended DDT Isis Interpreter Translation Table.
: This table is used to change the
: EBCDIC to ASCII-HEX to improve the
: isis ring interpreter while using
: this module in a 3270 Interface.
:
EAHEX	BC	2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E	:00-0F
	BC	2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E	:10-1F
	BC	2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E	:20-2F
	BC	2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E	:30-3F
	BC	20,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,3C,28,2B,2E	:40-4F
	BC	26,2E,2E,2E,2E,2E,2E,2E,2E,2E,21,24,2A,29,3B,2E	:50-5F
	BC	2D,2F,2E,2E,2E,2E,2E,2E,2E,2E,2E,2C,25,5F,3E,3F	:60-6F
	BC	2E,2E,2E,2E,2E,2E,2E,2E,2E,60,3A,23,40,27,3D,22	:70-7F
	BC	2E,61,62,63,64,65,66,67,68,69,2E,2E,2E,2E,2E,2E	:80-8F
	BC	2E,6A,6B,6C,6D,6E,6F,70,71,72,2E,2E,2E,2E,2E,2E	:90-9F
	BC	2E,7E,73,74,75,76,77,78,79,7A,2E,2E,2E,2E,2E,2E	:A0-AF
	BC	2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E,2E	:B0-BF
	BC	7B,41,42,43,44,45,46,47,48,49,2E,2E,2E,2E,2E,2E	:C0-CF
	BC	7D,4A,4B,4C,4D,4E,4F,50,51,52,2E,2E,2E,2E,2E,2E	:D0-DF
	BC	5C,2E,53,54,55,56,57,58,59,5A,2E,2E,2E,2E,2E,2E	:E0-EF
	BC	30,31,32,33,34,35,36,37,38,39,7C,2E,2E,2E,2E,2E	:F0-FF



CONPATCH(PA0PTR,,4+10)
:        SEG     A.DATA
XDIIND  HS      1               :INPUT INDEX
XDOIND  HS      1               :OUTPUT INDEX


CONPATCH(PA0PTR,,9A+10)
:	SUBTTL	ISIS RING INTERPRETER (DATA AREAS)
:	SEG	0
XDRSS0	HS	0
XDRPLU	SC	/"8D"8A"2B/		:<CR>, <LF>, "+"
SIAASC	AC	/0123456789ABCDEF/
CAPITT	HC	0,0,0,0,0,0,7FFF,0FFE0
XD2BLK	SC	/  /		:TWO BLANKS
XDRVL	HC	0082,0000	:VARIABLE LENGTH MESSAGE FLAGS
XDRMS5	SC	/    /
XDRMS4	SC	/NDL/		:NEEDLE
XDRMS3	SC	/DAT/		:DATA
XDRASC	SC	/  |                |/
XDRCEI	HS	1		:OUR CEI
XRNG    SC      /  /
XDSAV	WS	10		:REG SAVE AREA
SAVR10	HS	2		:REG 10 SAVE AREA

CONPATCH(PA1PTR,,0D0+10)
:	ISIS CONTROL MESSAGES
XDRICA	HS	0
	SC	/DET/	:DETACH MESSAGE TYPE
	SC	/ZAP/	:DISCONNECT MESSAGE
	SC	/NOS/	:APPLY BACK-PRESSURE (NO SEND)
	SC	/SND/	:RELEASE BACK-PRESSURE (SEND)
	SC	/ICM/	:FLUSH OUTPUT (GOBBLER)
	SC	/BKG/	:FLUSH INPUT (BACK GOBBLER)
	SC	/BLK/	:DATA LOST IN THIS DIRECTION (BLACK BALL)
	SC	/GRY/	:DATA LOST IN OPPOSITE DIRECTION (GREY BALL)
	SC	/EDE/	:ENTER DEFERED ECHO MESSAGE
	SC	/LDE/	:LEAVE DEFERED ECHO MESSAGE
	SC	/ETM/	:ENTER TRANSPARENCY MODE
	SC	/LTM/	:LEAVE TRANSPARENCY MODE
	SC	/GB /	:GREEN BALL
	SC	/RB /	:RED BALL
	SC	/YB /	:YELLOW BALL
	SC	/OB /	:ORANGE BALL
	SC	/BRK/	:BREAK DETECTED
	SC	/HNG/	:HANG UP
	SC	/QTP/	:QUERY TERMINAL PARAMETER
	SC	/STP/	:SET TERMINAL PARAMETER
	SC	/PSN/	:PSEUDO NEEDLE
	SC	/NLC/	:NORMAL LOGON CHAR
	SC	/NLS/	:NORMAL LOGON STATUS
	SC	/LOF/	:LOG ON FAILURE
	SC	/NCC/	:NORMAL CIRCUIT COMPLETE
	SC	/ADA/	:ADDENDUM TO ACCOUNTING
	SC	/SHG/	:SUPER-HANG UP
	SC	/TLM/	:SET TRANSMIT LIMIT
	SC	/EBK/	:END OF BREAK
	SC	/ZAK/	:ZAP ACK
	SC	/EAD/	:ENTER ALTERNATE OUTPUT DEVICE MODE
	SC	/LAD/	:LEAVE ALTERNATE OUTPUT DEVICE MODE
	SC	/ZAR/	:ZAP WITH REASON
	SC	/SIX/	:START INTERFACE INFORMATION EXCHANGE
	SC	/TIX/	:TERMINATE INTERFACE INFORMATION EXCHANGE

:	INTRA NODE MESSAGES
:	-------------------

XDRICB	HS	0
	SC	/RQR/	:RESTART REQUEST
	SC	/RST/	:RESTART INTERFACE
	SC	/NTO/	:NODE HAS BEEN TAKEN OVER
	SC	/REP/	:REPORT TO SUPERVISOR'S LOG
	SC	/RHS/	:REPORT HOST STATUS (OBSOLETE)
	SC	/RAC/	:REPORT ACCOUNTING
	SC	/TIM/	:GMT TIME
	SC	/RNP/	:REQUEST FOR NORMAL PSEUDO NEEDLE
	SC	/RAP/	:REQUEST AUX PSEUDO-NEEDLE
	SC	/PSR/	:PSEUDO-NEEDLE REJECTED
	SC	/HPA/	:HOST PORT AVAILABILITY
	SC	/HNA/	:HOST NOT ACCEPTABLE
	SC	/RHC/	:REPORT HOST COST
	SC	/NSU/	:NO SUPERVISOR
	SC	/ODN/	:1-DOWN TEXT
	SC	/RAH/	:REPORT ALL HOSTS
	SC	/HSR/	:HOST STATUS REPORT


CONPATCH(PA1PTR,,1C8+10)
:	SEG	A.CODE

:********************************
:
:  DISPLAY INPUT RING
:
:********************************
	LO	RING
	DS.CMD(RI,XDIR)		:DISPATCHER INPUT RING
:
XDIR
        JAL     R14,XDRPRI      :GET PARAMETERS
        SVC     0B,CRLF,,
XDIRLP
        JAL     R14,XDRKBD      :TEST KYBD INPUT
        J       DDTNOP          :DONE
        JAL     R14,XDRDIR      :INPUT RING
        SVC     DISMISS,0
        J       XDIRLP

:*******************************
:
:  DISPLAY OUTPUT RING
:
:*******************************
	DS.CMD(RO,XDOR)		:DISPATCHER OUTPUT RING
:
XDOR
        JAL     R14,XDRPRO      :GET PARAMETERS
        SVC     0B,CRLF,,
XDORLP
        JAL     R14,XDRKBD      :TEST KYBD INPUT
        J       DDTNOP          :DONE
        JAL     R14,XDRDOR      :OUTPUT RINNG
        SVC     DISMISS,0
        J       XDORLP

:*******************************
:
:  DISPLAY BOTH INPUT AND OUTPUT RINGS
:
:*******************************
	DS.CMD(RB,XDR)		        :WRAPPED DISP OUTPUT RING
:
XDR
:        LIS     R0,0
	LH	R0,IRING+CEI,,
        STH     R0,XDIIND,,
	LH	R0,ORING+CEI,,
        STH     R0,XDOIND,,
        SVC     0B,CRLF,,
XDRLP
        JAL     R14,XDRKBD      :TEST KYBD INPUT
        J       DDTNOP          :DONE
        JAL     R14,XDRDOR      :OUTPUT RING FIRST
        JAL     R14,XDRDIR      :INPUT RING
        SVC     DISMISS,0
        J       XDRLP


:
:	DUMP I/O RINGS
:
RR	EQ	8		:REGISTER ADDRESS OF RING
RS	EQ	9		:REGISTER RING SIZE

:	R0  - SCRATCH
:	R1  - INDEX INTO RING
:	R10 - LINK TO SUBROUTINES
:	R12 - FLAG FOR PRINTING/NOT PRINTING
:
XDRDIR
        LA	RR,IRING,,	:HANDLE IRING
	LHI	RS,IRSIZE	:RING SIZE
        LH      R0,NFMI,RR      :GET RING INDEX
        LH      R1,XDIIND,,
        CLR     R0,R1
        JER     R14
:
        LHI     R0,0049         : I
        STB     R0,XRNG+1,,
:
        JAL     R13,XDRISM
        AIS     R1,3
        NHI     R1,-4
        CR      R1,RS           :TEST FOR WRAP
        JLFS    XDRDIW
        SR      R1,RS
XDRDIW
        SVC     0B,CRLF,,
        STH     R1,XDIIND,,       :UPDATE OUTPUT INDEX
        JR      R14

:*******************************
:
: OUTPUT RING
:
:*******************************
XDRDOR
        LA	RR,ORING,,	:HANDLE ORING
	LHI	RS,ORSIZE	:RING SIZE
        LH      R0,NFMI,RR      :GET RING INDEX
        LH      R1,XDOIND,,
        CLR     R0,R1
        JER     R14             :EXIT
:
        LHI     R0,4F           : O
        STB     R0,XRNG+1,,
:
        JAL     R13,XDRISM
        AIS     R1,3
        NHI     R1,-4
        CR      R1,RS           :TEST FOR WRAP
        JLFS    XDRDOW
        SR      R1,RS
XDRDOW
        SVC     0B,CRLF,,       :OUTPUT CRLF
        STH     R1,XDOIND,,       :OUTPUT INDEX
        JR      R14

:*******************************
:
: KYBD CHECK
:
:*******************************
XDRKBD
        SVC     K.IN,0          :TEST KYBD INPUT
        J       XDRKBE          :NONE, SO NORMAL RETURN
:
        JR      R14
XDRKBE
        AIS     R14,4           :NORMAL "SKIP" RETURN
        JR      R14             :NORMAL EXIT

:*******************************
:
: GET PARAMETERS
:
:*******************************
XDRPRI
:        LIS     R0,0            :START AT ZERO
	LH	R0,IRING+CEI,,
	LHI	R1,008D		:GET A <CR>
	CLB	R1,DS.DLM,,	:DELIMETER CHAR = <CR> ?
	JE  	XDRPI0		:YES, START AT BEGINNING
:
	LHI	R4,10   	:SET RADIX TO HEX
	JAL	R5,DS.NUM	:GET A NUMBER (IN R0)
:
        LA      RR,IRING+4,,    :GET START ADDRESS
        CLR     R0,RR           :COMPARE
        JL      DS.ALOW
:
        AI      RR,IRSIZE       :GENERATE END ADDRESS
        CLR     R0,RR
        JG      DS.AHI
:
        SI      R0,IRING+4      :GENERATE START ADDRESS
        NHI     R0,0FFFC        :ALIGN TO WORD
XDRPI0
        STH     R0,XDIIND,,     :IRING INDEX
        JR      R14

:*******************************
:
: GET PARAMETERS
:
:*******************************
XDRPRO
:        LIS     R0,0            :START AT ZERO
	LH	R0,ORING+CEI,,
	LHI	R1,008D		:GET A <CR>
	CLB	R1,DS.DLM,,	:DELIMETER CHAR = <CR> ?
	JE  	XDRPO0		:YES, START AT BEGINNING
:
	LHI	R4,10   	:SET RADIX TO HEX
	JAL	R5,DS.NUM	:GET A NUMBER (IN R0)
:
        LA      RR,ORING+4,,    :GET START ADDRESS
        CLR     R0,RR           :COMPARE
        JL      DS.ALOW
:
        AI      RR,ORSIZE       :GENERATE END ADDRESS
        CLR     R0,RR
        JG      DS.AHI
:
        SI      R0,ORING+4      :GENERATE START ADDRESS
        NHI     R0,0FFFC        :ALIGN TO WORD
XDRPO0
        STH     R0,XDOIND,,     :ORING INDEX
        JR      R14

:
:  ERROR ROUTINE
:
DS.ALOW
        SVC     OUT,ADRLOW,,
        J       DS.ERR
:
DS.AHI
        SVC     OUT,ADRHI,,
        J       DS.ERR

CONPATCH(PA0PTR,,25+10)
ADRLOW  SC      /Address too low"8D"8A/
ADRHI   SC      /Address too high"8D"8A/


CONPATCH(PA1PTR,,21C+10)
:********************************
:
:  PROCESS ISIS MESSAGE
:
:  R1           RING INDEX
:  R8 (RR)      RING START ADDRESS
:  R9 (RS)      RING SIZE
:  R13          LINK
:
:********************************
XDRISM	LB	R2,RING+2,R1,RR	:GET MESSAGE CODE
	LHL	R3,RING,R1,RR	:GET PORT #
	JE	XDR0C0		:IF INTRANODE MESSAGE
:	CHECK FOR A VALID PORT #, KEEP INCRIMENTING TIL FOUND
	CLH	R3,NPORTS,,	:TEST AGAINST MAX PORT #
	JLEFS	XDR0A5		:OK, CONTINUE
:
	AIS	R1,4		:MOVE TO NEXT POSSIBLE PORT
	JBS	XDRISM		:LOOP LOOKING FOR A VALID PORT #
:	PORT NUMBER IS VALID
XDR0A5	LIS	R12,1		:DEFAULT PRINTING ON <*>
	LR	R2,R2		:CHECK FOR NEEDLE
	JE	XDR0F0		:IF SO
:
	CLHI	R2,9E		:DATA MESSAGE ??
	JL	XDR0B0		:IF SO
:
	JAL	R10,XPRADD	:PRINT ADDRESS
	SHI	R2,9E		:BIAS TO 0
	LA	R4,,R2,R2	:FOR INDEXING
	SVC	0B,XDRICA,R4,R4	:ASCII MESSAGE LABEL
	LIS	R12,0		:DO NOT PRINT ISIS CONTROL MESSAGES IN ASCII <*>
	JAL	R10,XDRISB	:GO DUMP ISIS CONTROL MESSAGE
        JR      R13             :RETURN

:
:  DATA MESSAGE
:
XDR0B0
	JAL	R10,XPRADD	:PRINT ADDRESS
	SVC	0B,XDRMS3,,	:"DATA" MESSAGE HEADER
	JAL	R10,XDRISA	:GO DUMP ISIS DATA MSG
        JR      R13             :RETURN

:
: PORT 0 INTRANODE MESSAGE
:
XDR0C0
	JAL	R10,XPRADD	:PRINT ADDRESS
	LA	R4,,R2,R2	:FOR INDEXING
	SVC	0B,XDRICB,R4,R4	:ASCII MESSAGE LABEL
	TBT	R2,XDRVL,,	:VARIABLE LENGTH MESSAGE ??
	JNFS	XDR0D0		:IF SO BECAUSE CAN'T HANDLE YET
	LIS	R12,0		:DO NOT PRINT CONTROL MESSAGE <*>
	JAL	R10,XDRISC	:GO DUMP ISIS INTRANODE MESSAGE
        JR      R13             :RETURN
XDR0D0	LIS	R12,1		:<*> SET TO PRINT
	CLHI	R2,8		:AUX CIRCUIT REQUEST ??
	JN	XDR0E0		:MUST BE "1-DOWN"
	LA	R4,0A,R1	:STEP TO SIZE BYTE
	CR	R4,RS		:CHECK FOR WRAP AROUND
	JLFS	XDR0D4		:IF NOT
	SR	R4,RS		:IF SO
XDR0D4	LB	R6,RING,RR,R4	:GET VARIABLE STRING SIZE
	AIS	R6,0B		:ADD CONSTANT PORTION
	LHI	R0,20		:INSERT A SPACE
	SVC	KIO,0E
	JAL	R10,XDRISE	:TO PUT OUT MESSAGE
        JR      R13             :RETURN
XDR0E0	LA	R4,5,R1		:STEP TO 1-DOWN STRING SIZE
	CLHI	R4,RS		:CHECK FOR WRAP AROUND
	JLFS	XDR0E4		:IF NOT
	SHI	R4,RS		:IF SO
XDR0E4	LB	R6,RING,RR,R4	:GET VARIABLE MESSAGE SIZE
	AIS	R6,6		:ADD FIXED MESSAGE LENGTH
	LHI	R0,20		:INSERT A SPACE
	SVC	KIO,0E
	JAL	R10,XDRISE	:TO PUT OUT MESSAGE
        JR      R13             :RETURN

:
:  NEEDLE
:
XDR0F0
	JAL	R10,XPRADD	:PRINT ADDRESS
	SVC	0B,XDRMS4,,	:NEEDLE MESSAGE
	LB	R6,RING+3,R1,RR	:GET ADDITIONAL LENGTH
	AIS	R6,4		:ADD FIXED PORTION
	LHI	R0,20		:INSERT A BLANK
	SVC	KIO,0E		:PUT IT OUT
	JAL	R10,XDRISE	:TO PUT REST OF MESSAGE
        JR      R13             :RETURN

:
: TEST LOWER CASE, MAKE UPPER CASE IF TRUE
:
CAPIT	TBT	R0,CAPITT,,	:TEST FOR LOWER CASE CHARACTER
	JER	R1		:IF NOT
	SHI	R0,20		:ADJUST TO CAPITALIZE
	JR	R1		:RETURN


:	R1 - RING INDEX
:	R2 - MSG CODE TYPE
:	R3 - PORT #
:	R4 - SCRATCH
:	R5 - BYTE TO OUTPUT
:	R6 - SCRATCH
:	R7 - LINE LENGTH COUNTER
:	RS - RING SIZE  (R8)
:	RR - RING START (R9)
:	R10- LINK TO HERE
:	R11- LINK TO XDPUT

:	DATA MESSAGE
XDRISA	LA	R6,3,R2		:MESSAGE LENGTH=MESSAGE TYPE+3
	LHI	R0,20		:INSERT A SPACE
	SVC	KIO,0E		:LETS BE TIDY
	J	XDRISE
:	CONTROL MESSAGE
XDRISB	LB	R6,LENGTH+9E,R2,:MESSAGE LENGTH FROM TABLE (IN SEG F)
	AIS	R6,2
	LHI	R0,20		:INSERT A SPACE
	SVC	KIO,0E
	J	XDRISE
:	INTRANODE MESSAGE TYPE
XDRISC	LHL	R6,LP0LST,,	:SEG F HAS THIS TOO
	LB	R6,NRATE,R6,R2	:MESSAGE LENGTH FROM TABLE
	AIS	R6,2
	LHI	R0,20		:INSERT A SPACE
	SVC	KIO,0E
	J       XDRISE
XDRISD	HS	0
	SVC	0B,XDRASC,,	:ASCII EQUIVALENT OF LINE
	SVC	0B,CRLF,,	:NEW LINE
	ST	R10,SAVR10,,
	JAL	R10,XPRADD	:PRINT ADDRESS :*:
	L	R10,SAVR10,,
	SVC	0B,XDRMS5,,	:4 BLANKS FOR ALIGNMENT
XDRISE	LIS	R7,0		:LINE LENGTH COUNTER
XDRISF	LB	R0,RING,R1,RR	:NEXT BYTE FROM RING
	LR	R5,R0		:SAVE A GOOD COPY OF IT
	NHI	R0,0FF		:IGNORE ALL BUT LOWER BYTE.
XDRISH	HS	0
	LB	R0,EAHEX,R5,	:USE LOOKUP TABLE TO TRANSLATE EBCDIC TO ASCII
	LR	R4,R7		:COMPUTE WHERE TO PLUG INTO LINE
	NHI	R4,0F		:16 BYTES PER LINE
	STB	R0,XDRASC+4,R4,	:PUT 'ER THERE
	JAL	R11,XDPUT	:PUT IT OUT
	AIS	R1,1		:BUMP RING INDEX
	CR	R1,RS		:END OF RING ??
	JLFS	XDRISG		:IF NOT
	SR	R1,RS		:FOLD TO RING START
XDRISG	AIS	R7,1		:LINE LENGTH
	SIS	R6,1		:CHECK FOR END OF MSG
	JLE	XDRISI		:FINISH BLANKING AND PRINT	
	THI	R7,0F		:END OF LINE
	JE	XDRISD		:IF SO
	THI	R7,1		:END OF HALFWORD
	JN	XDRISF		:IF NOT TO CONTINUE
	LHI	R0,20		:ADD A SPACE
	SVC	KIO,0E		:TO FORMAT WORDS
	J	XDRISF
XDRISI	LHI	R0,20		:BLANK
	LR	R12,R12		:PRINT DATA ? (1=YES)
	JER	R10		:NO, RETURN
XDRISJ	NHI	R7,0F		:LINE LENGTH OF 16
	JEFS	XDRISK		:IF TO END OF LINE
	STB	R0,XDRASC+4,R7,	:PUT IN A BLANK
	SVC	0B,XD2BLK,,	:PRINT 2 BLANKS TO ALLIGN DATA
	THI	R7,1		:ODD ?
	JNFS	XDRISL		:YES, DO NOT PRINT BLANK
	SVC	KIO,0E		:PRINT A BLANK (REG 0)
XDRISL	HS	0
	AIS	R7,1		:COUNT ON UP
	JBS	XDRISJ		:AND SEE IF DONE
XDRISK	SVC	0B,XDRASC,,	:YES, PUT IT OUT
	JR	R10		:DONE



:	R0 USED BY SVC FOR OUTPUT CHARACTER
:	R1-R3 SAVED
:	R4 DESTROYED
:	R5 BYTE TO BE OUTPUT
:	R11 LINK
XDPUT	LBR	4,5		:COPY IT
	SRHLS	4,4		:LEFT NIBBLE
	LB	0,SIAASC,4,	:CONVERT TO ASCII ("0" TO "F")
	SVC	KIO,0E		:PUT IT OUT TO TTY
	NHI	5,0F		:RIGHT NIBBLE
	LB	0,SIAASC,5,	:CONVERT TO ASCII ("0" TO "F")
	SVC	KIO,0E		:PUT IT OUT TO TTY
	JR	R11		:RETURN
:
:	WRITE ADDRESS AT START OF DATA/MESSAGE/NEEDLE LINE
:
:	R10 - LINK TO THIS ROUTING
:	ALL OTHERS PRESERVED!
:
XPRADD
	STM	R0,XDSAV,,
        SVC     0B,XRNG,,
	LA	R0,RING,R1,RR		:GET ADDR OF THIS MESSAGE
	LHI	R1,HEXB.5
	SVC	KIO,$A10
	LHI	R0,0020			:PRINT BLANK
	SVC	KIO,$A14
	LM	R0,XDSAV,,
	JR	R10


CONPATCH(PA1PTR,,0E+10)		:STAT COMMAND

	DS.CMD(STAT,DSTATS)	:DEFINE THE STAT ENTRY POINT.

	LO	BSCDTR

CONPATCH(PA0PTR,,2A2+10)


SMSG2   SC      /     STATUS OF 3270 DEVICES, CONTROL UNITS AND LINES/
SMSG30  SC      /   **** LINE:  LU=/
: SMSG31  SC      /,  PU=/
SMSG32  SC      /,  DSR=/
SMSG40  SC      /     **   CU:  ADDR=/
SMSG41  SC      /,  RETRIES=/
SMSG42  SC      /,  NAKS=/
SMSG43  SC      /,  POLLS=/
: SMSG44  SC      /POLLING STOP BY COMMAND/
SMSG45  SC      /PRESENT/
SMSG46  SC      /NO POLLS FROM HOST/
SMSG50  SC      /         DEV:  ADDR=/
SMSG51  SC      /,  STATE=/
SMSGD   SC      /ON/            : SWITCH IS ON
SMSGE   SC      /OFF/           : SWITCH IS OFF
SMSGF   SC      /IDLE/          : STATE IS IDLE
SMSG10  SC      /LOGON/         : STATE IS LOGON
SMSG11  SC      /CKT BLT ASCII MODE/ 	: STATE IS CIRCUIT BUILT ASCII MODE
SMSG13  SC      /NOT REQUIRED/
SMSG14  SC      /CKT BLT NATIVE MODE/ 	: STATE IS CIRCUIT BUILT NATIVE MODE
:SMSG15  SC      /ILLEGAL VALUE/ 	: STATE IS ILLEGAL STATE
:		(TREAT ILLEGAL VALUE SAME AS IDLE STATE)
:
SMSG1   SC      /*********************************************************/
SMSG6   SC      /     LU      = LOGICAL UNIT ADDRESS/
: SMSG7   SC      /     PU      = PHYSICAL UNIT ADDRESS/
SMSG8   SC      /     DSR     = DATA SET READY STATE, ON, OFF OR NOT REQUIRED/
SMSG9   SC      /     RETRIES = DATA RETRY COUNT/
SMSGA   SC      /     NAKS    = COUNT OF NEGATIVE ACKS, OR TRANSMIT ERRORS/
SMSGB   SC /     STATE   = IDLE, LOGON, OR CIRCUIT BUILT--ASCII OR NATIVE MODE/
SMSG12  SC      /     POLLS   = PRESENT, OR NO POLLS FROM HOST/
SMSGC   SC      /     ADDR    = CONTROL UNIT ADDRESS, OR DEVICE ADDRESS/
	BC	0	:ZERO TERMINATES THE LIST.
:
CONPATCH(PA1PTR,,192+10)
: STATUS - DISPLAY STATUS OF ALL LINES, CUS, AND DEVICES.
: WORKING REGISTER: R4,R5,R6,R7,R9 --- R4 CONTAINS FULL WORD SHIFT OF RDEV
:                                      R9 CONTAINS CONTROL UNIT #
DSTATS	HS	0
        PRINT3(CRLF)
        PRINT3(SMSG1)
        PRINT3(CRLF)
        PRINT3(CRLF)
        PRINT3(SMSG2)
        PRINT3(CRLF)
        PRINT3(CRLF)
        PRINT3(SMSG1)
        PRINT3(CRLF)
        LIS     RL,0            : START FROM LINE 0
STAT10  PRINT3(SMSG30)           : DISPLAY HEADING
        LB      R0,BSRLUN,RL,   : GET LOGICAL UNIT NUMBER
        DPRINT(2,.B!.D)          : DISPLAY IT
        LR      R5,R0           : PUT LU # IN R5
:        PRINT3(SMSG31)           : DISPLAY 'PU ='
:        LA      R6,ATTLST,,     : START ADDR. OF THE BUFFER FOR SVC.
:        LIS     R7,2            : REQUEST 2 ATTRIBUTE BYTES
:        SVC     IOCTRL,IOQRY.+R5,,:I/O STATUS QUERY
:        J       SCRASH          : INVALID BUFFER ADDR.
:        LB      R0,ATTLST+1,,   : GET PHYSICAL UNIT ADDR.
:        DPRINT(3,.B!.D)          : DISPLAY IT
        PRINT3(SMSG32)           : DISPLAY 'DSR ='
        TBT     RL,DTRDSR,,     : DOES DTRDSR AVAILABLE
        JEFS    STAT25          : N -SKIP
        TBT     RL,BSCDSR     : IS BSCDSR ON?
        JNFS    STAT20          : 1 = OFF
        PRINT3(SMSGD)           : DISPLAY DSR ON
        JFS     STAT30
STAT20  PRINT3(SMSGE)            : DISPLAY OFF
        JFS     STAT30
STAT25  PRINT3(SMSG13)           :DSR IS NOT AVAILABLE
STAT30  
        PRINT3(SMSG41)           : DISPLAY 'RETRANS ='
        LB      R0,RETRY,RL         : GET RETRY COUNT FOR THIS LINE
        DPRINT(3,.B!.D)          : DISPLAY IT

        PRINT3(SMSG42)           : DISPLAY 'NAK = '
        LHL     R0,BSCXER,RL,RL : GET # TRANSMIT ERRORS
        DPRINT(5,.B!.D)          : DISPLAY IT
        PRINT3(CRLF)
        LB      R9,FCU,RL      : GET 1ST CU#
STAT35  PRINT3(SMSG40)           : DISPLAY HEADING
        LB      RDEV,FDEV,R9   : GET 1ST DEV#
        LR      R4,RDEV
        SLLS    R4,2            : MAKE IT FULL WORD
        LB      R0,DEVLA+1,R4   : GET CU ADDR.
        DPRINT(2,.B!.H)          : DISPLAY IT
:
       : DISPLAY STATUS OF C.U.
STAT52	HS
STAT54  PRINT3(CRLF)
STAT55  PRINT3(SMSG50)           : DISPLAY 'DEV  ADDR. ='
        LR      R4,RDEV
        SLLS    R4,2            : MAKE IT FULL WORD
        LB      R0,DEVLA+2,R4   : GET DEV ADDR.
        DPRINT(2,.B!.H)          : DISPLAY IT
        PRINT3(SMSG51)           : DISPLAY 'STATE ='
: DISPLAY DEV. STATE
        LHL     RDCB,DEVTAB,RDEV,RDEV   : GET DEV. DCB
        CH      RDCB,DUMDCB,,   : SEE IF DUMMY DCB--DEVICE IDLE
        JE      STAT75
        LB      R7,DMODE,RDCB,  : GET DEVICE MODE
        CHI     R7,AMODE        : (R7)=2 ----> CIRCUIT BUILT ASCII MODE
        JE      STAT65          : SKIP IF = 2
        CHI     R7,NMODE        : (R7)=3 ----> CIRCUIT BUILT NATIME MODE
        JE      STAT66          : SKIP IF = 3
        JG      STAT67          : SKIP IF > 3
        CHI     R7,LMODE        : (R7) = 1 ----> LOGON MODE
        JN      STAT75          : N- IT IS IDLE,REPORT IT
        PRINT3(SMSG10)          : REPORT LOGON MODE
        J       STAT80
STAT65  PRINT3(SMSG11)          : REPORT CIRCUIT BUILT ASCII MODE
        JFS     STAT80
STAT66  PRINT3(SMSG14)          : REPORT CIRCUIT BUILT NATIVE MODE
        JFS     STAT80
STAT67             : REPORT IDLE STATE, THOUGH IT IS ILLEGAL STATE
STAT75  PRINT3(SMSGF)           : REPORT IDLE
STAT80  
        PRINT3(SMSG43)          : 'STATUS ='
	TBT     RDEV,DEVP1      : IS HOST POLLING THIS DEVICE?
        JEFS    STAT83          : N - SKIP
        PRINT3(SMSG45)          : DISPLAY DEVICE ACTIVE
        JFS     STAT85
STAT83  PRINT3(SMSG46)          : NO POLLS FROM HOST
STAT85  PRINT3(CRLF)
        AIS     RDEV,1          : INCREASE DEV. NUMBER
        CLB     RDEV,FDEV+1,R9 : ARE WE DONE FOR THIS CU?
        JL      STAT55          : N - CONTINUE
        AIS     R9,1           : NEXT CU.
        CLB     R9,FCU+1,RL    : ARE WE DONE FOR THIS LINE?
        JL      STAT35          : N - CONTINUE
        AIS     RL,1            : Y - NEXT LINE
        CHI     RL,NBILM        : ALL DONE?
        JL      STAT10          : N - NEXT LINE
			        : Y - COMPLETE TABLE
	LA	R1,SMSG1,,	:LOAD ADDRESS OF LIST OF MESSAGES
	JAL	R2,DDTHL1	:USE DDT HELP PROCESSOR TO OUTPUT MESSAGE
        PRINT3(SMSG1)
        PRINT3(CRLF)
        J       DSTART
SCRASH  JAL     R10,CRASH,,     : 


	IF	PTPTSW
:
:************************************************************************
:
:	subttl 3270 SCOPE PROTOCOL TRACE TABLE DISPLAY COMMAND (EXTENDED DDT) 
:
:       INITIAL VERSION BY: KIT LUEDER, 12/20/84.
:
:
::	This package will decode BSC protcol trace information	
::	gathered by the sync trace package and display same	
::	in "real time".                                     	
::								::
::	Requirments:						::
::		This code requires ISIS-II version 5 (or above)	::
::		and the STAT.LIB library.                     	::
::								::
::	Commands:						::
::		This package includes 1 command.   With this	::
::		command you may display sync trace info	::
::		in real time.                               	::
::								::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:
:        MO      .,STATUS
        LO      BSCPTP
        LO      MAIN
:
CONPATCH(PA0PTR,,03)
:        SEG     A.DATA
DSCIND  HS      1               :INDEX SAVE AREA


CONPATCH(RCV110+28,,8)		:***NOTE: THIS CHANGE REQUIRES BUMP INDEX OF 2.
	NOPR	R0		:NOP OUT INSERTION OF TRACE STATE ADDRESS
	NOPR	R0
	NOPR	R0
	AIS	R6,2		:CHANGE BUMP INDEX FROM 4 TO 2.

CONPATCH(SETER2+26,,8)
	NOPR	R0		:NOP OUT INSERTION OF TRACE STATE ADDRESS
	NOPR	R0
	NOPR	R0
	AIS	R14,2		:CHANGE BUMP INDEX FROM 4 TO 2.

CONPATCH(PA1PTR,,13D)
:	SEG	A.CODE

:********************************
:
:  DISPLAY TRACE INFO
:
:********************************
:
	DS.CMD(SCOPE,DSC)
:
DSC
        LHI     R4,$A10         :GET LINE NUMBER IN DECIMAL
        JAL     R5,DS.NUM       :INTO R0
        CHI     R0,NBILIN-1     :RANGE CHECK
        JLEFS   DSC1            :OK
:
        SVC     0B,BIGNUM       :ELSE OUTPUT MESSAGE
        J       DDTNOP
DSC1
        LR      R5,R0           :SAVE LINE NUMBER
        RBT     R5,PTRBIT,,     :RESET TRACE BIT
        LHL     R1,PTPTRX,,     :GET TRACE INDEX
        STH     R1,DSCIND,,     :SAVE IT
        SBT     R5,PTRBIT,,     :SET TRACE BIT
        SVC     0B,DSCHDR,,       :PRINT OUT HEADER
        SVC     0B,CRLF,,       :AND CRLF
DSCLP
        JAL     R14,DSCKBD      :TEST KYBD INPUT
        J       DSCEXT          :FOUND, SO EXIT
        JAL     R14,DSCCHK      :CHECK FOR POINTER MOVEMENT
        SVC     DISMISS,0       :ELSE DISMISS
        J       DSCLP           :AND LOOP
DSCEXT
        RBT     R5,PTRBIT,,     :RESET TRACE BIT
        J       DDTNOP          :AND EXIT

BIGNUM  SC      /*** Line Number too big ***/
:*******************************
:
: KYBD CHECK
:
:*******************************
DSCKBD
        SVC     K.IN,0          :TEST KYBD INPUT
        J       XDRKBE          :NONE, SO NORMAL RETURN
:
        JR      R14
XDRKBE
        AIS     R14,4           :NORMAL "SKIP" RETURN
        JR      R14             :NORMAL EXIT

:********************************
:
:  LOOK FOR POINTER MOVEMENT
:
:********************************
DSCCHK
        LHL     R13,DSCIND,,     :GET CURRENT INDEX
        LHL     R2,PTPTRX,,     :THEN TRACE INDEX
        CR      R13,R2          :TEST
        JER     R14             :EXIT IF NO MOVEMENT
:
        LB      R0,PTPTTB,R13,  :POINT AT XMIT
        JGE     DSCXMN
DSCXHX
        LHI     R1,HEXB.3
        SVC     KIO,$A10
        SVC     0B,DSCUDF,,       :SEND UNDEFINED
        J       DSCCRV
DSCXMN
        CLHI    R0,DSCXND
        JG      DSCXHX
:
        LHI     R1,HEXB.3
        SVC     KIO,$A10
        LIS     R7,7
        MHR     R7,R0           :GENERATE OFFSET
        LA      R6,,R7,,        :TO INDEX
        SVC     0B,DSCXMT,R6,
DSCCRV
        LHI     R0,0020
        SVC     KIO,$A14
:
        LB      R0,PTPTTB+1,R13,
        JGE     DSCRMN
DSCRHX
        LHI     R1,HEXB.3
        SVC     KIO,$A10
        SVC     0B,DSCUDF,,       :SEND UNDEFINED
        J       DSCCEX
DSCRMN
        CLHI    R0,DSCRND
        JG      DSCRHX
:
        LHI     R1,HEXB.3
        SVC     KIO,$A10
:
        LIS     R7,7
        MHR     R7,R0           :GENERATE OFFSET
        LA      R6,,R7,,        :AND INDEX
        SVC     0B,DSCRCV,R6,   :OUTPUT APPROPRIATE MESSAGE
DSCCEX
        SVC     0B,CRLF,,
:
:
:****************************************************************
: NOTE:  04/28/86, KJL, CHANGED BUMP INDEX FROM 4 TO 2, AND ADDED
:                OTHER PATCH TO SUPPRESS INSERTION OF PROCESSING ADDR
:                IN THE TRACE TABLE.  THE CODE WAS NOT CONSISTENTLY
:                INSERTING IT, CAUSING THE SCOPE TO GET OUT OF SYNC AND
:                SKIP PART OF THE TRACE.
:****************************************************************
        AIS     R13,2           :BUMP INDEX
        CLHI    R13,PTPTSW^0A    :CHECK FOR WRAP
        JLFS    DSCCK1
:
        LIS     R13,0
DSCCK1
        STH     R13,DSCIND,,     :STORE UPDATE
        JR      R14             :RETURN

CONPATCH(PA0PTR,,0FB)

DSCHDR  SC      /XOP XMNE  ROP RMNE/
DSCUDF  SC      / .... /        :UNDEFINED MESSAGE
:
:  MNEMONICS
:
:  RECEIVE STATES
:
DSCRCV
        SC      / ETX  /  :0  GOOD DATA ETX
        SC      / ETB  /  :1  GOOD DATA ETB
        SC      / ENQ  /  :2  ENQ
        SC      / EOT  /  :3  EOT
        SC      / NAK  /  :4  NAK
        SC      / DISC /  :5  DLE/EOT
        SC      / ACK1 /  :6  DLE/p
        SC      / WACK /  :7  DLE/COMMA
        SC      / ACK0 /  :8  DLE/70
        SC      / RVI  /  :9  DLE/@
        SC      / TTD  /  :0A STX/ENQ
        SC      / MBID /  :0B SOH/ENQ
        SC      / ABRT /  :0C ENQ,EOT,NAK IN TEXT
        SC      / LSYN /  :0D LOST SYNC
        SC      / ORUN /  :0E OVERRUN
        SC      / NBUF /  :0F NO INITIAL BUFFERLET
        SC      / RTIM /  :10 TIMEOUT BEFORE MSG RCV
        SC      / CRC  /  :11 CRC ERROR
        SC      / LOST /  :12 LOST DATA (BUFFERLET UNAVAILABLE)
        SC      / UNKN /  :13 UNKNOWN
        SC      / FCOM /  :14 FORCED RCV COMPLETION
DSCRND  EQ      14      :LAST RCV OP CODE

:
:  TRANSMIT STATE
:
DSCXMT
        SC      / DATA /  :0  DATA
        SC      / ENQ  /  :1  ENQ
        SC      / EOT  /  :2  EOT
        SC      / NAK  /  :3  NAK
        SC      / TTD  /  :4  TTD
        SC      / ACK1 /  :5  DLE/70
        SC      / WACK /  :6  DLE/,
        SC      / ACK0 /  :7  DLE/P
        SC      / RVI  /  :8  DLE/@
        SC      / DISC /  :9  DLE/EOT
        SC      / MBID /  :0A SOH/ENQ
DSCXND  EQ      $A10    :LAST XMIT OP CODE

:        FO      BSCPTP
:        EM
	EI	:PTPTSW		:FOR THE SCOPE TRACE COMMAND

:****************************************************************


:****************************************************************
:
: CRASH TABLE DISPLAY EXTENDED DDT ROUTINE.
: COMPATIBLE WITH BOTH OLD AND NEW CRASH LIBRARIES.
:
:****************************************************************
:

CONPAT(PA0PTR,,0B8)
:************************************************************
:	string texts
:************************************************************
T.CFRM	SC	/"8A"8DCRASH CALLED FROM:  /
T.CPNT	SC	/"8A"8DCRASH POINT:        /
T.CCODE	SC	/"8A"8DCRASH CODE:         /
T.CCNT	SC	/"8A"8DCRASH COUNT:        /
T.CREG	SC	/"8A"8D"8AREGISTER CONTENTS:"8A"8D/
T.CNOT	SC	/"8A"8DCRASH COUNT INDICATES THE SLOT HAS NOT CRASHED."8A"8D/
T.EQUAL	SC	/  =  /
T.REG	SC	/"8A"8DR /
T.COLON	SC	/:  /


	IF	\CRTIME		:IF CRTIME IS DEFINED, TO TIMESTAMP DISPLAY
	CONPAT(PA0PTR,,26)
T.CTIM	SC	/"8A"8DCRASH TIME:         /
T.NAVL	SC	/NOT AVAILABLE/

	CONPAT(PA0PTR,,11)
T.DATE	BC	10			:LENGTH
T.TIME	BS	10			:followed by 16d characters
	EI	:\CRTIME

	CONPAT(PA1PTR,,92)	:7C
:MAKE SURE THAT "EXCRSH" IS DEFINED.  IF UNDEFINED, SET TO ZERO.
:EXCRSH=0 IS OLD CRASH LIB, =1 IS NEW EXTENDED CRASH LIB.
	IF	\EXCRSH
	ELSE
EXCRSH	EQ	0		:IF EXCRSH UNDEF, SET IT TO 0=NO EXTD CRSH
	EI

:NOW DEFINE OFFSETS FROM START OF CRASH TABLE, FOR THE VARIOUS FIELDS.
 GL C.CNT,C.CODE,C.PNT,C.FROM,C.REG,C.SIZE,C.TIME,C.LEN
	IF	CRAT-CRSHCT	:NEW CRASH LIB HAS CRSHCT=0
C.CNT	EQ	CRSHCT		:CRASH COUNT
C.CODE	EQ	CRASHC		:CRASH CODE
C.PNT	EQ	CPOINT		:CRASH POINT, WHERE THE CRASH OCCURRED
C.FROM	EQ	CFROM		:WHERE CRASH WAS CALLED FROM
C.REG	EQ	C.FROM+4	:REGISTER STORAGE 
C.SIZE	EQ	CRTIME		:LENGTH OF CRASH TABLE WITHOUT CRTIME 
C.TIME	EQ	CRTIME		:STORED TIMESTAMP IN CRASH TABLE
C.LEN	EQ	C.SIZE+4	:LENGTH OF CRASH TABLE WITH CRTIME
				:(CRXREG, CRTSIZ, CRTLEN NOT GLOBALIZED)
	ELSE			:OLD CRASH LIB HAS CRAT=CRSHCT
C.CNT	EQ	CRSHCT-CRAT	:CRASH COUNT
C.CODE	EQ	CRASHC-CRAT	:CRASH CODE
C.PNT	EQ	CPOINT-CRAT	:CRASH POINT, WHERE THE CRASH OCCURRED
C.FROM	EQ	CFROM-CRAT	:WHERE CRASH WAS CALLED FROM
C.REG	EQ	CRREG-CRAT	:REGISTER STORAGE
C.SIZE	EQ	$0 4C		:LENGTH OF CRASH TABLE WITHOUT CRTIME
C.TIME	EQ	C.SIZE		:STORED TIMESTAMP IN CRASH TABLE
C.LEN	EQ	C.SIZE		:LENGTH OF CRASH TABLE WITH CRTIME
	EI			:NEW OR OLD CRASH LIB

:
:	CRASH - Crash information
:************************************************************
:	CRSH.R - Prints information about the last crash.  This 
:	includes crash time, crash point, crash code, crash
:       called from and crash registers.
:************************************************************

	DS.CMD(CRAS,CRSH00)		: Print info about crashes
:	DS.CMD(CRASH,CRSH00)		: Print info about crashes
	DS.CMD(CRAT,CRSH00)		: allow CRAT as well as CRAS for name

	LO	CRASH
CRSH00
	LIS	R8,0
	LIS	R7,0
CRSH10	AIS	R7,1			:counterfor # crashes displayed
	PRINT3(CRLF)
	PRINT3(T.CCNT)			:display crash count
	LHL	R0,CRAT,R8		:get count
	DPRINT(8,.B!.H)			:display it
	SIS	R0,1
	JGFS	CRSH15			:continue processing if CRSHCT>1
	PRINT3(T.CNOT)			:else, print that we are done
	J	CRSH40			:stop here if only one crash

CRSH15	PRINT3(T.CCODE)			:display crash code
	LHL	R0,CRAT+C.CODE,R8
	DPRINT(8,.B!.H)

CRSH20	PRINT3(T.CPNT)			:display crash point
	L	R0,CRAT+C.PNT,R8
	DPRINT(8,.Z!.H)

	PRINT3(T.CFRM)
	L	R0,CRAT+C.FROM,R8		:display crash from
	DPRINT(8,.Z!.H)


	IF	\CRTIME		:IF NEW CRASH LIB, WITH TIME FIELD DEFINED
CONPAT(PA1PTR,,40)
	PRINT3(T.CTIM)			:display time in GMT of last crash
	L	R3,CRAT+C.TIME,R8	:SEE IF CRASH TABLE HAS CRASH TIME
	JGFS	CRSH23
	L	R3,CTIME		:IF ZERO, SEE IF CTIME HAS IT
	JGFS	CRSH23
	PRINT3(T.NAVL)			:not avail if zero or neg
	J	CRSH24
CRSH23
	LR	R0,R3			:DISPLAY TIME.  MOVE INTO R0
	DPRINT(8,.Z!.H)			:PRINT THE NUMBER
	PRINT3(T.EQUAL)			:PRINT " = ".
	LHI	R4,10			:GO GET THE INTERPRETATION
	LA	R5,T.TIME,,
	JAL	R6,GMTTIM		:convert time to character string
	PRINT3(T.DATE)			:print it
	EI	:\CRTIME

CONPAT(PA1PTR,,3C)
CRSH24	PRINT3(T.CREG)			:display registers at time of crash
	LIS	R2,0
	LIS	R3,0
CRSH25
	PRINT3(T.REG)			:PRINT HEADER TO THIS REGISTER
	LR	R0,R3
	DPRINT(2,.B!.D)			:REG #, BLANK FILL, DECIMAL, 2 DIGITS
	PRINT3(T.COLON)			:PUT IN COLON BEFORE THE REG CONTENT
	L	R0,CRAT+C.REG,R2,R8	:get register
	DPRINT(8,.Z!.H)			:and display it
	AIS	R2,4
	CHI	R2,$040			:are we done
	JGEFS	CRSH30			:if yes, jump
	AIS	R3,1			:UPDATE THIS REGISTER NUMBER
	J	CRSH25			:and do next


	IF	EXCRSH		:EXTENDED CRASH HAS MORE THAN ONE TABLE
CONPAT(PA1PTR,,18)
CRSH30
: DISPLAY ADDITIONAL SAVED TABLES
	LHI	R1,NCRSAV		:HOW MANY TABLES SAVED?
	CR	R7,R1
CRSH40	JE	DSTART
:DISPLAY NEXT TABLE
	AI	R8,C.LEN		:GO GET NEXT TABLE
	J	CRSH10	

	ELSE	:EXCRSH
CONPAT(PA1PTR,,4)
CRSH30
CRSH40	J	DSTART
	EI	:EXCRSH

:	SEG	1
	FO	CRASH

	IF	\CRTIME		:IF STMT EXTENDS TO END OF GMT300 ROUTINE
CONPAT(PA0PTR,,6C)
:	SEG	A.CODE
:
:T.DECM	XC	0001020304050607080910111213141516171819202122232425262728293031
T.SECD	WC	$A24*$A60*$A60	:SECONDS IN A DAY
T.TENH	WC	$A10*$A60*$A60	:TENS OF HOURS
T.HOUR	HC	$A60*$A60	:HOURS
T.TENM	HC	$A10*$A60	:TENS OF MINS
T.MIN	HC	$A60		:MIN
T.TENS	HC	$A10		:TENS OF SECS
  IF	\TIMZON
T.S745	WC	$A24*$A60*$A60*$A365*2-TIMZON*$A60*$A60
			:SECONDS IN 74 & 75 PLUS TIME-ZONE CORRECTION
  ELSE
T.S745	WC	$A24*$A60*$A60*$A365*2	:SECONDS IN 74 AND 75
  EI
T.W365	WC	$A365
T.W366	WC	$A366
T.QUAD	WC	4*$A365+1
T.LPYR	BC	$A31,$A29,$A31,$A30,$A31,$A30,$A31,$A31,$A30,$A31,$A30,$A31
T.YEAR	BC	$A31,$A28,$A31,$A30,$A31,$A30,$A31,$A31,$A30,$A31,$A30,$A31
	WS	0
T.MNTH	AC	/ Jan/
	AC	/ Feb/
	AC	/ Mar/
	AC	/ Apr/
	AC	/ May/
	AC	/ Jun/
	AC	/ Jul/
	AC	/ Aug/
	AC	/ Sep/
	AC	/ Oct/
	AC	/ Nov/
	AC	/ Dec/

:	SUBTTL	Data Conversion Routines

:	These routines were taken from (isis2)convrt.lib and then
:	modified for use in the COM.

	RA	0

:*****************************************************************
:
:	BINDEC IS A ROUTINE TO CONVERT INTERNAL BINARY REPRESENTATION OF
:	DATA TO ASCII DECIMAL CHARACTERS.
:
:	ARGUMENTS: R9 CONTAINS THE BINARY NUMBER
:	           R10 CONTAINS NUMBER OF DIGITS OF OUTPUT
:	           R11 POINTS TO OUTPUT AREA
:	LINK ON R4
:
:****************************************************************
:
	CONPAT(PA0PTR,,20)
:	SEG	A.DATA
:
BIND00	HS	10	:REGISTER SAVE AREA
:

	CONPAT(PA0PTR,,10)
:	SEG	A.CODE
:
BIND01	AC	/0123456789ABCDEF/
:

	CONPAT(PA1PTR,,42)
:	FIRST CHECK FOR A NEGATIVE NUMBER
:		IF FOUND, PUT A LEADING '-' (MINUS SIGN) IN FIELD
BINDEC	STM	R8,BIND00,,	:PRESERVE REGISTERS
	LR	R9,R9		: TEST FOR NEGATIVE NUMBER
	JGEFS	BIND10		:JUMP IF NOT NEGATIVE
	LHI	R12,$0 00AD	:'ASCII '-'
	STB	R12,0,R11
	SIS	R10,1		: ROOM FOR ONE LESS DIGIT
	AIS	R11,1		: DITTO
	JLE	BIND30		:NO ROOM FOR DIGIT AFTER MINUS SINE
:	COMPLEMENT THE NUMBER TO POSITIVE
	XI	R9,-1
	AIS	R9,1
BIND10	SIS	R11,1
	LIS	R12,$A 10	: DIVISOR
BIND20	SR	R8,R8		: CLEAR HI ORDER BITS OF DIVIDEND
	DR	R8,R12		:GET LOW DIGIT IN R9
	LB	R13,BIND01,R8,	:GET ASCII EQUIVALENT OF DEC NUMBER
	STB	R13,0,R10,R11	:STORE IN REVERSE ORDER
	SIS	R10,1		:DECREMENT COUNTER
	JGBS	BIND20		: KEEP LOOPING
BIND30	LM	R8,BIND00,,	:RESTORE THE REGISTERS
	JR	R4		:AND RETURN


:	SUBTTL	GMT Clock Conversion Routines

:	These routines were taken from (isis2)datime.lib and then
:	modified for use in the COM.


:
:***************************************************************
:
:	THIS PROCEDURE CONVERTS THE GMT CLOCK
:	RELATIVE TO 1/1/74 FROM SECONDS TO
:	DDMMMYY HH:MM (GMT) OR
:	DDMMMYY HH:MM:SS (GMT)
:
:	PARMS
:		R3 = # OF SECONDS SINCE 1/1/74 (BEYOND1/1/76)
:		R4 = CHARACTERS OF OUTPUT (13 OR 16)
:		R5 = ADDRESS OF OUTPUT STRING
:		R6 = LINK REGISTER
:	ALL REGISTERS ARE PRESERVED
:
:**************************************************************
:
	CONPAT(PA0PTR,,40)
:	SEG	A.DATA
:
GMT000	HS	$020	:REGISTER SAVE AREA
:
	CONPAT(PA1PTR,,0AE)
:	SEG	A.CODE
GMTTIM	STM	R0,GMT000,,	:PRESERVE THE REGISTERS
	S	R3,T.S745,,	
:	MAKE TIME RELATIVE TO 1/1/76 - THE START OF
:	A 'QUAD-YEAR'.  'QUAD-YEAR' = 1 LEAP
:	YEAR + 3 REGULAR YEARS.  THERE ARE
:	24 QUADS PLUS 4 REG YEARS IN A CENTURY
:
	SR	R2,R2		:CLEAR HI ORDER BYTES FOR FULLWORD DIVIDE
	D	R2,T.SECD,,	:QUOTIENT (R3) IS # OF DAYS SINCE 1/1/76.
:				:REMAINDER (R2) IS TIME IN THE LAST DAY
	LR	R14,R2		:COPY TIME OF DAY. R14=#SEC IN THIS LAST DAY
	SR	R2,R2		:CLEAR HI ORDER BYTES
	D	R2,T.QUAD,,	:DIVIDE BY DAYS IN A QUAD
:
:	QUOTIENT(R3) IS NUMB. OF QUAD YEARS
:	REMAINDER(R2) IS # OF DAYS INTO QUAD-YEAR
:
	LHI	R8,$A76		:BASE YEAR = 1976.
	SLLS	R3,2		:QUAD YEAR * 4
	AR	R8,R3		:ADD TO BASE YEAR. R8=YEAR OF START OF QUAD
	LA	R7,T.LPYR,,	:POINT TO DAYS IN MONTH, FOR A LEAP YEAR
	C	R2,T.W366,,	:IS IT IN CURRENT YEAR?
	JL	GMT100		:JUMP IF SO
	S	R2,T.W366,,	:SUB DAYS IN LEAP YEAR, 1ST YR OF THE QUAD
	AIS	R8,1		:ADD 1 TO YEAR
	LR	R11,R2		:GET REMAIN DAYS IN QUAD
	SR	R10,R10
	D	R10,T.W365,,	:AND DIVIDE BY REGYEAR
:	R11 HAS ADDTL YEARS
:	R10 HAS DAYS IN YEAR
	LR	R2,R10
	AR	R8,R11		:R8 NOW HAS # YEARS.
	LI	R7,T.YEAR	:POINT TO DAYS IN MONTH, FOR REGULAR YEAR
:
:	DAYS IN R2
:	YEAR IN R8
:	REMAINDER OF SECONDS IN THIS DAY IN R14
:
GMT100	SR	R6,R6		:MONTH COUNTER
	AIS	R2,1		:MAKE 1/1/76 = DAY 1
GMT110	LR	R9,R2		:SAVE DAYS
	LB	R3,0,R6,R7	:GET DAYS IN MONTH
	SR	R2,R3		:AND SUBTRACT FROM DAYS IN YEAR
	JLEFS	GMT200		:IF MINUS OR ZERO WE'RE IN THE MONTH
	AIS	R6,1		:INCREMENT INDEX
	JBS	GMT110
:
:	DAYS IN R3
:	MONTH NUMBER - 1 IN R6
:	YEAR IN R8
:	REMAINDER OF SECONDS IN THIS DAY IN R14
:
:	SAVE R4 AND R5
GMT200	SIS	R4,$A8		:SUBTRACT OUT DATE LENGTH
	LR	R13,R4		:PRESERVE IT
	LR	R11,R5		:COPY OUPUT AREA POINTER
:
:	CONVERT DAY
	LIS	R10,2		:# OF OUTPUT CHARACTERS
	JAL	R4,BINDEC	:CONVERT TO DECIMAL ASCII
:
:	MOVE IN MONTH
	AIS	R11,2
	SLHLS	R6,2		:MULTIPLY MONTH NUMBER BY 4
	L	R4,T.MNTH,R6,	:GET THE NAME IN R4
	STB	R4,2,R11
	SRLS	R4,$A8
	STB	R4,1,R11
	SRLS	R4,$A8
	STB	R4,0,R11
	AIS	R11,3
:
:	CONVERT YEAR
	LR	R9,R8
	LIS	R10,2
	JAL	R4,BINDEC	:CONVERT TO CHARACTERS
	LHI	R3,$00A0	:ASCII SPACE
	STB	R3,2,R11	:PUT IT AFTER DATE
	LHI	R5,3,R11	:SET UP OUTPUT POINTER
	LR	R4,R13		:COPY LENGTH ARGUEMENT
	LR	R3,R14		:COPY TIME OF DAY
	JFS	GMT350		:JUMP
:*************************************************************
:
:	GET THE TIME STAMP
:
:	TIME STAMP ROUTINE
:		THIS ROUTINE CONVERTS THE FULLWORD GMT TIME OF DAY
:	TO HH:MM OR HH:MM:SS
:
:	PARAMETERS:
:		R3 = FULLWORD TIME OF DAY (GMT CLOCK)
:		R4 = 5 OR 8 (# OF CHARACTERS TO OUTPUT)
:		R5 = FULLWORD ADDRESS OF OUTPUT
:		R6 = LINK REGISTER
:
:	DIVIDE TIME BY SECONDS PER DAY.  THE REMAINDER
:	IS THE SECONDS IN THIS DAY, WHICH IS WHAT THIS
:	ROUTINE IS ALL ABOUT
:
:****************************************************************
GMT300	STM	R0,GMT000,,	:PRESERVE THE REGISTERS

  IF \TIMZON
	CONPAT(PA1PTR,,4)
	AHI	R3,TIMZON*$A3600	:TIME ZONE CONVERSION
  EI

	CONPAT(PA1PTR,,72)
GMT350	SR	R8,R8		:INDEX FOR OUTPUT AREA
:
	SR	R2,R2		:CLEAR HI-ORDER BITS
	D	R2,T.SECD,,
:		SECONDS NOW IN R2
	LR	R3,R2		:GET READY FOR
	SR	R2,R2		:ANOTHER DIVIDE
	D	R2,T.TENH,,	:GET TENS OF HOURS
	JAL	R6,GMT400	:PRINT IT OUT IN ASCII
	DH	R2,T.HOUR,,	:GET HOURS
:		R2 HAS REMAINDER, R3 HAS QUOTIENT
	JAL	R6,GMT400	:PRINT IT OUT
	LHI	R3,$00BA	:COLON
	JAL	R6,GMT410
	DH	R2,T.TENM,,	:DETERMINE # OF TENS OF MINUTES
	JAL	R6,GMT400
	DH	R2,T.MIN,,	:DETERMINE # OF MINUTES
	JAL	R6,GMT400
:	THE CONDITION CODE HAS BEEN SET -
:	SET IF ANY MORE CHARACTER WANTED
	JE	GMT380		:JUMP IF ONLY 5 CHAR
:
:	PUT IN COLON BEFORE SECONDS
	LHI	R3,$00BA
	JAL	R6,GMT410
	DH	R2,T.TENS,,	:DETERMINE # TENS OF SECONDS
	JAL	R6,GMT400
	LR	R3,R2		:GET SECONDS IN R3
	JAL	R6,GMT400
GMT380	LM	R0,GMT000,,	:RESTORE THE REGISTERS
	JR	R6		:RETURN
:
:
GMT400	AHI	R3,$00B0
GMT410	STB	R3,0,R8,R5
	AIS	R8,1	: UPDATE INDEX
	SIS	R4,1
	JR	R6


	RA	0	:RADIX TO HEX

	EI	:\CRTIME


ENDPATCH(PATCH TO MAKE ?STAT ROUTINES AVAILABLE TO 3270 HOST INTERFACE)


 REMARK %(MINIMUM P0SIZE IS ; NUMBER $0PA0PTR-PATCH0+10
 REMARK  BYTES, HEXADECIMAL.)%
 REMARK %(CURRENT P0SIZE IS ; NUMBER $0P0SIZE
 REMARK  BYTES, HEXADECIMAL.)%

 REMARK %(MINIMUM P1SIZE IS ; NUMBER $0PA1PTR-PATCH1+10
 REMARK  BYTES, HEXADECIMAL.)%
 REMARK %(CURRENT P1SIZE IS ; NUMBER $0P1SIZE
 REMARK  BYTES, HEXADECIMAL.)%

 REMARK %(MINIMUM PHSIZE IS ; NUMBER $0PAHPTR-PATHIS
 REMARK  BYTES, HEXADECIMAL.)%
 REMARK %(CURRENT PHSIZE IS ; NUMBER $0PHSIZE
 REMARK  BYTES, HEXADECIMAL.)%

 LIST

	UN	:HAVE ASSEMBLER DISPLAY UNDEFINED SYMBOLS.
    }K