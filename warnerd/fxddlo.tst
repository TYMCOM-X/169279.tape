:---------------------------------------------------------------------
: Patch name:  FXDDLO                Product and Version:  BBXS 6.01
:     Author:  BOBO KRUEGER                 Organization:  NTD
:   Customer:  CHASE                        Date Written:  860625
: Description of Problem:  PREVENT RJE DEADLOCK
:
:---------------------------------------------------------------------

:MODIFIED BY: Phil Sneddon - 07/07/88
: The patch will now pass NAK's and WACK's which are in response to ENQ's
: end-to-end.  If the circuit is backpressured it will buffer HLNMEQ
: NAK's or WACK's and throw the rest away.

:MODIFIED BY: Phil Sneddon - 06/06/88
: The patch will now buffer only HLNMEQ ENQ's when the interface is in a
: backpressured state, this should prevent the "out of buffers" crash.
: It will also queue only HLNMEQ ENQ's to the foreground when a large
: number of ENQ's are received all at once from the network.

:MODIFIED BY: Phil Sneddon - 05/01/89
: The patch will now queue only HLNMEQ end-to-end-ENQ-ACK's to the
: background and will queue only HLNMEQ to foreground, regardless of
: the number received in the IRING.

:MODIFIED BY: Phil Sneddon - 08/21/89
: The patch will now only queue HLNMEQ end-to-end EOT's to background
: and will queue only HLNMEQ to foreground, the rest will be discarded.
 
:MODIFIED BY: Phil Sneddon - 11/20/89
:             Since end-to-end EOTs are also used without remote bidding
:             I added a check to see if the line supports remote bidding
:             before counting the EOT.
 
:MODIFIED BY: Phil Sneddon - 12/06/89
:             Added check to prevent EOT counter incrementing if E-T-E
:             EOTs not genned for that line (BSCEOT)

:************************************************************************
: This patch presents a solution to PIR 2222 (DuPont BETX Deadlock).
: Rather than detecting deadlock and trying to resolve it, the approach of
: preventing deadlock was selected. As such it will prevent deadlock
: for all cases, not only for the DuPont situation with both interfaces
: sysgened with the BETX option.
: Deadlock is prevented by bidding for the line end-to-end.
: During the bidding phase ENQ, ACK0, NAK and WACK are sent end-to-end.

: MODIFIED BY: Phil Sneddon  06/02/88
:              The patch will now buffer up no more than 10x end-to-end
:              ENQ's.  This is to prevent the out-of-buffer crash.

HLNMEQ  EQ      0A                    :PS 06/07/88 # OF ENQ'S TO BUFFER
	LO	FCB
	LO	IDS

	PATCH(860625,1416,NTD.B/KRUEGER,PA1PTR,,2*((NBILIN-1)/10+1))

:	Insert into LINE module

	KILL	DEFBTA

:	THIS MACRO IS USED TO DEFINE SYSGENED BIT ARRAYS.  THE FIRST ARGUMENT
:	IS THE NAME OF THE ARRAY, THE SECOND ARGUMENT IS USED TO TEST WHETHER
:	A LINE PARAMETER WAS SPECIFIED FOR THIS OPTION AND THE THIRD ARGUMENT
:	IS THE VALUE FROM WHICH THE VALUE OF THE BIT WILL BE EXTRACTED (BY
:	"ANDING" IT WITH A ONE).  THE NEXT TWO ARGUMENTS PERFORM THE SAME
:	FUNCTION AS THE SECOND AND THIRD EXCEPT THEY ARE ONLY USED IF THE
:	TEST FOR THE SPECIFICATION OF THE SECOND ARGUMENT FAILS.  THE SIXTH
:	ARGUMENT SPECIFIES THE DEFAULT VALUE TO BE USED IF BOTH TEST1 AND 
:	TEST2 FAIL.  THE SEVENTH ARGUMENT WILL BE DEFINED AND EQUATED TO ONE
:	IF ANY OF THE BITS IN THE ARRAY ARE SET TO ONE.  THE FOURTH THROUGH
:	SEVENTH ARGUMENTS ARE OPTIONAL EXCEPT THAT THE FIFTH ARGUMENT MUST
:	BE SPECIFIED IF THE FOURTH IS.

DEFBTA	MACRO(BTANAM,TEST1,VALUE1,TEST2,VALUE2,DEFALT,ENABLE)
	[	NOLIST
	IFARG(ENABLE,ARG7ON)
BTANAM	HS	0
Q	EQ	0
QQ	EQ	0
	IF	ARG7ON
ENABLE	EQ	0
	EI	(ARG7ON)
	RE	NBILIN
QQ	EQ	$A QQ!((DEFALT+0)&1)^(15-(Q&15))
	IF	TEST1
QQ	EQ	$A (QQ&@(1^(15-(Q&15))))!(VALUE1&1)^(15-(Q&15))
	ELSE
	IF	TEST2 0
QQ	EQ	$A (QQ&@(1^(15-(Q&15))))!(VALUE2&1)^(15-(Q&15))
	EI	(TEST2)
	EI	(TEST1)
Q	EQ	Q+1
	IF	$A Q&15
	ELSE
	HC	QQ
	IF	ARG7ON
	IF	QQ
	GL	ENABLE
ENABLE	EQ	1
	EI	(QQ)
	EI	(ARG7ON)
QQ	EQ	0
	EI
	ER
	IF	$A Q&15
	HC	QQ
	IF	ARG7ON
	IF	QQ
	GL	ENABLE
ENABLE	EQ	1
	EI	(QQ)
	EI	(ARG7ON)
	EI
	LIST
	]

:BSCRBD
:	THIS IS A BIT ARRAY INDEXED BY LINE. A SET BIT INDICATES THAT
:	THE REMOTE BID FEATURE IS ENABLED FOR THIS LINE. DURING BIDDING
:	ENQ, ACK0, NAK AND WACK ARE SENT END-TO-END TO PREVENT DEADLOCK
:	WHICH MAY OCCUR IF BOTH ENDS ARE BIDDING SIMULTANEOUSLY AND
:	BOTH ARE GIVEN CONTROL OF THE LINE BY THE LOCAL INTERFACE.

	DEFBTA(BSCRBD,\BRBD|Q|,BRBD|Q|,,,,BRBD)

	IF	BRBD

NRBID   EQ      0                     :PS07/07/88
Q       EQ      0                     :PS07/07/88
QQ      EQ      8000                  :PS07/07/88
        RE      NBILIN                :PS 07/07/88
        IF      \BNBR|Q|              :PS 07/07/88
        IF      BNBR|Q|               :PS 07/07/88
NRBID   EQ      NRBID+QQ              :PS 07/07/88
        EI                            :PS 07/07/88
        EI                            :PS 07/07/88
Q       EQ      Q+1                   :PS 07/07/88
QQ      EQ      QQ^-1                 :PS 07/07/88
        ER                            :PS 07/07/88
        CONPATCH(PA0PTR,,NBILIN*14+2+(NBILIN-1)/10+1)  :DW 12/19/89
NBRBID  HC      NRBID                 :PS 07/07/88
CNTNAK  HS      NBILIN                :PS 07/07/88
CNTNIK  HS      NBILIN                :PS 07/07/88
CNTWAK  HS      NBILIN                :PS 07/07/88
CNTWIK  HS      NBILIN                :PS 07/07/88
CNTENQ  HS      NBILIN                :PS 06/02/88
CNTINQ  HS      NBILIN                :PS 06/07/88
CNTACK  HS      NBILIN                :PS 05/01/89
CNTICK  HS      NBILIN                :PS 05/01/89
CNTEOT  HS      NBILIN                :PS 08/21/89
CNTIOT  HS      NBILIN                :PS 08/21/89 (FROM NETWORK)
FORABR  HS      (NBILIN-1)/10+1         :DW 12/19/89 CTRMSG ARRAY


	CONPATCH(PA1PTR,,0A)
Q	EQ	.
	ORG	MAXSCF+2
:	Insert into IDS table before MAXSCF
IDX.SCF HS      1               :CONTROL MESSAGE FOR FORWARD ABORT
IDE.SCF	HS	1		:END-TO-END ENQ
IDK.SCF	HS	1		:END-TO-END ACK0
IDG.SCF	HS	1		:END-TO-END NAK
IDW.SCF	HS	1		:END-TO-END WACK
MAXSCF	EQ	.-2
	ORG	Q


:	Insert after FSTCTL in FCB
:	For this patch just define new values, don't change FSTCTL
FORMSG  EQ      90      :CONTROL FOR FORWARD ABORT
ENQMSG	EQ	91	:END-TO-END ENQ 
AK0MSG	EQ	92	:END-TO-END ACK0
NAKMSG	EQ	93	:END-TO-END NAK
WAKMSG	EQ	94	:END-TO-END WAK


:	Insert after FFPIN in BSCMAC
FFFORW  EQ      @FORMSG                 : FORWARD ABORT
FFENQ	EQ	@ENQMSG			:END-TO-END ENQ
FFACK0	EQ	@AK0MSG			:END-TO-END ACK0
FFNAK	EQ	@NAKMSG			:END-TO-END NAK
FFWACK	EQ	@WAKMSG			:END-TO-END WACK

	LO	IR100

        CONPATCH(EOR03+14,,6)         :PS 08/21/89 INTERCEPT EOT FROM NETWORK
        J     PFS888,,
        CONPATCH(PA1PTR,,42)
PFS888  CLHI  R2,12                   :PS 08/21/89 (EOT?)
        JN    EOR03+1C,,              :PS 08/21/89 (NO, BACK TO MAIN FLOW)
        LHI   R0,EOTMSG               :PS 08/21/89 (RESTORE ORIGINAL INSTRUCT)
        LHL   R1,F.ABBO,R8,           :PS 08/21/89 (RESTORE ORIGINAL INSTRUCT)
        JNR   R9                      :PS 08/21/89 (RESTORE ORIGINAL INSTRUCT)
        LB    R5,F.LINE,R8,           :PS 08/21/89 (GET LINE NUMBER)
        TBT   R5,BSCRBD,,             :PS 11/20/89 (REMOTE BIDDING ENABLED?)
        JE    IR1ET1,,                :PS 11/20/89 (NO, PROCESS THIS EOT)
        LHI   R3,HLNMEQ               :PS 08/21/89
        CH    R3,CNTIOT,R5,R5         :PS 08/21/89 (NEED TO QUEUE ANOTHER?)
        JLR   R9                      :PS 08/21/89 (NO)
        LIS   R3,1                    :PS 08/21/89
        AHM   R3,CNTIOT,R5,R5         :PS 08/21/89
        J     IR1ET1,,                :PS 08/21/89

	CONPATCH(EOR03+54,,6)
	J	DLFIX1,,		:JUMP TO PATCH

	CONPATCH(PA1PTR,,36)
DLFIX1	HS	0
	CLHI	RDATA,IDE.SCF		:END-TO-END ENQ?
	JE	IR1ENQ			:YES--SKIP
	CLHI	RDATA,IDK.SCF		:END-TO-END ACK0?
	JE	IR1AK0			:YES--SKIP
	CLHI	RDATA,IDG.SCF		:END-TO-END NAK?
	JE	IR1NAK			:YES--SKIP
	CLHI	RDATA,IDW.SCF		:END-TO-END WACK?
	JE	IR1WAK			:YES--SKIP
        CLHI    RDATA,IDX.SCF           :FORWARD ABORT?
        JE      FORWD,,                 :
	CLHI	RDATA,LSTSCF
	JGR	RLINK
	J	EOR03+5A,,

	CONPATCH(PA1PTR,,0AC)

:	FOUND END-TO-END ENQ : IR1ENQ
:	-----------------------------
IR1ENQ	LHI	R0,ENQMSG		:QUEUE FOR FOREGROUND
        LB      R5,F.LINE,RAFCB,        :PS 06/07/88
        LHI     R3,HLNMEQ               :PS 06/07/88
        CH      R3,CNTINQ,R5,R5         :PS 06/07/88
        JL      IR1ET1+0C,,             :PS 06/07/88
        LIS     R3,1                    :PS 06/07/88
        AHM     R3,CNTINQ,R5,R5         :PS 06/07/88
	J	IR1ET1,,

:	FOUND END-TO-END ACK0 : IR1AK0
:	------------------------------
IR1AK0	LHI	R0,AK0MSG		:QUEUE FOR FOREGROUND
        LB      R5,F.LINE,RAFCB,        :PS 05/01/89
        LHI     R3,HLNMEQ               :PS 05/01/89
        CH      R3,CNTICK,R5,R5         :PS 05/01/89
        JL      IR1ET1+0C,R5,R5         :PS 05/01/89 DON'T QUEUE ANY MORE
        LIS     R3,1                    :PS 05/01/89 
        AHM     R3,CNTICK,R5,R5         :PS 05/01/89 INCREMENT COUNTER
	J	IR1ET1,,

:	FOUND END-TO-END NAK : IR1NAK
:	-----------------------------
IR1NAK	LHI	R0,NAKMSG		:QUEUE FOR FOREGROUND
        LHI     R3,HLNMEQ               :PS 07/07/88
        LB      R5,F.LINE,RAFCB,        :PS 07/07/88
        CH      R3,CNTNIK,R5,R5         :PS 07/07/88
        JL      IR1ET1+0C,,             :PS 07/07/88
        LIS     R3,1                    :PS 07/07/88
        AHM     R3,CNTNIK,R5,R5         :PS 07/07/88
	J	IR1ET1,,

:	FOUND END-TO-END WACK : IR1WAK
:	------------------------------
IR1WAK	LHI	R0,WAKMSG		:QUEUE FOR FOREGROUND
        LHI     R3,HLNMEQ               :PS 07/07/88
        LB      R5,F.LINE,RAFCB,        :PS 07/07/88
        CH      R3,CNTWIK,R5,R5         :PS 07/07/88
        JL      IR1ET1+0C,,             :PS 07/07/88
        LIS     R3,1                    :PS 07/07/88
        AHM     R3,CNTWIK,R5,R5         :PS 07/07/88
	J	IR1ET1,,

:       FOUND FORWARD ABORT  :  FORWD
:       ______________________________
FORWD   LA      R3,FORABR,,
        J       IR1PI1,,


	CONPATCH(GSCB+18,,4)		:>>>For patch only
	CLHI	RDATA,MAXSCF		:REASSEMBLE WITH NEW MAXSCF

	FO	IR100

	CONPATCH(PA1PTR,,14)

:	For source update add new jump table entries into R1BASE
:	control table for 2780/3780 native mode receiver.

DLTBL   WC      R1FOR                   : 90   FORWARD ABORT
     	WC	R1ENQ			: 91	END-TO-END ENQ
	WC	R1ACK0			: 92	END-TO-END ACK0
	WC	R1NAK			: 93	END-TO-END NAK
	WC	R1WACK			: 94	END-TO-END WACK
:
:	Insert the following routines into R100 under Activation Routines.

	LO	R100

        CONPATCH(R1EOT1+22,,6)        :PS 08/21/89 (SENDING EOTs TO NETWORK)
        J     R1EOT5,,                :PS 08/21/89
        CONPATCH(PA1PTR,,24)          :PS 08/21/89
R1EOT5  JAL   R4,ELODR,,              :PS 08/21/89 (RESTORE ORIGINAL INSTR)
        LB    R4,F.LINE,R8,           :PS 08/21/89 (GET LINE NUMBER)
        LCS   R5,1                    :PS 08/21/89
        AHM   R5,CNTEOT,R4,R4         :PS 08/21/89 (DECREMENT TO-NET COUNTER)
        JGEFS .+0A                    :PS 08/21/89 (DON'T LET IT GET NEGATIVE)
        LIS   R5,0                    :PS 08/21/89
        STH   R5,CNTEOT,R4,R4         :PS 08/21/89
        J     EOT1,,                  :PS 08/21/89

	CONPATCH(PA1PTR,,98)

:	END-TO-END ENQ : R1ENQ
:	----------------------
R1ENQ	LHI	R0,IDE.SCF/2+TBIAS
        LB      R4,F.LINE,RAFCB,      :PS 06/02/88 (GET THE LINE NUMBER)
        LCS     R5,1                  :PS 06/02/88
        AHM     R5,CNTENQ,R4,R4       :PS 06/02/88 (DECREMENT ENQ QUEUED CNT)
        JGEFS   .+0A                  :PS 06/02/88 (CHECK FOR NEGATIVE COUNT)
        LIS     R5,0
        STH     R5,CNTENQ,R4,R4       :PS 06/02/88 (ZERO OUT IF NEGATIVE)
	J	R1PIN1,,

:	END-TO-END ACK0 : R1ACK0
:	----------------------
R1ACK0	LHI	R0,IDK.SCF/2+TBIAS
        LB      R4,F.LINE,RAFCB,      :PS 05/01/89
        LCS     R5,1                  :PS 05/01/89
        AHM     R5,CNTACK,R4,R4       :PS 05/01/89
        JGEFS   .+0A                  :PS 05/01/89
        LIS     R5,0                  :PS 05/01/89
        STH     R5,CNTACK,R4,R4       :PS 05/01/89
	J	R1PIN1,,

:	END-TO-END NAK : R1NAK
:	----------------------
R1NAK	LHI	R0,IDG.SCF/2+TBIAS
        LB      R4,F.LINE,RAFCB,      :PS 07/07/88
        LCS     R5,1                  :PS 07/07/88
        AHM     R5,CNTNAK,R4,R4       :PS 07/07/88
        JGEFS   .+0A                  :PS 07/07/88
        LIS     R5,0                  :PS 07/07/88
        STH     R5,CNTNAK,R4,R4       :PS 07/07/88
	J	R1PIN1,,

:	END-TO-END WACK : R1WACK
:	----------------------
R1WACK	LHI	R0,IDW.SCF/2+TBIAS
        LB      R4,F.LINE,RAFCB,      :PS 07/07/88
        LCS     R5,1                  :PS 07/07/88
        AHM     R5,CNTWAK,R4,R4       :PS 07/07/88
        JGEFS   .+0A                  :PS 07/07/88
        LIS     R5,0                  :PS 07/07/88
        STH     R5,CNTWAK,R4,R4       :PS 07/07/88
	J	R1PIN1,,

:       FORWARD ABORT :  R1FOR
:       _______________________
R1FOR   LHI     R0,IDX.SCF/2+TBIAS
        LB      R4,F.LINE,RAFCB,
        J       R1PIN1,,


	FO	R100

:	The following code is special processing for the patch only.


	IF	DEBUG
	CONPATCH(RCVCTL+4,,6)
	J	DLFIX2,,

	CONPATCH(PA1PTR,,18)
DLFIX2	HS	0
	CLHI	RDATA,FSTCTL
	JG	RCVCTL+0A,,
	CLHI	RDATA,FSTCTL-5
	JL	RCVCT1,,		:JUMP IF INVALID MSG
	J	DLFIX5			:GO PROCESS NEW MESSAGES

	ELSE

	CONPATCH(RCVCTL+4,,6)
	J	DLFIX3,,

	CONPATCH(PA1PTR,,1C)
DLFIX3	HS	0
	CLHI	RDATA,FSTCTL
	JG	DLFIX4
	CLHI	RDATA,FSTCTL-5
	JGE	DLFIX5			:GO PROCESS NEW MESSAGES
DLFIX4
	SHI	RDATA,FSTCTL
	SLHLS	RDATA,1			:MAKE HALFWORD INDEX
	J	RCVCT0,,
	EI	(DEBUG)

	CONPATCH(PA1PTR,,12)
DLFIX5
	SHI	RDATA,FORMSG		:MAKE RELATIVE TO 1ST NEW MSG
	SLHLS	RDATA,2			:MAKE FULL WORD INDEX
	L	R4,DLTBL,RDATA		:GET ACTIVATION ADDRESS
	JALR	RLINK,R4		:ACTIVATE CONTROL ROUTINE
	J	RCVXIT,,

	FO	FCB
	FO	IDS

:**********************************************************************

:	The following macro is REDEFINED to use RX3 instructions for 
:	the patch.
:	(RX3 instructions may not be necessary for the source changes)


	LO	BSCPTP
	LO	BSCDEF
	LO	BSCHDX

	KILL	XOPCHK

:XOPCHK CHECK IF A XMT OPERATION IS PRESENT AND DECODE THE TYPE.
:------ AN OPERATION IS PRESENT IF FF.IP2 .NE. FF.IP3.  IF OP IS
:       PRESENT, CHAIN(FF.IP2) POINTS TO OPERATION.  1ST HW OF BB
:       FOR OPERATION IS TYPE.  IF OP IS DATA, R1 SET WITH XMT DATA
:       OP CODE.

XOPCHK	MACRO(.NONE,.DATA,.EOT,.ELSE)[
	XRGFCB(OFCB.X)			:R1 = XMT STREAM FCB
	LHL	R3,FF.IP2,R1,		:PREVIOUS OP BB
	LHL	R2,FF.IP3,R1,		:NEW OP'S LAST BB
	CR	R2,R3
	JE	.NONE,,			:OP NOT PRESENT EXIT

	LIS	R1,XCDATA		:PREPARE XMT DATA OP CODE
	LHL	R3,BBUFER+BBFLSZ-2,R3,	:GET OP BB
	LH	R2,BBUFER,R3,		:GET OP TYPE
	JG	.DATA,,			:DATA EXIT
	CHI	R2,FFEOT
	JE	.EOT,,			:EOT OP EXIT
	J	.ELSE,,			:NON-DATA EXIT]

:>>>>>>	THE FOLLOWING CODE BELONGS IN BSCPTP

	CONPATCH(PA0PTR,,4)
CTIENQ	HS	NBILIN			:INBOUND ENQ CONTENTION COUNTER	
CTOENQ	HS	NBILIN			:OUTBOUND ENQ CONTENTION COUNTER	

:>>>>>>	NOTE: FOR PATCH, IRESET WAS REPLACED BY IRESFX

	CONPATCH(SIDLE,SBID)

:       RESPONSE WHILE LINE IDLE : SIDLE
:       --------------------------------
:       THE LINE IS IN AN IDLE STATE AND WE ARE WAITING FOR THE REMOTE TO
:       BID OR BACKGROUND TO FORCE COMPLETION SIGNALLING THAT WE
:       HAVE DATA TO TRANSMIT.  NOTE THAT RECEPTION OF DATA STATES ARE
:       IMPOSSIBLE (THUS WE CRASH) SINCE RCV BUFFERLET LIMIT SPECIFIED AS 0.

SIDLE	HC	IERSET-PSEG		:GOOD DATA ETX BLOCK
	HC	IERSET-PSEG		:GOOD DATA ETB BLOCK
	HC	IENQ-PSEG		:ENQ
	HC	RIDEOT-PSEG		:EOT
	HC	IDLE-PSEG		:NAK
	HC	IDISC-PSEG		:DLE,EOT (DISCONNECT SIGNAL)
	HC	IRESFX-PSEG		:ACK1
	HC	IWACK-PSEG		:WACK
	HC	IACK0-PSEG		:ACK0
	HC	IRESFX-PSEG		:RVI
	HC	IERSET-PSEG		:TTD (STX,ENQ)
	HC	RMLVBD-PSEG		:MULTI-LEAVING BID (SOH,ENQ)
	HC	IERSET-PSEG		:DATA ABORT (ENQ,EOT,NAK IN TEXT)
	HC	RCVRTY-PSEG		:LOST SYNCHRONIZATION
	HC	IRESFX-PSEG		:OVERRUN (EXCEED RCV RESOURCE LIMIT)
	HC	IRESFX-PSEG		:NO INITIAL BUFFERLET AVAILABLE
	HC	IDLE-PSEG		:TIMEOUT BEFORE MSG RECEIVED
	HC	IERSET-PSEG		:CRC ERROR IN DATA MESSAGE
	HC	IERSET-PSEG		:LOST DATA (BUFFERLET UNAVAILABLE)
	HC	RCVRTY-PSEG		:UNIDENTIFIABLE MSG
	HC	IDLE-PSEG		:FORCED COMPLETION BY BACKGROUND


	CONPATCH(PA1PTR,,54)

:	RECEIVED END-TO-END BID FROM LOCAL DEVICE : SLBID
:	-------------------------------------------------
:	THIS STATE TABLE IS ACCESSED ONLY IF THE REMOTE BIDDING OPTION
:	'BRBD' IS SELECTED.
:	THE INTERFACE RECEIVED AN ENQ FROM THE LOCAL DEVICE, SENT IT
:	ACROSS THE NET AND IS WAITING FOR A RESPONSE FROM THE REMOTE
:	(DISTANT) DEVICE.

SLBID	HC	IERSET-PSEG		:GOOD DATA ETX BLOCK
	HC	IERSET-PSEG		:GOOD DATA ETB BLOCK
	HC	ILENQ-PSEG		:ENQ
	HC	RIEOT-PSEG		:EOT
	HC	IRESFX-PSEG		:NAK
	HC	IDISC-PSEG		:DLE,EOT (DISCONNECT SIGNAL)
	HC	IRESFX-PSEG		:ACK1
	HC	IRESFX-PSEG		:WACK
	HC	IRESFX-PSEG		:ACK0
	HC	IRESFX-PSEG		:RVI
	HC	IERSET-PSEG		:TTD (STX,ENQ)
	HC	RMLVBD-PSEG		:MULTI-LEAVING BID (SOH,ENQ)
	HC	IERSET-PSEG		:DATA ABORT (ENQ,EOT,NAK IN TEXT)
	HC	RCVRTY-PSEG		:LOST SYNCHRONIZATION
	HC	IRESFX-PSEG		:OVERRUN (EXCEED RCV RESOURCE LIMIT)
	HC	IRESFX-PSEG		:NO INITIAL BUFFERLET AVAILABLE
	HC	IDLE-PSEG		:TIMEOUT BEFORE MSG RECEIVED
	HC	IERSET-PSEG		:CRC ERROR IN DATA MESSAGE
	HC	IERSET-PSEG		:LOST DATA (BUFFERLET UNAVAILABLE)
	HC	RCVRTY-PSEG		:UNIDENTIFIABLE MSG
	HC	ILFRC-PSEG		:FORCED COMPLETION BY BACKGROUND


:	RECEIVED END-TO-END BID FROM REMOTE DEVICE : SRBID
:	--------------------------------------------------
:	THIS STATE IS ACCESSED ONLY IF THE REMOTE BIDDING OPTION
:	'BRBD' IS SELECTED.
:	THE INTERFACE RECEIVED AN ENQ FROM THE REMOTE (DISTANT) DEVICE,
:	TRANSMITTED IT TO THE LOCAL DEVICE AND IS NOW WAITING FOR A
:	RESPONSE FROM THE LOCAL DEVICE.

SRBID	HC	IERSET-PSEG		:GOOD DATA ETX BLOCK
	HC	IERSET-PSEG		:GOOD DATA ETB BLOCK
	HC	IRENQ-PSEG		:ENQ
	HC	RIEOT-PSEG		:EOT
        HC      IRENAK-PSEG             :NAK PS 07/07/88
	HC	IDISC-PSEG		:DLE,EOT (DIECT SIGNAL)
	HC	IRESFX-PSEG		:ACK1
        HC      IREWAK-PSEG             :WACK PS 07/07/88
	HC	IRACK0-PSEG		:ACK0
	HC	IRESFX-PSEG		:RVI
	HC	IERSET-PSEG		:TTD (STX,ENQ)
	HC	RMLVBD-PSEG		:MULTI-LEAVING BID (SOH,ENQ)
	HC	IERSET-PSEG		:DATA ABORT (ENQ,EOT,NAK IN TEXT)
	HC	RCVRTY-PSEG		:LOST SYNCHRONIZATION
	HC	IRESFX-PSEG		:OVERRUN (EXCEED RCV RESOURCE LIMIT)
	HC	IRESFX-PSEG		:NO INITIAL BUFFERLET AVAILABLE
	HC	IRTIMO-PSEG		:TIMEOUT BEFORE MSG RECEIVED
	HC	IERSET-PSEG		:CRC ERROR IN DATA MESSAGE
	HC	IERSET-PSEG		:LOST DATA (BUFFERLET UNAVAILABLE)
	HC	RCVRTY-PSEG		:UNIDENTIFIABLE MSG
	HC	IDLE-PSEG		:FORCED COMPLETION BY BACKGROUND


:**********************************************************************
:>>>>>> THE FOLLOWING CODE BELONGS IN BSCPTP
:	NOTE: FOR SOURCE CHANGE USE IRESET INSTEAD OF IRESFX

	CONPATCH(XLCM,,6)		:CREATE VECTOR SPACE
	J	IREFX3,,

	CONPATCH(PA1PTR,,5C)
	KILL	XLCM10
IREFX3	XOPCHK(PCRASH,XLCM10,PCRASH,PCRASH)
XLCM10	LHI	R0,SLCM-PSEG		:SET TO DECODE LCM RESPONSE
	STH	R0,STATE,RL2
	LHL	R0,TXL.LN,RL2,		:SET TIMEOUT FOR RESPONSE
	LIS	R4,0			:SEND DATA AND READ RESPONSE
	J	XMTRCV,,

:********************

	CONPATCH(XLCM+6,,42)
IRESFX	J	IREFX2,,
IENQ	J	IREFX5,,
IACK0	J	IREFX6,,
IWACK	J	IREFX7,,
ILENQ	J	IREFX8,,
ILFRC	J	IREFX9,,
IRENQ	J	IREFXA,,
IRACK0	J	IREFXB,,
IRTIMO	J	IREFXC,,
IRENAK  J       IREFXD,,              :PS 07/07/88
IREWAK  J       IREFXE,,              :PS 07/07/88

	CONPATCH(PA1PTR,,36) 
IREFX2
	TBT	RL,BSCRBD		:REMOTE BIDDING ENABLED?
	JE	IRESET,,		:NO--SKIP
        TBT     RL,BSCEOT,,             :PS 12/06/89 E-T-E EOTs SUPPORTED?
        JE      YUBBRY                  :PS 12/06/89 NO, DON'T INCREMENT CNTR
        LHI     R5,HLNMEQ               :PS 08/21/89
        CH      R5,CNTEOT,R9,           :PS 08/21/89 (QUEUE ANOTHER EOT TO B.G.)
        JLE     IDLE,,                  :PS 08/21/89 (NO)
        LIS     R5,1                    :PS 08/21/89
        AHM     R5,CNTEOT,R9,           :PS 08/21/89

YUBBRY	ROPQND(FFEOT)			:SEND EOT TO REMOTE DEVICE TO
::::::	J	IRESET,,		:...BREAK POTENTIAL TTD/NAK LOOP.
	J	IDLE,,

        CONPATCH(RIEOT+4,,6)          :PS 08/21/89 (COUNT EOTs TO B.G.)
        J     RIEOT4,,                :PS 08/21/89
        CONPATCH(PA1PTR,,2C)          :PS 08/21/89
RIEOT4  LHI   R0,HLNMEQ               :PS 08/21/89 (GET QUEUE LIMIT)
        TBT   R8,BSCRBD,,             :PS 11/20/89 (REMOTE BIDDING ENABLED?)
        JEFS  PS5555                  :PS 11/20/89 (NO, DON'T COUNT EOTs)
        CH    R0,CNTEOT,R9,           :PS 08/21/89 (DON'T QUEUE > HLNMEQ)
        JLE   IDLE,,                  :PS 08/21/89
        LIS   R0,1                    :PS 08/21/89
        AHM   R0,CNTEOT,R9,           :PS 08/21/89 (INCREMENT COUNTER)
PS5555  JAL   R0,ROPSND,,             :PS 08/21/89 (QUEUE TO  BackGround)
        J     IDLE,,                  :PS 08/21/89


	CONPATCH(BSCPTP,,6)
	J	DLFX09,,

	CONPATCH(PA1PTR,,58)
DLFX09	HS	0
	LR	R2,R1			:MAKE LINE WORD INDEX
	LIS	R4,0
        STH     R4,CNTIOT,R1,R1         :PS 10/25/89
        STH     R4,CNTEOT,R1,R1         :PS 10/25/89
        STH     R4,CNTACK,R1,R1         :PS 05/01/89
        STH     R4,CNTICK,R1,R1         :PS 05/01/89
        STH     R4,CNTNAK,R1,R1         :PS 07/07/88
        STH     R4,CNTNIK,R1,R1         :PS 07/07/88
        STH     R4,CNTWAK,R1,R1         :PS 07/07/88
        STH     R4,CNTWIK,R1,R1         :PS 07/07/88
        STH     R4,CNTENQ,R1,R1         :PS 06/02/88
        STH     R4,CNTINQ,R1,R1         :PS 06/07/88
	STH	R4,CTIENQ,R1,R1		:CLEAR THE CONTENTION COUNTERS
	STH	R4,CTOENQ,R1,R1
	STH	R4,BDTIME,R1,R1
	J	BSCPTP+0A,,

	CONPATCH(IDLE38,,6)
	J	DLFX10,,

	CONPATCH(PA1PTR,,1A)
DLFX10	HS	0
	TBT	RL,BSCRBD		:REMOTE BIDDING ENABLED?
	JN	IDLE40,,		:YES--SEND EOT END-TO-END	
	TBT	RL,BSCEOT,,		:IF IDLE EOT NOT REQUESTED
	JE	IBID,,			:..THEN BID
	J	IDLE40,,

	CONPATCH(IDLE40+4,,6)
	J	DLFX11,,

	CONPATCH(PA1PTR,,8A)
DLFX11	HS	0
	JE	IDLE5D,,		:PS 08/21/89 (GO DECREMENT COUNTER)
	TBT	RL,BSCRBD		:REMOTE BIDDING ENABLED?
	JE	IDLE30,,		:NO--GO CHECK OUTBOUND QUEUE
	CHI	R4,FFENQ		:ENQ FROM REMOTE DEVICE?
	JE	IDLE60			:YES--SKIP
	CHI	R4,FFACK0		:ACK0 FROM REMOTE DEVICE?
	JE	IDLE66  		:PS 05/01/89 YES, GO TO RECEIVE STATES
        CHI     R4,FFNAK                :PS 07/07/88
        JE      TRSHNK                  :PS 07/07/88
        CHI     R4,FFWACK               :PS 07/07/88
        JE      TRSHWK                  :PS 07/07/88
	J	IDLE30,,		:CHECK OUTBOUND QUEUE AGAIN

IDLE5D  TBT     R8,BSCRBD,,             :PS 11/20/89 (REMOTE BIDDING ENABLED)
        JE      IRESET,,                :PS 11/20/89 (NO, PROCESS EOT NORMALLY)
        LCS     R5,1                    :PS 08/21/89
        AHM     R5,CNTIOT,R9,           :PS 08/21/89 (DECREMENT COUNT FRM B.G.)
        J       IRESET,,

IDLE60	LHI	R1,SRBID-PSEG		:SEND ENQ TO LOCAL DEVICE
        LCS     R5,1                    :PS 06/07/88
        AHM     R5,CNTINQ,RL,RL         :PS 06/07/88
	J	PCRASH-10,,		:(IBID20)...AND CHANGE STATE TO SRBID
IDLE66  LCS     R5,1                    :PS 05/01/89
        AHM     R5,CNTICK,RL,RL         :PS 05/01/89
        J       ETPVC+8,,               :PS 05/01/89
TRSHNK  LCS     R4,1                    :PS 07/07/88
        AHM     R4,CNTNIK,RL,RL         :PS 07/07/88
        J       IDLE30,,                :PS 07/07/88

TRSHWK  LCS     R4,1
        AHM     R4,CNTWIK,RL,RL         :PS 07/07/88
        J       IDLE30,,                :PS 07/07/88


	CONPATCH(RCNTNT,,6)
	J	DLFX12,,

	CONPATCH(PA1PTR,,38)
DLFX12	HS	0
	LHI	R0,7FFF			:IF REMOTE BIDDING ENABLED,
	TBT	RL,BSCRBD		:...WE MUST WIN THE BIDDING
	JN	RCNTN1,,
	LIS	R0,3			:IF STOPPING INPUT, ALLOW 3 CONTENTIONS
	TBT	RL,BSCSIN,,
	J	RCNTNT+6,,

	CONPATCH(PA1PTR,,6E)


:	LINE BID FROM LOCAL DEVICE : IENQ
:	---------------------------------
:	IF REMOTE BIDDING (BRBD OPTION) IS ENABLED, TRANSITION TO SLBID 
:	STATE, SEND ENQ ACROSS THE NET, AND TURN ON 'BSCEFR' TO ENABLE
:	BACKGROUND TO INTERRUPT RECEIVE MODE WHEN MESSAGES ARRIVE FROM THE 
:	REMOTE DEVICE IN THE OUTBOUND QUEUE.

:IENQ
IREFX5
	LA	R0,LACTIV,,		:DO WE HAVE A CIRCUIT?
	LO	LINE
	CL	R0,L.AS,RL2,RL2
	FO	LINE
	JN	RINIT,,			:NO--PROCESS NORMAL BIDDING

	TBT	RL,BSCRBD		:REMOTE BIDDING ENABLED?
	JE	RINIT,,			:NO--PROCESS NORMAL BIDDING

	LHI	R0,SLBID-PSEG		:SET STATE TO SLBID
	STH	R0,STATE,RL2,

        LHI     R1,HLNMEQ               :PS 06/02/88
        CH      R1,CNTENQ,RL2,          :PS 06/02/88 (SEE IF 16 BUFFERED)
        JLE     IREBYS                  :PS 06/02/88 (YES DON'T QUEUE MORE)
	ROPQND(FFENQ)			:QUEUE ENQ TO BACKGROUND
        LIS     R1,1                    :PS 06/02/88
        AHM     R1,CNTENQ,RL2,          :PS 06/02/88

IREBYS  HS      0                       :PS 06/02/88
	SBT	RL,BSCEFR,,		:ENABLE FORCE RECEIVE COMPLETE
	LHL	R0,TRQ.LN,RL2,		:SET TIMEOUT FOR NEXT MSG FROM LCL DEV
	LHI	R1,BSCRBC		:SET RCV RESOURCE LIMIT
	J	RCV,,			:GO RECEIVE

:	ACK0 OR WACK FROM LOCAL DEVICE : IACK0, IWACK
:	---------------------------------------------
:	IF REMOTE BIDDING IS ENABLED AND THE REMOTE DEVICE HAS NOT YET
:	BID FOR THE LINE, ACK0 OR WACK ARE INVALID AND ARE DISCARDED.

:IACK0
:IWACK
IREFX6
IREFX7
	TBT	RL,BSCRBD		:REMOTE BIDDING ENABLED?
	JE	IRESET,,		:NO--PROCESS NORMALLY
	J	IDLE,,


	CONPATCH(PA1PTR,,0D2)

:	BID CONTENTION IN SLBID STATE : ILENQ
:	-------------------------------------
:	WHILE WAITING FOR THE REMOTE DEVICE TO ANSWER THE END-TO-END BID,
:	ANOTHER ENQ WAS RECEIVED FROM THE LOCAL DEVICE.

:ILENQ
IREFX8
        LHI     R1,HLNMEQ             :PS 06/02/88
        CH      R1,CNTENQ,RL2,        :PS 06/02/88 (SEE IF 16 ENQ'S BUFFERED)
        JLE     ILENQ5                :PS 06/02/88 (IF SO DON'T BUFFER MORE)
	ROPQND(FFENQ)			:SEND ENQ ACROSS THE NET
        LIS     R1,1                  :PS 06/02/88
        AHM     R1,CNTENQ,RL2,        :PS 06/02/88
ILENQ5
	SBT	RL,BSCEFR,,		:ENABLE FORCE RECEIVE COMPLETE
	LIS	R1,2			:SET RCV BUFFERLET LIMIT (RCV DATA NOT ALLOWED)
	J	RCV,,			:GO START RCV


:	MSG FROM REMOTE DEVICE WHILE IN SLBID STATE : ILFRC
:	---------------------------------------------------
:	WHILE IN SLBID STATE WE ARE WAITING FOR THE REMOTE (DISTANT)
:	DEVICE TO RESPOND TO THE LOCAL DEVICE'S END-TO-END BID.
:	BACKGROUND FORCED RECEIVE COMPLETE BECAUSE SOMETHING
:	APPEARED IN THE OUTBOUND QUEUE. THIS IS MOST LIKELY THE 
:	RESPONSE TO THE ENQ, BUT COULD ALSO BE A NET MESSAGE.

:ILFRC
IREFX9
	RBT	RL,BSCFRC,,		:RESET FORCE RECEIVE COMPLETE
	RBT	RL,BSCEFR,,		:DISABLE FORCE RECEIVE COMPLETE

	XOPCHK(IDLE,PCRASH-14,IRESFX,ILFR10)
:		.NONE  .DATA     .EOT   .ELSE

ILFR10
	JAL	R5,CDEQUE,,		:DEQUE XMT OP (R4 = OP CODE)

	CHI	R4,FFACK0		:BID ACKNOWLEDGED BY REMOTE DEVICE?
	JE	IDLE66   		:PS 05/01/89 YES, READY TO RECEIVE DATA
	LIS	R1,XCNAK		:GET READY TO XMT NAK TO LOCAL DEVICE
	CHI	R4,FFNAK		:BID REFUSED BY REMOTE DEVICE?
        JN      ILFR11                  :PS 07/07/88
        LCS     R5,1                    :PS 07/07/88
        AHM     R5,CNTNIK,RL2,          :PS 07/07/88
        J       IXMT,,
ILFR11  LIS     R1,XCWACK
	CHI	R4,FFWACK		:BID REFUSED BY REMOTE DEVICE?
        JN      ILFR12                  :PS 07/07/88
        LCS     R5,1                    :PS 07/07/88
        AHM     R5,CNTWIK,RL2,          :PS 07/07/88
        J       IXMT,,                  :PS 07/07/88
ILFR12  CHI     R4,FFENQ                :IS REMOTE DEVICE BIDDING?
	JN	IRESFX,,		:NO--UNEXPECTED CMD, RESET LINE

	LIS	R0,1			:COUNT OUTBOUND ENQ
	AHM	R0,CTOENQ,RL2		:NON-ZERO INDICATES BID CONTENTION
	LHI	R1,SRBID-PSEG		:TRANSITION TO SRBID STATE
	J	PCRASH-10,,		:(IBID20)... AND BID ON BEHALF OF REMOTE DEVICE
	
	CONPATCH(PA1PTR,,1B2)

:	BID CONTENTION IN SRBID STATE : IRENQ
:	-------------------------------------
:	WHILE WAITING FOR THE LOCAL DEVICE TO ANSWER THE END-TO-END BID 
:	FROM THE REMOTE DEVICE, THE LOCAL DEVICE BIDS FOR THE LINE.

:IRENQ
IREFXA
        LHI     R1,HLNMEQ               :PS 06/02/88
        CH      R1,CNTENQ,RL2,          :PS 06/02/88 (SEE IF 16 ENQ'S BUFFERED)
        JLE     IREBPS                  :PS 06/02/88 (IF SO DON'T QUEUE MORE)
	ROPQND(FFENQ)			:SEND ENQ ACROSS THE NET
        LIS     R0,1                    :PS 06/02/88
        AHM     R0,CNTENQ,RL2,          :PS 06/02/88
IREBPS  HS      0                       :PS 06/02/88

	LIS	R0,1			:COUNT INBOUND ENQ 
	AHM	R0,CTIENQ,RL2		:...NON-ZERO INDICATES BID CONTENTION
	LHI	R1,SLBID-PSEG		:TRANSITION TO SLBID STATE
	STH	R1,STATE,RL2,
	LIS	R1,2			:SET RCV BUFFERLET LIMIT, DON'T ALLOW DATA MSG
	J	RCV,,			:GO RECEIVE


:	LOCAL DEVICE ACKNOWLEDGES REMOTE BID WITH ACK0 : IRACK0
:	-------------------------------------------------------
:	SEND THE LOCAL DEVICE'S ACK0 ACROSS THE NET AND INITIALIZE
:	TRANSMISSION IN PREPARATION FOR DATA TRANSFER FROM REMOTE
:	DEVICE TO LOCAL DEVICE. SEND TTDs TO LOCAL DEVICE UNTIL
:	DATA ARRIVES FROM THE REMOTE DEVICE.

:IRACK0
IREFXB
        LHI     R1,HLNMEQ               :PS 05/01/89
        CH      R1,CNTACK,RL2,          :PS 05/01/89
        JLE     IREFB3                  :PS 05/01/89
        LIS     R1,1                    :PS 05/01/89
        AHM     R1,CNTACK,RL2,          :PS 05/01/89
	ROPQND(FFACK0)			:SEND ACK0 ACROSS THE NET
IREFB3  LIS     R1,0                    :PS 06/23/88
        STH     R1,CNTINQ,RL2,          :PS 06/23/88 THROW AWAY REST OF ENQ'S
        STH     R1,CNTNIK,RL2,          :PS 07/07/88 THROW AWAY REST OF NAK'S
        STH     R1,CNTWIK,RL2,          :PS 07/07/88 THROW AWAY REST OF WAK'S
        STH     R1,CNTIOT,RL2,          :PS 10/25/89
	LHI	R1,SXMT-PSEG		:TRANSITION TO THE TRANSMIT STATE
	STH	R1,STATE,RL2
	J	XINIT,,			:GO INIT TRANSMISSION


:	LOCAL DEVICE RCV TIMEOUT : IRTIMO
:	--------------------------------
:	THE LOCAL DEVICE DID NOT RESPOND TO THE REMOTE LINE BID WITHIN
:	THE ALLOTTED TIME. CHECK OUTBOUND QUEUE FOR ANY MESSAGES TO SEND
:	TO THE LOCAL DEVICE.
:	IF DATA MESSAGE (PROBABLY NET MSG), BID FOR LINE AND TRY TO
:	DELIVER TO LOCAL DEVICE.
:	SINCE WE DID NOT SEND AN ENQ TO THE REMOTE DEVICE, ACK0, NAK OR 
:	WACK ARE NOT EXPECTED AND DISCARDED. WE RETURN TO IDLE STATE.
:	IF ANOTHER ENQ ARRIVES FROM THE REMOTE DEVICE WE TRY TO DELIVER IT.

:IRTIMO
IREFXC
	XOPCHK(IRESFX,PCRASH-14,IRTM10,IRTM20)
:		.NONE  .DATA     .EOT   .ELSE

IRTM10
	JAL	R5,CDEQUE,,		:DEQUEUE EOT MSG
	J	IRESFX,,		:RESET LINE BY SENDING EOT

IRTM20
	JAL	R5,CDEQUE,,		:DEQUEUE MSG
	CHI	R4,FFACK0
	JE	IDLE66   		:PS 05/01/89 GO TO RECEIVE STATES
	CHI	R4,FFNAK
	JE	IDLE,,			:EAT NAK, GO TO IDLE
	CHI	R4,FFWACK
	JE	IDLE,,			:EAT WACK, GO TO IDLE
	CHI	R4,FFENQ		:IS REMOTE DEVICE BIDDING?
	JN	IRESFX,,		:NO, RESET LINE FOR EVERYTHING ELSE
        LCS     R2,1                    :PS 06/07/88
        AHM     R2,CNTINQ,RL2,          :PS 06/07/88

IRTM30	XOPCHK(PCRASH-0C,PCRASH-0C,PCRASH-0C,IRTM40)
IRTM40	CHI	R4,FFENQ		:IS THERE ANOTHER ENQ IN THE QUEUE
	JN	PCRASH-0C,,		:NO
        LCS     R2,1                    :PS 06/07/88
        AHM     R2,CNTINQ,RL2,          :PS 06/07/88
	XOPDQU				:DEQUEUE THE ENQ
	J	IRTM30

CONPATCH(XSDAT6,,6)                   :PS 06/23/88
        J       XSDT66,,
CONPATCH(PA1PTR,,64)
XSDT66  HS      0
        JAL     R5,CDEQUE,,           :PS 062388 RESTORE ORIGINAL INSTRUCTION
        JE      XSDT67,,              :PS 08/21/89 DECREMENT EOT COUNTER
        CHI     R4,FFENQ              :PS 062388 SEE IF E-T-E ENQ
        JN      XSDT68                :PS 05/01/89  NO
        LCS     R1,1                  :PS 062388
        AHM     R1,CNTINQ,RL,RL       :PS 062388 DECREMENT COUNTER
        LHI     R1,SRBID-PSEG         :PS 062388 CHANGE STATE TO SRBID
        J       PCRASH-10,,           :PS 062388

XSDT67  TBT     R8,BSCRBD,,           :PS 11/20/89 (REMOTE BIDDING ENABLED?)
        JE      IRESET,,              :PS 11/20/89 (NO, NOT COUNTING EOTs)
        LCS     R5,1                  :PS 10/25/89 (CHANGED FROM LIS R5,1)
        AHM     R5,CNTIOT,R9,         :PS 08/21/89 (DECREMENT FROM-NET COUNTER)
        J       IRESET,,              :PS 08/21/89

XSDT68  CHI     R4,FFACK0             :PS 05/01/89  ACK0?
        JN      XSDATA,,              :PS 05/01/89  N0
        LCS     R5,1                  :PS 05/01/89
        AHM     R5,CNTICK,RL,RL       :PS 05/01/89
        JGE     XSDATA,,              :PS 05/01/89
        LIS     R5,0                  :PS 05/01/89
        STH     R5,CNTICK,RL,RL       :PS 05/01/89
        J       XSDATA,,              :PS 05/01/89
CONPATCH(PA1PTR,,50)                  :PS 07/07/88
IREFXD  LHI     R1,HLNMEQ             :PS 07/07/88
        CH      R1,CNTNAK,RL2,        :PS 07/07/88
        JLE     IDLE,,                :PS 07/07/88
        ROPQND(FFNAK)                 :PS 07/07/88
        LIS     R1,1                  :PS 07/07/88
        AHM     R1,CNTNAK,RL2,        :PS 07/07/88
        J       IDLE,,                :PS 07/07/88

IREFXE  LHI     R1,HLNMEQ             :PS 07/07/88
        CH      R1,CNTWAK,RL2,        :PS 07/07/88
        JLE     IDLE,,                :PS 07/07/88
        ROPQND(FFWACK)                :PS 07/07/88
        LIS     R1,1                  :PS 07/07/88
        AHM     R1,CNTWAK,RL2,        :PS 07/07/88
        J       IDLE,,                :PS 07/07/88

	FO	BSCPTP
	FO	BSCDEF
	FO	BSCHDX

	EI	(BRBD)

	ENDPATCH(Deadlock Prevention)

:************************************************************************
:
:	This patch fixes a bug in HSECs ring logic
:
	LO 	HSEC
	LO	LINE
	LO	FCB
	LO	IRS00

	PATCH(860812,1803,NTD.B/KRUEGER,RNGOK,,6)
	J	RINGFX,,

	CONPATCH(PA1PTR,,18)
RINGFX	HS	0
	LA	RALS,LSWRR,,		:LINE STATE = READY FOR REMOTE SIGNON
	LHL	RAFCB,L.ATT,RL2,	:GET ADDR OF REMOTE SIGNON FCB
	JAL	R5,IRSMOY,,		:REFLECT CC,DIALECT,AND MODE
	JR	RLINK

	FO	HSEC
	FO	LINE
	FO	FCB
	FO	IRS00

	ENDPATCH(HSEC simulated ring fix)
		
:************************************************************************
:
:	This patch removes the requirement that a circuit must be
:	established before ETX end-to-end acknowlegment is enforced.
:	
	LO	BSCPTP

	PATCH(860814,0958,NTD.B/KRUEGER,RDAT12+8,,0A)
	NOP	,,,
	NOP

	FO 	BSCPTP

	ENDPATCH(Permit BETX before circuit establishment)
:*************************************************************************
        LO BSCDEF
        LO BSCPTP
        LO MAIN
        LO FCB
        LO R100
        LO IR100
:  Patch to send FORWARD ABORT control message when EOT received from
:  terminal after terminal gave up awaiting ACK from remote end.  This
:  is during SRWACK state.  If EOT is encountered during data transfer
:  (i.e. after ETB) it will be sent to remote end rather than leaving
:  HIF in TTD-NAK loop.  This is during SRCV state.       DEW    01/10/90

PATCH(891218,1730,WARNERD,IRABRT,,6)
        J       PA1PTR,,

CONPATCH(PA1PTR,,46)

        CLHI    R0,RCDATB       : SEE IF THIS IS EOT IN SRCV STATE
        JE      EABRT,,         : IF SO, SHIP EOT OUT

        ROPQND(FFFORW)          : NEW CONTROL MESSAGE 091D FOR EOT RECEIVED
        LIS     R0,0            :RESET COUNTER
        STB     R0,RETRY,RL,    :OLD INSTRUCT
        J       IRABRT+6,,      :AFTER GIVING UP WHEN NO ACK IS RECEIVED FOR
                                :DATA PREVIOUSLY TRANSMITTED
EABRT   ROPQND(FFEOT)           :CONTROL MESSAGE FOR EOT
        LIS     R0,0            :RESET COUNTER
        STB     R0,RETRY,RL,    :OLD INSTRUCT
        J       IRABRT+6,,      :GO BACK

ENDPATCH(send 091d instead of 0911 for FORWARD ABORT and 0911 for EOT)
        FO FCB
        LO MAIN
        LO BSCPTP
        LO IR100
        LO R100
        LO BSCDEF
:  This patch is to detect FORWARD ABORT control message and to dequeue
:  all commands and data and to ship out EOT to host to prevent endless
:  bidding when host doesn't acknowledge previously sent data or ENQ.  This
:  is during SXTMOT state and SBID state.            DEW  01/10/90

PATCH(891219,1730,WARNERD,SBID+20,,4)
        HC      XLCM+48-PSEG  :FORMERLY IXNOBR, CONFLICT WITH OTHER PATCH

CONPATCH(XLCM+48,,6)
        J       PA1PTR,,        :FOR SBID STATE
CONPATCH(XTMOT,,6)
        J       SEOT,,          :FOR SXTMOT STATE

CONPATCH(PA1PTR,,134)

        RBT     R8,FORABR,,             :TEST BIT SET FOR FORWARD ABORT (EOT)
        JE      IXNOBR+6,,              :IF NOT SET GO BACK TO MAIN PROGRAM
        J       OPCHK,,                 :IF SET PREPARE TO DEQUEUE DATA 
SEOT    RBT     R8,FORABR,,             :CHECK BIT SET DURING SXTMOT STATE
        JN      OPCHK,,                 :IF SET PREPARE TO DEQUEUE DATA
        JAL     R5,SETERR,,             :IF NOT REPLACE OLD INSTRUCT 
        LHI     R0,SXTMOT-PSEG
        J       XTMOT+8,,               :AND GO BACK
OPCHK   XOPCHK(COMP,DUMP,BOOT,BOOT)     :MACRO TO CHECK TYPE OF DATA AND REACT
BOOT    JAL     R5,CDEQUE,,             :EOT OR OTHER COMMAND - DEQUEUE IT
        J       OPCHK,,                 :GO CHECK FOR MORE
DUMP    XOPDQU                          :MACRO TO DEQUEUE DATA
        J       OPCHK,,                 :GO CHECK FOR MORE
COMP    LIS     R0,0                    :COMPLETE, REPLACE INSTRUCT
        STB     R0,RETRY,RL,            :DOESN'T ALLOW RESET SO EOT GOES OUT
        J       IRESET,,                :FINISH NORMAL PROCESSING
ENDPATCH(IF FORWARD ABORT DEQUEUE DATA AND SEND EOT)
    a@”