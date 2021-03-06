File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

1)1		SUBTTL	3270 TERMINAL INTERFACE CACULATION FILE
****
2)2	: ******************************************************************
2)	: **                  PROPRIETARY INFORMATION                     **
2)	: **                                                              **
2)	: **  This  source  code  listing  constitutes  the proprietary   **
2)	: **  property of MDC-TYMNET.  The recipient, by receiving this   **
2)	: **  program listing, agrees that neither this listing nor the   **
2)	: **  informa tion disclosed herein nor any part thereof shall be  **
2)	: **  reproduced or transferred to other documents or used or dis-**
2)	: **  closed to others for manufacturing or for any other purpose **
2)	: **  except as specifically authorized in writing by MDC-TYMNET. **
2)	: ******************************************************************
2)	: **                   PROGRAM IDENTIFICATION                     **
2)	: **                                                              **
2)	: **  Version Number     :  9.03         Release Date :  07-19-87 **
2)	: **                                                              **
2)	: **  File Name          :  PBT09.R03                             **
2)	: **                                                              **
2)	: **  File Description   :  3270 TERMINAL INTERFACE SOURCE CODE   **
2)	: **                                                              **
2)	: **  File Abstract      :                                        **
2)	: ******************************************************************
2)		SUBTTL	3270 TERMINAL INTERFACE CACULATION FILE
**************
1)32	: PRO.604
****
2)33	:	07/02/87 RJR ESC# CORRECT THE XMTOT AND RCVTOT VALUES FOR QCU
2)	:
2)	: PRO.604
**************
1)32	:
1)	        RA      0
****
2)33	: PRO.X24 - 04-17-87 RJR ESC 19529
2)	        RA      0
**************
1)46	RDAT16	LIS	R4,1		:BUMP MSG BLOCK RECEIVED COUNTER
1)		AM	R4,RCVTOT,R7,R7
1)	        SLHLS   R7,2            : MAKE IT A FULLWORD INDEX
1)	        L       R4,FASTC,,      : GET TIME AND 
****
2)47	RDAT16
2)	        SLLS    R7,2            : MAKE IT A FULLWORD INDEX RJR 07-02-87
2)		LIS	R4,1		:BUMP MSG BLOCK RECEIVED COUNTER
2)		AM	R4,RCVTOT,R7,
2)	        L       R4,FASTC,,      : GET TIME AND 
**************
1)52	        SLHLS   R6,2            :FIX BUG WHICH SAID XMTTOT IS HWs instead of FW
1)		AM	R1,XMTTOT,R6,   :xmttot is fullword array
1)	        SRHLS   R6,2            :finish fix by restoring r6
1)		LIS     R1,XCDATA       :GET SEND DATA OP CODE
****
2)53	        SLLS    R6,2            :FIX BUG WHICH SAID XMTTOT IS HWs instead of FW
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

2)		AM	R1,XMTTOT,R6,   :xmttot is fullword array
2)	        SRLS    R6,2            :finish fix by restoring r6
2)		LIS     R1,XCDATA       :GET SEND DATA OP CODE
**************
1)68		
1)		SEG	1
1)	        IF      THOST
****
2)69	        IF      THOST
**************
1)68			SUBTTL	ISIS Front End Handler Package	- FRNTND.LIB
1)	:******************************************************************
****
2)69		
2)		SEG	1
2)		SUBTTL	ISIS Front End Handler Package	- FRNTND.LIB
2)	:******************************************************************
**************
1)88	        JAL     R5,TOPUT                : PUT ON TIMEOUT RUN LIST
1)	        RETJ(R5)
****
2)89	        JAL     R5,TOPUT,,              :(1-12-87RJR) PUT ON TIMEOUT RUN LIST
2)	        RETJ(R5)
**************
1)89	        JAL     R5,TOPUT                : PUT ON TIMEOUT LIST
1)	        J       TORET,,			:(11/12/86 PC)
****
2)90	        JAL     R5,TOPUT,,              :(1-12-87 RJR) PUT ON TIMEOUT LIST
2)	        J       TORET,,			:(11/12/86 PC)
**************
1)98	SNDINC  LA      R6,M.INC
1)	        JAL     R5,SNDIIX
****
2)99	SNDINC  LA      R6,M.INC,,
2)	        JAL     R5,SNDIIX
**************
1)98	M.INC   SC      /"C0"8B/
1)99	:
****
2)99		SEG	0
2)	M.INC   SC      /"C0"8B/
2)		SEG	1
2)100	:
**************
1)99	GLOREQ  LA      R6,M.ID         
1)	        JAL     R5,SNDIIX               :SEND ID/VERSION MSG
****
2)100	GLOREQ  LA      R6,M.ID,,
2)	        JAL     R5,SNDIIX               :SEND ID/VERSION MSG
**************
1)99	M.ID    BC      6,80,86,00,PRODID,VERSION,REVLEV
1)100	:
****
2)100		SEG	0
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

2)	M.ID    BC      6,80,86,00,PRODID,VERSION,REVLEV
2)		SEG	1
2)101	:
**************
1)124	        LA      R1,LERR                 :INSERT HEADER
1)	        JAL     R5,PBSIN,,		:(ESC.,WCMD,WCCK,SBA.)
****
2)125	        LA      R1,LERR,,               :INSERT HEADER
2)	        JAL     R5,PBSIN,,		:(ESC.,WCMD,WCCK,SBA.)
**************
1)124	LERR    HC      $A4
1)	        BC      ESC.,WCMD,WCCK,SBA.
1)125	:       OLC - OUTPUT CONTROL ROUTINE TABLE - LOGON MODE
****
2)125		SEG	0
2)	LERR    HC      $A4
2)	        BC      ESC.,WCMD,WCCK,SBA.
2)		SEG	1
2)126	:       OLC - OUTPUT CONTROL ROUTINE TABLE - LOGON MODE
**************
1)125		SEG	A.CODE
1)	: 
****
2)126	        SUBTTL  BACK - GENERAL BACKGROUND CODE
2)	:
2)	: BACK.X28 - 10/02/85 JSOUNG FOR "TO HOST EDF"
2)	: BACK.X29 - 10/24/85 PC HITACHI/JAPAN
2)	:            01/06/86 PC
2)	:	(DIAL) CHANGED BY J/SOUNG FOR 3270 DIAL-UP SUPPORT
2)	:
2)	:(TYM)	04/08/86	RJR TYMFILE LANGUAGE CHANGES
2)	: BACK.900
2)	:	04/30/86 PC SWB BOM
2)	: BACK.X30 11/15/86 sdw ADDED CRASH CODES
2)	: NSR 1082 RJR 11-17-86 
2)	: NSR 821  sdw 11/18/86 DISPATCHER CRASH DUE TO QUICK REUSE OF DPORTS
2)	: nsr 1238,1239 rjr 03-20-87 pvcopn(1and 2) fixed.
2)	: ADD CHANGES AT RNPV90 AND RNPVC RJR 06-19-87
2)	:            
2)	        RA      0
2)	        LO      BSCCHR          :ACCESS BISYNC CHAR DEFINITIONS
2)	        LO      BSCDTR          :ACCESS LOGICAL UNITS
2)		GL	LSTART,STARTS,IZBOM,CP.FNT,CP.ACT
2)		GL	PR.ON,PR.FNT,PR.ACT,ST.FNT,ST.ACT,RE.FNT,RE.ACT
2)		GL	DA.ON,DA.ONR,DA.ONX,DA.ACT,DA.FNT,PT.ON,PT.ACT
2)		GL	PT.FNT,PTRBIT
2)		GL	ONTIME
2)		IF	THOST
2)		GL	GENXM6,GENTST,GENXM5,GENRC6
2)		EI	:(THOST)
2)	:       CONFIGURATION
2)	:       -------------
2)	SMRSCS  EQ      0               :IF SIMULATING WITH RSCS, TIME BETWEEN
2)	                                :REQUESTS IN SECS, 0 IF NOT IN SIMULATION
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

2)	ZAPMSG  EQ      09F             : ZAP MSG CODE
2)	        SEG     0
2)	:       PROCESS BASE ADDRESS
2)	:       --------------------
2)	BSEG    EQ      SEG1            :BASE ADDRESS FOR PROCESSES
2)	:	LSTART - GMT AT LAST TIME SLOT WAS STARTED
2)	LSTART	WS	1		:TIME SLOT WAS LAST STARTED
2)	ONTIME	WS	NDEVM		:GMT TIME WHEN TERMINAL CONNECTED
2)	STARTS	HC	0		:NUMBER OF TIMES SLOT STARTED SINCE LOADED
2)127	:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
2)	::                        I N I T I A L I Z A T I O N                        ::
2)	:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
2)	:       VARIABLE ALLOCATION
2)	:       -------------------
2)	        SEG     1
2)	 
2)	:       REGISTER ALLOCATION
2)	:       -------------------
2)	RBA     EQ      R3              : POINTER TO CURRENT BIG BUFFERLET
2)	RACRC   EQ      R9              : ACCUMULATOR FOR CRC
2)	RL      EQ      R8              : LINE NUMBER
2)	RDEV    EQ      R11             : DEVICE NUMBER
2)	 
2)	:       ZAP ANY ACTIVE PORTS
2)	:       --------------------
2)	START	L	R1,GMT,,	:GET CURRENT GMT
2)		ST	R1,LSTART,,	:AND SAVE IT
2)		LIS	R1,1
2)		AHM	R1,STARTS,,	:BUMP SLOT STARTED COUNT
2)		LHI     R1,NPORTT-1     :PORT INDEX
2)	        LIS     R5,0            :CONSTANT REG
2)	        LHI     R2,ZAPMSG       :ISIS ZAPPER
2)	IZ0110  NOP
2)	        LIS     R0,3            :ZAPPER LENGTH
2)	        JAL     R4,SLOR,,       :START MSG
2)	        JAL     R4,ELOR,,       :END MSG
2)	IZ0130  SIS     R1,1            :GO TO NEXT PORT
2)	        JGBS    IZ0110
2)	:       DISMISS WHILE ISIS PROCESSES ZAPPERS
2)	        SVC     DISMISS,0
2)	:       INITIALIZE PROCESSORS
2)	:       ---------------------
2)	IZSECT
2)	        JAL     R0,IZT,,        :INIT TIMEOUT FREE LIST
2)	        JAL     R4,IZBB,,       :INIT BIG BUFFERLETS
2)	        JAL     R4,IZCFL,,      : INIT CMD FREE LIST
2)	        JAL     R0,IZFRNT       : INIT ISIS INPUT HANDLER
2)	        JAL     R4,INSTK                : INIT STACK PTR
2)	        JAL     R5,IZDEV        : INIT B.G. DEVICE INFO
2)	        JAL     R5,IZPORT       : INIT PORT INFO
2)	        JAL     R5,IZOPRT       : INIT CIRCUIT ORIGNATION PORT NUMBER
2)	        JAL     R5,IZLTO        : INIT LOGON TIMERS
2)		IF LOGPLT
2)	        JAL     R5,IZPCTO       : init. polling count timeout routine
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

2)		EI
2)	        JAL     R5,IZIDTO       : INIT ISIS INPUT DATA TIMEOUT
2)	        JAL     R5,IZXTO        : INIT XMT TIMEOUT
2)	        JAL     R5,INITBP,,	: INIT. B.P. CHECK TIMER
2)		JAL	R5,IZBOM,,	: INIT GMT TIMEOUT ROUTINE
2)		JAL	R5,IZTMCK	: INIT GMT TIMEOUT ROUTINE
2)	        JAL     R9,IZHOST       : INIT HOST STATUS
2)	        JAL     R5,IZPVC        :INIT PVC TIMER
2)	        JAL     R5,IZSPAM,,       : INIT. SPACE MAN. ROUTINES
2)	        JAL     R10,IZBSC       : INIT BSC NON-LINE STUFF
2)	        JAL     R10,IZBILN      :INIT BISYNC LINE STUFF
2)		JAL	R5,IZLOGO,,	:(DIAL)INIT TIMEOUT ROUTINE TO ALLOW NO LOGIN
2)		JAL	R5,IZDTRO,,	:(DIAL)INIT TIMEOUT ROUTINE TO HOLD DTR DOWN
2)	        JAL     R5,IZIHNG,,     :(DIAL) INITIALIZE HANG TIMER
2)	        JAL     R5,IZMFLG,,     : INIT DISPLAY MENU FLAG
2)	        LHI     R0,3270         : INIT FRONT PANEL
2)	        STH     R0,FPANEL,,
2)	 
2)	:       START FOREGROUND
2)	:       ----------------
2)	STFG
2)	        IF      ISIS2   
2)	        LA      R0,QBEG         : GET F.G. ADDR.
2)	        SVC     SYS,CFGND.      : CONNECT IT
2)	        ELSE
2)	        SVC     2,QBEG          :CONNECT FOREGROUND
2)	        JAL     R0,BCRASH      :CRASH IF WE CAN'T
2)	        EI
2)128	:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
2)	::                  B A C K G R O U N D   E X E C   L O O P                  ::
2)	:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
2)	:       VARIABLE ALLOCATION
2)	:       -------------------
2)	        SEG     0
2)	EXRETA  WS      1               :EXEC RETURN ADDR
2)	        SEG     1
2)	EXEC    SVC     DISMISS,0       :DISMISS
2)	        JAL     R0,TIMOUT,,     :PROCESS PERIODIC ROUTINES
2)	        JAL     R0,INPUT        : ISIS INPUT HANDLER
2)	        JAL     R5,ISCAN,,	: INPUT QUEUE SCANNER
2)	        JAL     R5,RSCAN,,	: RCV SCANNER
2)	        JAL     R5,OSCAN,,	: OUTPUT QUEUE SCANNER
2)		JAL	R5,ZAPPER	: GO ZAP CIRCUITS AS REQUIRED
2)	:
2)		IF	THOST		: DO THOST??
2)	        JAL     R4,GENRCV       : 
2)		EI
2)	:
2)	        J       EXEC            :DO AGAIN
2)	:       COMMON RETURN TO EXEC
2)	:       ---------------------
2)	EXECRT  L       R10,EXRETA,,    :GET EXEC RETURN ADDR
2)	        JR      R10             :RETURN
2)129	:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

2)	::                  F O R E G R O U N D   E X E C   L O O P                  ::
2)	:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
2)	QBEG    JAL     R10,BSCEXC,,    :SERVICE BISYNC
2)	        SVC     DISMISS,0       :DISMISS
2)	        JBS     QBEG            :GO AGAIN
2)130	:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
2)	::                            INITIALIZE BISYNC LINES
2)	:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
2)	:       REGISTER USAGE
2)	:       --------------
2)	IZBILN  IF DYNBUF
2)		JAL	R5,TSTMSG,,	:(EDF)BUILD UP TEST MESSAGE
2)		EI
2)		LIS     R1,NBILIN-1     :INIT BISYNC ROUTINES
2)	IZA110  JAL     R5,BSCEXI,,     :EXEC SCHEDULER
2)	        LCS     R0,1            :INIT EMPTY POINTER TEST NO-MATCH
2)	        JAL     R5,BSCSRV,,     :RCV
2)	        LCS     R0,1            :XMT
2)	        JAL     R5,BSCSXM,,
2)	        SVC     DISMISS,2	: ALLOW CONNECT CTS ARRAY TO END
2)	        LCS     R0,1            :DTR/DSR
2)	        JAL     R5,BSCDTR,,
2)	        LCS     R0,1            :POINT-TO-POINT PROTOCOL
2)	        JAL     R5,BSCPTP,,
2)		IF DYNBUF
2)		JAL	R5,LNBPS,,	:(EDF)SEND TEST MESSAGE TO CHECK LINE SPEED
2)		EI
2)	        SIS     R1,1            :DO ALL LINES
2)	        JGE     IZA110
2)	        JR      R10             : RETURN
2)	:       INITIALIZE NON-LINE ORIENTED BSC VARIABLES
2)	:
2)	IZBSC
2)	: FOLLOWING CODE IS COMMENTED OUT FOR NOT DOING ANYTHING AT ALL
2)	:
2)	:	LHI     R2,0FFFF        : SET UP BIT VALUE OF ALL ONES
2)	:        LHI     R1,(NCUB-1)*2
2)	:IZBSC2  
2)	:        SIS     R1,2
2)	:        JGEBS   IZBSC2
2)	:
2)	: INITIALIZE DSP ERROR MESSAGE TO HPAD
2)	:
2)		LHI	R1,SWBDSP
2)		STH	R1,SNDERR
2)	:
2)	: INITIALIZE REPORT TO SUP'S LOG
2)	:
2)		LHI	R1,LOGSWT
2)		STH	R1,SUPSWT
2)	: 
2)	        JR      R10             :RETURN
2)131	: 
**************
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

1)125		IF	TWOETB
1)		ELSE
1)	        CHI     R4,10                   : NO MORE THAN 4 TIMES
1)		JGE	GENXM3			: GO WRAP AROUND
1)		EI	:(TWOETB)
1)	        LHL     RDCB,DEVTAB,RDEV,RDEV
****
2)131	        CHI     R4,10                   : NO MORE THAN 4 TIMES
2)		JGE	GENXM3			: GO WRAP AROUND
2)	        LHL     RDCB,DEVTAB,RDEV,RDEV
**************
1)125		IF	ETBMSG
1)		PUSH(R4)
1)		EI
1)	:
1)	: SEND ETB BLOCKS??
1)	:
1)		IF	ETBMSG
1)		JAL	R5,PBNXMT
1)		LHL	R5,DDEV,RDCB,
1)		LHL	R0,DIR0,RDCB,
1)		OHI	R0,ETBBIT
1)	ETBCRT
1)		PUTCMD(XMT,R5,R5)
1)		RLCMD(XMT,R5,R5)
1)		POP(R4)
1)		POPPSH(R6)
1)		AIS	R4,4
1)		L	R1,GENXM7,R4,R6
1)		LHL	RDEV,DDEV,RDCB,
1)		LB	RDEV,DEVLN,RDEV
1)		SLLS	RDEV,1
1)	:
1)	: SECOND ETB BLOCK??
1)	:
1)		IF	TWOETB
1)		JAL	R5,PBNXMT
1)		LHL	R5,DDEV,RDCB,
1)		LHL	R0,DIR0,RDCB,
1)		OHI	R0,ETBBIT
1)	ETBCR2
1)		PUTCMD(XMT,R5,R5)
1)		RLCMD(XMT,R5,R5)
1)		POPPSH(R6)
1)		LIS	R4,8			: THIRD BLOCK FOR ETX
1)		L	R1,GENXM7,R4,R6
1)		LHL	RDEV,DDEV,RDCB,
1)		LB	RDEV,DEVLN,RDEV
1)		SLLS	RDEV,1
1)		EI	:(TWOETB)
1)		EI	:(ETBMSG)
1)	:
1)	        JAL     R5,PBMXMT,,
1)	:
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

****
2)131	        JAL     R5,PBMXMT
2)	:
**************
1)125		IF	TWOETB
1)		ELSE
1)	        CHI	R4,10			: DO FOR 4 MESSAGES
1)	        JGE	GENXM3
1)		EI	:(TWOETB)
1)	        L       R1,GENXM9,R4,R6
****
2)131	        CHI	R4,10			: DO FOR 4 MESSAGES
2)	        JGE	GENXM3
2)	        L       R1,GENXM9,R4,R6
**************
1)125		IF	ETBMSG
1)		PUSH(R4)
1)		EI
1)		LB	RDEV,DEVLN,RDEV,	: GET LINE # FOR DEVICE
****
2)131		LB	RDEV,DEVLN,RDEV,	: GET LINE # FOR DEVICE
**************
1)125	:
1)	: SEND ETB BLOCKS??
1)	:
1)		IF	ETBMSG
1)		JAL	R5,PBNXMT
1)		LHL	R5,DDEV,RDCB,
1)		LHL	R0,DIR0,RDCB,
1)		OHI	R0,ETBBIT
1)	ETBPRT
1)		PUTCMD(XMT,R5,R5)
1)		RLCMD(XMT,R5,R5)
1)		POP(R4)
1)		POPPSH(R6)
1)	ETBPR2
1)		AIS	R4,4
1)		L	R1,GENXM9,R4,R6
1)		LHL	RDEV,DDEV,RDCB,
1)		LB	RDEV,DEVLN,RDEV
1)		SLLS	RDEV,1
1)	:
1)	: SECOND ETB BLOCK??
1)	:
1)		IF	TWOETB
1)		JAL	R5,PBNXMT
1)		LHL	R5,DDEV,RDCB,
1)		LHL	R0,DIR0,RDCB,
1)		OHI	R0,ETBBIT
1)	ETBPRT
1)		PUTCMD(XMT,R5,R5)
1)		RLCMD(XMT,R5,R5)
1)		POPPSH(R6)
1)	ETBPR4
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

1)		LIS	R4,8
1)		L	R1,GENXM9,R4,R6
1)		LHL	RDEV,DDEV,RDCB,
1)		LB	RDEV,DEVLN,RDEV
1)		SLLS	RDEV,1
1)		EI		:(TWOETB)
1)		EI	:(ETBMSG)
1)	        JAL     R5,PBMXMT,,
1)	:
****
2)131	        JAL     R5,PBMXMT
2)	:
**************
1)125		IF	TWOETB
1)		ELSE
1)	        LHL     R5,GENXM5       :ADVANCE TO NEXT MSG
1)		IF	ETBMSG
1)		AIS	R5,8
1)		ELSE
1)	        AIS     R5,4
1)		EI		:(ETBMSG)
1)	:
1)	        CHI     R5,10
1)	        JL      GENX20          : OK TO ADVANCE TO NEXT MESSAGE
1)		EI		:(TWOETB)
1)	        LIS     R5,0
****
2)131	        LHL     R5,GENXM5       :ADVANCE TO NEXT MSG
2)	        AIS     R5,4
2)	        CHI     R5,10
2)	        JL      GENX20          : OK TO ADVANCE TO NEXT MESSAGE
2)	        LIS     R5,0
**************
1)126		OHI	R0,FIRBIT	: SET FIRST BLOCK FOR GENXMT
1)	        PUTCMD(RCV,RDEV,RDEV)
****
2)132	        PUTCMD(RCV,RDEV,RDEV)
**************
1)126	GENRC7  WC	RCVMX		: PTR TO MSG FOR RCV QUEUE
1)	GENRC8  HS      1               : R0 VALUE
****
2)132	GENRC7  WS      1               : PTR TO MSG FOR RCV QUEUE
2)	GENRC8  HS      1               : R0 VALUE
**************
1)126	        J       BCRASH          : CRASH IF NOT AVAIL.
1)	        LHI     RBX,-BBFLSZ+1   : INIT. OFFSET
****
2)132	        JAL     R0,BCRASH       : CRASH IF NOT AVAIL.
2)	        LHI     RBX,-BBFLSZ+1   : INIT. OFFSET
**************
1)127	        SUBTTL  BACK - GENERAL BACKGROUND CODE
1)	:
1)	: BACK.X28 - 10/02/85 JSOUNG FOR "TO HOST EDF"
1)	: BACK.X29 - 10/24/85 PC HITACHI/JAPAN
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

1)	:            01/06/86 PC
1)	:	(DIAL) CHANGED BY J/SOUNG FOR 3270 DIAL-UP SUPPORT
1)	:
1)	:(TYM)	04/08/86	RJR TYMFILE LANGUAGE CHANGES
1)	: BACK.900
1)	:	04/30/86 PC SWB BOM
1)	: BACK.X30 11/15/86 sdw ADDED CRASH CODES
1)	: NSR 1082 RJR 11-17-86 
1)	: NSR 821  sdw 11/18/86 DISPATCHER CRASH DUE TO QUICK REUSDPORTS
1)	:            
1)	        RA      0
1)	        LO      BSCCHR          :ACCESS BISYNC CHAR DEFINITIONS
1)	        LO      BSCDTR          :ACCESS LOGICAL UNITS
1)		GL	LSTART,STARTS,IZBOM,CP.FNT,CP.ACT
1)		GL	PR.ON,PR.FNT,PR.ACT,ST.FNT,ST.ACT,RE.FNT,RE.ACT
1)		GL	DA.ON,DA.ONR,DA.ONX,DA.ACT,DA.FNT,PT.ON,PT.ACT
1)		GL	PT.FNT,PTRBIT
1)		GL	ONTIME
1)		IF	THOST
1)		GL	GENXM6,GENTST,GENXM5,GENRC6
1)		EI	:(THOST)
1)	:       CONFIGURATION
1)	:       -------------
1)	SMRSCS  EQ      0               :IF SIMULATING WITH RSCS, TIME BETWEEN
1)	                                :REQUESTS IN SECS, 0 IF NOT IN SIMULATION
1)	ZAPMSG  EQ      09F             : ZAP MSG CODE
1)	        SEG     0
1)	:       PROCESS BASE ADDRESS
1)	:       --------------------
1)	BSEG    EQ      SEG1            :BASE ADDRESS FOR PROCESSES
1)	:	LSTART - GMT AT LAST TIME SLOT WAS STARTED
1)	LSTART	WS	1		:TIME SLOT WAS LAST STARTED
1)	ONTIME	WS	NDEVM		:GMT TIME WHEN TERMINAL CONNECTED
1)	STARTS	HC	0		:NUMBER OF TIMES SLOT STARTED SINCE LOADED
1)128	:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
1)	::                        I N I T I A L I Z A T I O N                        ::
1)	:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
1)	:       VARIABLE ALLOCATION
1)	:       -------------------
1)	        SEG     1
1)	 
1)	:       REGISTER ALLOCATION
1)	:       -------------------
1)	RBA     EQ      R3              : POINTER TO CURRENT BIG BUFFERLET
1)	RACRC   EQ      R9              : ACCUMULATOR FOR CRC
1)	RL      EQ      R8              : LINE NUMBER
1)	RDEV    EQ      R11             : DEVICE NUMBER
1)	 
1)	:       ZAP ANY ACTIVE PORTS
1)	:       --------------------
1)	START	L	R1,GMT,,	:GET CURRENT GMT
1)		ST	R1,LSTART,,	:AND SAVE IT
1)		LIS	R1,1
1)		AHM	R1,STARTS,,	:BUMP SLOT STARTED COUNT
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

1)		LHI     R1,NPORTT-1     :PORT INDEX
1)	        LIS     R5,0            :CONSTANT REG
1)	        LHI     R2,ZAPMSG       :ISIS ZAPPER
1)	IZ0110  NOP
1)	        LIS     R0,3            :ZAPPER LENGTH
1)	        JAL     R4,SLOR,,       :START MSG
1)	        JAL     R4,ELOR,,       :END MSG
1)	IZ0130  SIS     R1,1            :GO TO NEXT PORT
1)	        JGBS    IZ0110
1)	:       DISMISS WHILE ISIS PROCESSES ZAPPERS
1)	        SVC     DISMISS,0
1)	:       INITIALIZE PROCESSORS
1)	:       ---------------------
1)	IZSECT
1)	        JAL     R0,IZT,,        :INIT TIMEOUT FREE LIST
1)	        JAL     R4,IZBB,,       :INIT BIG BUFFERLETS
1)	        JAL     R4,IZCFL,,      : INIT CMD FREE LIST
1)	        JAL     R0,IZFRNT       : INIT ISIS INPUT HANDLER
1)	        JAL     R4,INSTK                : INIT STACK PTR
1)	        JAL     R5,IZDEV        : INIT B.G. DEVICE INFO
1)	        JAL     R5,IZPORT       : INIT PORT INFO
1)	        JAL     R5,IZOPRT       : INIT CIRCUIT ORIGNATION PORT NUMBER
1)	        JAL     R5,IZLTO        : INIT LOGON TIMERS
1)		IF LOGPLT
1)	        JAL     R5,IZPCTO       : init. polling count timeout routine
1)		EI
1)	        JAL     R5,IZIDTO       : INIT ISIS INPUT DATA TIMEOUT
1)	        JAL     R5,IZXTO        : INIT XMT TIMEOUT
1)	        JAL     R5,INITBP,,	: INIT. B.P. CHECK TIMER
1)		JAL	R5,IZBOM,,	: INIT GMT TIMEOUT ROUTINE
1)		JAL	R5,IZTMCK	: INIT GMT TIMEOUT ROUTINE
1)	        JAL     R9,IZHOST       : INIT HOST STATUS
1)	        JAL     R5,IZPVC        :INIT PVC TIMER
1)	        JAL     R5,IZSPAM,,       : INIT. SPACE MAN. ROUTINES
1)	        JAL     R10,IZBSC       : INIT BSC NON-LINE STUFF
1)	        JAL     R10,IZBILN      :INIT BISYNC LINE STUFF
1)		JAL	R5,IZLOGO,,	:(DIAL)INIT TIMEOUT ROUTINE TO ALLOW NO LOGIN
1)		JAL	R5,IZDTRO,,	:(DIAL)INIT TIMEOUT ROUTINE TO HOLD DTR DOWN
1)	        JAL     R5,IZIHNG,,     :(DIAL) INITIALIZE HANG TIMER
1)	        JAL     R5,IZMFLG,,     : INIT DISPLAY MENU FLAG
1)	        LHI     R0,3270         : INIT FRONT PANEL
1)	        STH     R0,FPANEL,,
1)	 
1)	:       START FOREGROUND
1)	:       ----------------
1)	STFG
1)	        IF      ISIS2   
1)	        LA      R0,QBEG         : GET F.G. ADDR.
1)	        SVC     SYS,CFGND.      : CONNECT IT
1)	        ELSE
1)	        SVC     2,QBEG          :CONNECT FOREGROUND
1)	        JAL     R0,BCRASH      :CRASH IF WE CAN'T
1)	        EI
1)129	:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

1)	::                  B A C K G R O U N D   E X E C   L O O P                  ::
1)	:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
1)	:       VARIABLE ALLOCATION
1)	:       -------------------
1)	        SEG     0
1)	EXRETA  WS      1               :EXEC RETURN ADDR
1)	        SEG     1
1)	EXEC    SVC     DISMISS,0       :DISMISS
1)	        JAL     R0,TIMOUT,,     :PROCESS PERIODIC ROUTINES
1)	        JAL     R0,INPUT        : ISIS INPUT HANDLER
1)	        JAL     R5,ISCAN,,	: INPUT QUEUE SCANNER
1)	        JAL     R5,RSCAN,,	: RCV SCANNER
1)	        JAL     R5,OSCAN,,	: OUTPUT QUEUE SCANNER
1)		JAL	R5,ZAPPER	: GO ZAP CIRCUITS AS REQUIRED
1)	:
1)		IF	THOST		: DO THOST??
1)	        JAL     R4,GENRCV       : 
1)		EI
1)	:
1)	        J       EXEC            :DO AGAIN
1)	:       COMMON RETURN TO EXEC
1)	:       ---------------------
1)	EXECRT  L       R10,EXRETA,,    :GET EXEC RETURN ADDR
1)	        JR      R10             :RETURN
1)130	:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
1)	::                  F O R E G R O U N D   E X E C   L O O P                  ::
1)	:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
1)	QBEG    JAL     R10,BSCEXC,,    :SERVICE BISYNC
1)	        SVC     DISMISS,0       :DISMISS
1)	        JBS     QBEG            :GO AGAIN
1)131	:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
1)	::                            INITIALIZE BISYNC LINES
1)	:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
1)	:       REGISTER USAGE
1)	:       --------------
1)	IZBILN  IF DYNBUF
1)		JAL	R5,TSTMSG,,	:(EDF)BUILD UP TEST MESSAGE
1)		EI
1)		LIS     R1,NBILIN-1     :INIT BISYNC ROUTINES
1)	IZA110  JAL     R5,BSCEXI,,     :EXEC SCHEDULER
1)	        LCS     R0,1            :INIT EMPTY POINTER TEST NO-MATCH
1)	        JAL     R5,BSCSRV,,     :RCV
1)	        LCS     R0,1            :XMT
1)	        JAL     R5,BSCSXM,,
1)	        SVC     DISMISS,2	: ALLOW CONNECT CTS ARRAY TO END
1)	        LCS     R0,1            :DTR/DSR
1)	        JAL     R5,BSCDTR,,
1)	        LCS     R0,1            :POINT-TO-POINT PROTOCOL
1)	        JAL     R5,BSCPTP,,
1)		IF DYNBUF
1)		JAL	R5,LNBPS,,	:(EDF)SEND TEST MESSAGE TO CHECK LINE SPEED
1)		EI
1)	        SIS     R1,1            :DO ALL LINES
1)	        JGE     IZA110
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

1)	        JR      R10             : RETURN
1)	:       INITIALIZE NON-LINE ORIENTED BSC VARIABLES
1)	:
1)	IZBSC
1)	: FOLLOWING CODE IS COMMENTED OUT FOR NOT DOING ANYTHING AT ALL
1)	:
1)	:	LHI     R2,0FFFF        : SET UP BIT VALUE OF ALL ONES
1)	:        LHI     R1,(NCUB-1)*2
1)	:IZBSC2  
1)	:        SIS     R1,2
1)	:        JGEBS   IZBSC2
1)	:
1)	: INITIALIZE DSP ERROR MESSAGE TO HPAD
1)	:
1)		LHI	R1,SWBDSP
1)		STH	R1,SNDERR
1)	:
1)	: INITIALIZE REPORT TO SUP'S LOG
1)	:
1)		LHI	R1,LOGSWT
1)		STH	R1,SUPSWT
1)	: 
1)	        JR      R10             :RETURN
1)132	 
****
2)133	 
**************
1)136	:
1)	CKPVC   AI      R1,PVCTIM*RATE  :NEXT TIME TO CHECK PVC
****
2)137	: nsr 1238 and 1239 fix problem with option 1 and 2
2)	CKPVC   AI      R1,PVCTIM*RATE  :NEXT TIME TO CHECK PVC
**************
1)136	        ELSE    :PVCOP1,PVCOP2
1)	        LHI     R5,(NDEVB-1)*2	: UPDATE LOGON RETRY BIT MUST HAVE
****
2)137		EI
2)		IF 	PVCOP4		:OPTION 4....REBUILT  NOW
2)	        LHI     R5,(NDEVB-1)*2	: UPDATE LOGON RETRY BIT MUST HAVE
**************
1)136		EI	    :PVCOP3
1)	        SIS     R5,2            :REPEAT THRU ALL HALFWDS OF DEVICES
****
2)137		EI	    :PVCOP4
2)		IF 	PVCOP2		:OPTION 2....REBUILT  NEXT TIMER GOES OFF
2)	        LHI     R5,(NDEVB-1)*2	: UPDATE LOGON RETRY BIT MUST HAVE
2)	CKPV10  LHL     R6,DEVBUSY,R5,	: NO CIRCUIT AND
2)	        XHI     R6,0FFFF
2)	        NH      R6,DEVPVC,R5,	: CONFIGURED WITH PVC AND
2)	        STH     R6,LOGPVC,R5,   : UPDATE FOR RNPVC NEXT TIME
2)		EI	    :PVCOP2
2)		IF 	PVCOP1		:OPTION 1.  LOGON NOW
2)	        LHI     R5,(NDEVB-1)*2	: UPDATE LOGON RETRY BIT MUST HAVE
2)	CKPV10  LHL     R6,DEVBUSY,R5,	: NO CIRCUIT AND
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

2)	        XHI     R6,0FFFF
2)	        NH      R6,DEVPVC,R5,	: CONFIGURED WITH PVC AND
2)	        STH     R6,LOGPVC,R5,   : UPDATE FOR RNPVC NEXT TIME
2)		EI	    :PVCOP1
2)	        SIS     R5,2            :REPEAT THRU ALL HALFWDS OF DEVICES
**************
1)137	RNPVC   PUSH(R5)
1)	        PUSH(RDEV)
1)	        PUSH(RDCB)
1)	:
****
2)138	RNPVC	
2)		PUSH(R5)
2)	        PUSH(RDEV)
2)	        PUSH(RDCB)
2)		PUSH(R1)			:06-19-87 RJR
2)	:
**************
1)137	RNPV90
1)	        POP(RDCB)
****
2)138	RNPV90					:05-19-87 RJR
2)		LIS	R3,0			:RESET BUFFER POINTER FOR IDN
2)		POP(R1)				:RESTORE RETURN ADDRESS FOR ENTNAT
2)	        POP(RDCB)
**************
1)140	        LA      R3,H.MSG        :ADR TO EXTENDED HOST STATUS MSG
1)	        JAL     R5,OCM,,        :SEND IT
****
2)141	        LA      R3,H.MSG,,      :ADR TO EXTENDED HOST STATUS MSG
2)	        JAL     R5,OCM,,        :SEND IT
**************
1)140	        HS      0               :ALIGN H.MSG FOR ORGHST
****
2)141		SEG	0
2)	        HS      0               :ALIGN H.MSG FOR ORGHST
**************
1)141	:       OSCAN - OUTPUT CMD QUEUE SCANNER
****
2)141		SEG	1
2)142	:       OSCAN - OUTPUT CMD QUEUE SCANNER
**************
1)149		GL	CP.CNT,CP.LN,CP.ON,DA.RPT,DA.XPT,DA.RST
****
2)150	:	NSR 1111 LOOK FOR ENQBIT AT OND115-0A
2)	:
2)		GL	CP.CNT,CP.LN,CP.ON,DA.RPT,DA.XPT,DA.RST
**************
1)151	        LA      R6,M.RIND               :Y - SEND RESET INDICATION
1)	        JAL     R5,SNDIIX,,
****
2)152	        LA      R6,M.RIND,,             :Y - SEND RESET INDICATION
2)	        JAL     R5,SNDIIX,,
**************
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

1)151	: RESET INDICATION CANNED MESSAGE
****
2)152		SEG	0
2)	: RESET INDICATION CANNED MESSAGE
**************
1)151	:
****
2)152		SEG	1
2)	:
**************
1)158	        LA      R6,M.ASC                :Y - SELECT ASCII DIALECT
1)	        JAL     R5,SNDIIX,,
****
2)159	        LA      R6,M.ASC,,              :Y - SELECT ASCII DIALECT
2)	        JAL     R5,SNDIIX,,
**************
1)158	M.ASC   SC      /"80"81"80"81/          :SELECT ASCII DIALECT
1)159	:
****
2)159		SEG	0
2)	M.ASC   SC      /"80"81"80"81/          :SELECT ASCII DIALECT
2)		SEG	1
2)160	:
**************
1)166	        THI     R0,ETBBIT!ETXBIT
1)	        JNFS    OND115
****
2)167	        THI     R0,ETBBIT!ETXBIT!ENQBIT
2)	        JNFS    OND115
**************
1)170	:
****
2)171	:       11/19/86 sdw ADDED JAL TO ACKZAP FOR NSR 821
2)	:
**************
1)170	OADM
1)	:       ASCII MODE  ROUTINES FOR ISIS INPUT
1)	 
1)	:       IAD - RCVD ISIS DATA MSG
1)	:       
1)	IAD     PUSH(R5)
1)	 
1)	:       INCROW - INCREMENT ROW NUMBER IN DCB AND END MSG
1)	:       IF SCREEN WRAPAROUND OCCURS
1)	:       IF THE MSG IS ENDED, A DELAY CMD WILL BE PLACED IN THE
1)	:       INPUT QUEUE ALSO. THIS WILL PREVENT OVERWRITING PART OF
1)	:       THE OUTPUT.
1)	INCROW  PUSH(R5)
1)	        LB      R6,DROW,RDCB,           : GET ROW NUMBER
1)	        AIS     R6,1                    : ADVANCE IT
1)	        STB     R6,DROW,RDCB,           :SAVE TEMPORARY ROW NUMBER
1)	        LHL     R5,DPDEV,RDCB,          :CHECK FOR A PRINTER
1)	        LB      R5,DTYPE,R5,
1)	        THI     R5,PRTR
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

1)	        JEFS    INCR10                  :BRANCH IF NOT A PRINTER
1)	        JAL     R5,XAME                 :FOR PRINTERS WE OUTPUT EACH LINE
1)	        J       INCR15
1)	:
1)	INCR10  CLB     R6,DMXROW,RDCB,         : AT END OF DISPLAY AREA ?
1)	        JL      INCR20                  :   N - SKIP
1)	:       RECHED END OF SCREEN - OUTPUT MSG,DELAY
1)	        JAL     R5,XAME                 : END BISYNC MSG AND PUT IN INPUT
1)	                                        : QUEUE
1)	        LHI     R2,DLYCMD               : GET DELAY CMD CODE
1)	        LHL     R5,DDEV,RDCB,           : GET DEVICE NO.
1)	        LHI     R0,FIRBIT!ETXBIT        : SET CONTROL BITS
1)	        PUTCMD(IN,R5,R5)
1)	        RLCMD(IN,R5,R5)
1)	INCR15  LB      R6,DMNROW,RDCB,         : RE-SET ROW NO. AT TOP
1)	        STB     R6,DROW,RDCB,           :SAVE ROW NUMBER
1)	        JAL     R5,XASM                 :START ANOTHER BSC MSG
1)	INCR20
1)	        RETJ(R5)
1)	DLYCMD  EQ      $A-10                   : DELAY CMD CODE
1)171	:       CLRLN - CLEAR  REST OF LINE IN DEVICE BUFFER
1)	:       INPUT - R6 = ROW NUMBER
1)	:	        R11 = ADJUSTED LINE # TO HW
1)	:
1)	CLRLN   PUSH(R5)
1)	        PUSH(R6)
1)	:        LHI     R5,RA.                  : GET RA ORDER CHAR
1)	:        LB      R0,REVTAB,R5            : REVERSE IT
1)	:
1)		LHI	R0,R.RTA		: REVERSED RTA
1)	        JAL     R5,PBCIN                : STORE IT IN BUF.
1)	        POPPSH(R6)                      : RETRIEVE ROW NO.
1)	        LB      R7,DRSIZE,RDCB,         : GET ROW SIZE
1)	        SIS     R7,1                    : SUBTRACT ONE TO GET LAST COL.
1)	        JAL     R5,DOBA                 : STORE BUF. ADDR CHARS
1)	        LIS     R0,0                    : GET REVERSED NULL
1)	        JAL     R5,PBCIN                        : STORE IT
1)	        JAL     R5,PBCIN                : STORE ANOTHER NULL TO ERASE LAST
1)	                                        : COL.
1)	        POP(R6)
1)	        RETJ(R5)
1)	 
1)	:       DSHLN - PUT A LINE OF DASHES IN MSG
1)	:       INPUT - R6 = ROW NUMBER
1)	:	       R11 = ADJUSTED LINE # TO HW
1)	:
1)	DSHLN   PUSH(R5)
1)	        PUSH(R6)
1)	:        LHI     R5,RA.                  : GET RA ORDER CHAR
1)	:        LB      R0,REVTAB,R5            : REVERSE IT
1)	:
1)		LHI	R0,R.RTA		: EVERSED RTA ORDER
1)	        JAL     R5,PBCIN                : STORE IT IN BUF.
1)	        POPPSH(R6)                      : RETRIEVE ROW NO.
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

1)	        LB      R7,DRSIZE,RDCB,         : GET ROW SIZE
1)	        SIS     R7,1                    : SUBTRACT ONE TO GET LAST COL.
1)	        JAL     R5,DOBA                 : STORE BUF. ADDR CHARS
1)	:        LHI     R5,DASH.
1)	:        LB      R0,REVTAB,R5            : GET REVERSE DASH
1)	:
1)		LHI	R0,R.DASH		: REVERSED DASH
1)	        JAL     R5,PBCIN                : STORE IT
1)	        JAL     R5,PBCIN                : STORE ANOTHER NULL TO ERASE LAST
1)	                                        : COL.
1)	        POP(R6)
1)	        RETJ(R5)
1)	 
1)172	:       DOBA - PUT BUFFER ADDRESS CHARS INTO BUF.
1)	:       INPUT - R6 = ROW NO.  , R7 = COL. NO.  (BOTH DESTROYED)
1)	:	       R11 = ADJUSTED LINE # TO HW
1)	:
1)	DOBA    PUSH(R5)
1)	        PUSH(R6)
1)	        LB      R0,DRSIZE,RDCB,         : GET ROW SIZE
1)	        MHR     R6,R0                   : R6 = ROW  NO * LENGTH
1)	        AR      R7,R6                   : R7 = BUFFER ADDRESS
1)	:       NOW CONVERT TO CHARS AND STORE
1)	        PUSH(R7)
1)	        SRHLS   R7,6                    : GET HIGH ORDER BITS INTO PLACE
1)	        JAL     R5,DOBA2                :  CONVERT TO CHAR AND STORE
1)	        POP(R7)
1)	        JAL     R5,DOBA2                : NOW DO LOW ORDER BITS
1)	        POP(R6)
1)	        RETJ(R5)
1)	:       DOSBA2 - TAKE 6 BITS CONVERT TO CHAR AND STORE
1)	DOBA2   PUSH(R5)
1)	        NHI     R7,3F                   : ISOLATE 6 BITS
1)	        LB      R7,SPCHRS,R7            : GET SPECIAL CHAR CORRESPONDING
1)	        LB      R0,REVTAB,R7            : REVERSE IT
1)	        JAL     R5,PBCIN                : STORE IT
1)	        RETJ(R5)
1)	 
1)173	:       XASM - START A BISYNC MSG ( ASCII MODE )
1)	:       SETS UP DIFBA , RBX , RSUM
1)	:
1)	XASM    PUSH(R5)
1)	        PUSH(R1)
1)	        LHI     R5,FIRBIT
1)	        STH     R5,DIR0,RDCB,
1)	        JAL     R5,PBHIN                : START MSG IN BUF.
1)	        STH     RBA,DIFBA,RDCB,         : SAVE FIRST BUF. ADDR
1)	        LA      R1,XASM30               : GET ADDR OF BEGINNING MSG STRING
1)	:       CHECK FOR DEVICE TYPE
1)	:       IF PRINTER , USE PRINTER HEADER
1)	        LHL     R6,DPDEV,RDCB,          : GET DEVICE NO.
1)	        LB      R6,DTYPE,R6,            : GET DEVICE TYPE
1)	        THI     R6,PRTR                 : IS IT A PRINTER ?
1)	        JE      XASM20                  :   N - SKIP
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

1)	        LA      R1,XASM40               :   Y - USE PRINTER HEADER
1)	        LIS     RCOL,0                  :      AND RESET COL AND ROW
1)	        LB      R7,DMNROW,RDCB,
1)	        STB     R7,DROW,RDCB,
1)	XASM20
1)	:
1)	:(NSC)
1)		PUSH(RCOL)
1)		LHL	R11,DADEV,RDCB,		: GET ADJUSTED LINE #
1)	        JAL     R5,PBSIN                : STORE IT
1)		POP(RCOL)
1)	:
1)	        LB      R6,DROW,RDCB,           : GET ROW NO.
1)	        LR      R7,RCOL                 : GET COL. NO.
1)	:
1)		PUSH(R11)
1)		LHL	R11,DADEV,RDCB,		: GET ADJUSTED LINE #
1)	        JAL     R5,DOBA                 : STORE BUF. ADDR CHARS
1)		POP(R11)
1)	:
1)	        POP(R1)
1)	        RETJ(R5)
1)	 
1)	XASM30  HC      4
1)	        BC      ESC.,WCMD,WCCK,SBA.
1)	XASM40  HC      4                       : PRINTER HEADER
1)	        BC      ESC.,EWCMD,WCCP8S,SBA.
1)	 
1)	:       XAME - END BISYNC MSG (ASCII MODE)
1)	:       CLEARS REST OF CURRENT LINE AND ALL OF THE NEXT LINE
1)	:       THEN IT ENDS THE MSG AND PUTS IT THE INPUT QUEUE
1)	:       RBA IS SET TO ZERO SO THAT A NEW MSG WILL BE STARTED
1)	:
1)	XAME    PUSH(R5)
1)	:       CHECK DEVICE TYPE - IF PRINTER,DONT PUT CENT,AND DASHES
1)	        LHL     R6,DPDEV,RDCB,           : GET DEVICE NO.
1)	        LB      R6,DTYPE,R6,            : GET DEVICE TYPE
1)	        THI     R6,PRTR                 : IS IT A PRINTER
1)	        JN      XAME20                  :   Y - SKIP CENT AND DASHES
1)	:       CHECK ROW NUMBER-IF AT END OF SCREEN,DONT OUTPUT CENT +DASHES
1)	        LB      R6,DROW,RDCB,           : GET ROW NO.
1)	        CLB     R6,DMXROW,RDCB,         : COMPARE TO END OF DISPLAY AREA
1)	        JGE     XAME20                  : SKIP IF AT END
1)	        LHI     R5,CENT.                : PUT CENT CHAR AT CURRENT
1)	        LB      R0,REVTAB,R5            : ROW AND COLUMN
1)	:(NSC)
****
2)171	OADM    PUSH(R5)
2)	        PUSH(R2)
2)	        PUSH(R3)
2)	        PUSH(R9)
2)	        JAL     R4,RXTIM,,	: END TIMER 
2)	        SBT     RDEV,INGAT,,    : OPEN INPUT GATE
2)	        JAL     R5,IDTOR,,      : END CURRENT MSG
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

2)	        LA      R1,OAD150,,     : GET ADDR OF UNLOCK KBD MSG
2)	        JAL     R5,XLERM,,	: SEND TO TERMINAL
2)	        POP(R9)
2)	        POP(R3)
2)	        POP(R2)
2)	        LB      R0,BBUFER+3,RBA,        : GET AID CHAR
2)	        STB     R0,DOAID,RDCB,          : STORE IT IN DCB
2)	        CHI     R0,AIDENT               : ENTER KEY ?
2)	        JE      OADM1
2)	        CHI     R0,AIDPF1               : PF 1 KEY  ?
2)	        JE      OADM1
2)	        CLHI    R0,AIDPF2               : PF 2 KEY ?
2)	        JE      OAD250
2)	        CLHI    R0,AIDPA2               : PA 2 KEY ?
2)	        JE      OAD250
2)	        CLHI    R0,AIDPF4               : PF 4 KEY ?
2)	        JE      OAD400
2)	        CLHI    R0,AIDCLR               : CLEAR KEY ?
2)	        JE      OAD400
2)	        CLHI    R0,AIDPF5               : PF 5 KEY ?
2)	        JE      OAD300
2)	        CLHI    R0,AIDPA1               : PA 1 KEY ?
2)	        JE      OAD300
2)	 
2)	:       OTHER KEY - DROP THE MSG
2)	        JAL     R5,PBBC,,               : FREE THE BUF.
2)	        ADVCMD(OUT,RDEV,RDEV)
2)	        RETJ(R5)
2)	:       ENTER OR PF1 PRESSED
2)	OADM1
2)	        LHI     RBX,-BBFLSZ+1+6
2)	        LB      R0,BBUFER+BBFLSZ-2+1,RBA,RBX,   : GET FOURTH BYTE
2)	        CHI     R0,SBA.
2)	        JNFS    OADM2
2)	        AIS     RBX,3                   : SKIP SBA SEQUENCE
2)	OADM2
2)	        LIS     RMASK,0                 : INIT MASK FOR BITS 1,2
2)	        J       OAD020                  : PROCESS THE MSG
2)	 
2)	:       OADS - STARTING A MSG SEGMENT
2)	OADS    PUSH(R5)
2)	        LHI     RBX,-BBFLSZ+1+4         : INIT OFFSET TO FIRST DATA CHAR
2)	        J       OAD020                  : PROCESS THE SEGMENT
2)	 
2)	:       OADR - RESTART AFTER STOP FOR FULL RING
2)	OADR    PUSH(R5)
2)	        LHL     RBA,DORBA,RDCB,         : GET CURRENT BUF. ADDR
2)	        LH      RBX,DORBX,RDCB,         : GET OFFSET
2)	        LB      RMASK,DOMSK,RDCB,
2)	        J       OAD020                  : RESTART PROCESSING
2)	 
2)	:       OADF - FLUSH SEGMENTS UNTIL ETX IS FOUND THE RESTORE
2)	:       DODRA TO OADM
2)	OADF    PUSH(R5)
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

2)	OADF10  JAL     R4,GETLST               : GET LAST CHAR
2)	        CHI     R0,ETX                  : ETX ?
2)	        JNFS    OADF20                  :  N - SKIP
2)	        LI      R0,OADM-PSEG            : RESET DATA ROUTINE ADDRESS
2)	        STH     R0,DODRA,RDCB,          : IN DCB
2)	        J       OADFX
2)	OADF20
2)	        LI      R0,OADF-PSEG            : SET DATA ROUTINE ADDR
2)	        STH     R0,DODRA,RDCB,          : TO THIS ROUTINE
2)	        J       OADFX                   : NOW FLUSH IT
2)	 
2)	:       GETLST - GET LAST CHAR IN MSG (ETB/ETX)
2)	:       DUMMY FOR NOW (RETURNS ETX)
2)	GETLST  LHI     R0,ETX
2)	        JR      R4
2)	 
2)	:       OAD250 - SEND BREAK MSG
2)	OAD250  JAL     R5,PBBC,,               : FREE BUF. IN THIS MSG
2)	        ADVCMD(OUT,RDEV,RDEV)
2)	        LIS     R0,3
2)	        LHL     R1,DPORT,RDCB,          : GET PORT NO.
2)	        LHI     R2,BRKMSG               : SEND BREAK MSG
2)	        JAL     R4,SLOR,,
2)	        JAL     R4,ELOR,,
2)	        POP(R5)
2)	        J       4,R5                    : RETURN
2)	OAD300  LHI     R5,DZ.3                 :"DROPPED BY USER" REASON CODE
2)	        STB     R5,DZAP,RDCB,           :STORE FOR DISCONNECT MSG
2)	        JAL     R5,AZAP                 : ZAP THE DEVICE
2)	        POP(R5)
2)	        J       4,R5
2)	 
2)	 
2)	:       PF4 OR CLEAR KEY PRESSED - RESTORE SCREEN
2)	OAD400  JAL     R5,PBBC,,               : FREE BUF.
2)	        ADVCMD(OUT,RDEV,RDEV)
2)	        JAL     R5,XASCN1               : SEND INITIAL ASCII SCREEN
2)	        JAL     R5,FLINP                : FLUSH PARTIAL INPUT SCREEN
2)	        LIS     R6,0                    : INIT. COL = 0
2)	        STB     R6,DCOL,RDCB,
2)	        LB      R6,DMNROW,RDCB,         : INIT. ROW = TOP
2)	        STB     R6,DROW,RDCB,
2)	        RETJ(R5)                        : RETURN
2)	 
2)	:       EXIT POINTS
2)	 
2)	:       OAD100 - OUTPUT LIMIT REACHED , WAIT
2)	OAD100  
2)	        STH     RBA,DORBA,RDCB,         : SAVE BUF. ADDR
2)	        STH     RBX,DORBX,RDCB,         : SAVE OFFSET
2)	        STB     RMASK,DOMSK,RDCB,       : SAVE BIT 1,2 MASK
2)	        LI      R0,OADR-PSEG            : RESTORE ROUTINE ADDRESS
2)	        STH     R0,DODRA,RDCB,          : IN DCB
2)	        LHL     RDEV,DDEV,RDCB,         : RELOAD DEVICE NUMBER
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

2)	        RETJ(R5)
2)	 
2)	:       OADFX - FLUSH DATA MSG AND EXIT
2)	OADFX   LHL     RDEV,DDEV,RDCB,         : RELOAD DEVICE NO.
2)	        PKCMD(OUT,RDEV,RDEV)
2)	        ADVCMD(OUT,RDEV,RDEV)
2)	        JAL     R5,PBBC,,               : FREE BUF.
2)	        POP(R5)
2)	        J       4,R5                    : SKIP RETURN - GET NEXT CMD
2)	:
2)	:	XASCN1 - SEND INITIAL ASCII SCREEN DIRECTLY TO XMT QUEUE
2)	:
2)	XASCN1	PUSH(R5)
2)	:(NSC)
2)		LHL	R5,DDEV,RDCB,	
2)		LB	R5,DEVHST,R5,
2)		SLLS	R5,2
2)		LB	R6,DRSIZE,RDCB,		:GET ROW SIZE
2)		CHI	R6,$A40			:SMALL SCREEN
2)		JNFS	XASC30			: N - SKIP
2)	:(NSC)
2)	: OFFSET SCREEN ADR BY HOST TYPE
2)	;
2)		L	R1,ASC480,R5,		:GET ADDR OF SMALL SCREEN MSG
2)		JFS	XASC40
2)	XASC30	L	R1,ASC192,R5,		:GET ADDR OF REGULAR SCREEN MSG
2)	:
2)	XASC40	LHI	R0,FIRBIT
2)		STH	R0,DIR0,RDCB,
2)	:(NSC)
**************
1)173	        JAL     R5,PBCIN
1)		POP(R11)
1)	:
1)	        LR      R0,RCOL                 : CHECK FOR END OF ROW
1)	        AIS     R0,2                    : ADVANCE ONE FOR CENT,ONE TO
1)	                                        : COMPENSATE FOR ZERO ORIGIN
1)	        CLB     R0,DRSIZE,RDCB, 
1)	        JGEFS   XAME05                  : SKIP IF AT END OF ROW
1)	        LB      R6,DROW,RDCB,           : GET ROW NO.
1)	:(NSC)
****
2)171		JAL	R5,PBMXMT		: BUILD MSG
2)		POP(R11)
2)	:
2)		LHL	R0,DIR0,RDCB,
2)		OHI	R0,ETXBIT
2)		PUTCMD(XMT,RDEV,RDEV)
2)		RLCMD(XMT,RDEV,RDEV)
2)		RETJ(R5)
2)	 
2)172	:       OAD020 - PROCESS THE MSG
2)	OAD020
2)	:       START AN ISIS OUTPUT MSG
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

2)	        PUSH(R1)
2)	        PUSH(R2)
2)	        PUSH(R3)
2)	        LHL     R1,DPORT,RDCB,          : GET PORT NO.
2)	        LB      R2,XLIMIT,R1,           : GET MSG. LENGTH LIMIT
2)	        LR      R0,R2
2)	        AIS     R0,3                    : R0 = LEN.+3 BYTE OVERHEAD
2)	        JAL     R4,SLOR,,               : START MAX. LENGTH MSG.
2)	        LB      R10,XLIMIT,R1,          : GET MSG. LENGTH AGAIN
2)		POP(R3)
2)	        POP(R2)
2)	        JAL     R5,OACOPY               : COPY CHARS TO RING
2)	        JAL     R4,ELODR,,              : END ISIS MSG
2)	        POP(R1)
2)	        SIS     RBX,1                   : BACK UP OFFSET
2)	        JAL     R4,GETBC                : AND GET ETB/ETX CHAR AGAIN
2)	        CHI     R0,ETB                  : ETB ?
2)	        JE      OAD40                   :   Y - EXIT LOOP
2)	        CHI     R0,ETX                  : ETX ?
2)	        JN      OAD100                  :   N - END OF BISYNC MSG NOT 
2)	                                        :       REACHED - WAIT
2)	:       ETX FOUND - END OF COMPLETE BISYNC MSG
2)	        LI      R0,OADM-PSEG            : SET DATA RTE ADDR TO START OF MSG
2)	        STH     R0,DODRA,RDCB,          : STORE IN DCB
2)	        J       OADFX                   : FLUSH MSG AND EXIT
2)	 
2)	:       ETB FOUND - END OF MSG SEGMENT
2)	OAD40   LI      R0,OADS-PSEG            : SET DATA ROUTINE ADDR
2)	        STH     R0,DODRA,RDCB,          : FOR NEXT SEGMENT OF MSG
2)	        J       OADFX
2)	 
2)	        SEG     0
2)	:       OAD150 - KEYBOARD UNLOCK MSG
2)	OAD150  HC      2
2)	        BC      ESC.,EAUCMD
2)	        SEG     1
2)	 
2)173	 
2)	:       OACOPY - COPY CHARS TO OUTPUT RING (ASCII MODE)
2)	:       EXIT WHEN MSG CNT = 0  OR ETX/ETB FOUND
2)	:       INPUT - RBA,RBX = BUF. ADDR,OFFSET  R10=ISIS BYTE CNT
2)	OACOPY
2)	OACOP1  JAL     R4,GETBC                : GET NEXT CHAR
2)	        LR      R6,R0
2)	        LB      R0,EBCASC,R6            : TRANSLATE TO ASCII
2)	        LR      R0,R0                   : SET COND. CODE
2)	        JE      OACOP4                  :   SPECIAL HANDLING NEEDED ?
2)	        XR      R0,RMASK                : SET BITS 1,2
2)	        LIS     RMASK,0                 : NOW SET MASK TO ZER0
2)	OACOP2  OHI     R0,80                   : TURN ON HIGH ORDER BIT
2)	        JAL     R4,PUTCH,,              : PUT CHAR INTO RING
2)	        SIS     R10,1                   : REDUCE BYTE CNT
2)	        JG      OACOP1                  :   NOT ZERO - REPEAT
2)	        JR      R5                      : RETURN
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

2)	 
2)	:       SPECIAL HANDLING FOR CTL CHARS , CENT , FIELD MARK
2)	OACOP4  CHI     R6,SBA.                 : SBA CHAR ?
2)	        JE      OAC010                  :   Y -
2)	        CHI     R6,ETX                  : ETX ?
2)	        JE      OAC020                  :   Y -
2)	        CHI     R6,ETB                  : ETB ?
2)	        JE      OAC030                  :   Y -
2)	        CHI     R6,CENT.                : CENT CHAR ?
2)	        JE      OAC040
2)	        CHI     R6,FM.                  : FIELD MARK CHAR ?
2)	        JE      OAC050
2)	:       DEFAULT CASE - JUST DROP IT AND RESET MASK
2)	        LIS     RMASK,0
2)	        J       OACOP1                  : GO ON TO NEXT CHAR
2)	 
2)174	:       SBA CHAR
2)	OAC010  LIS     RMASK,0
2)	        JAL     R4,GETBC                : FLUSH 2 FOLLOWING ADDR CHARS
2)	        JAL     R4,GETBC
2)	        LHI     R0,ACR                  : OUTPUT A CARRIAGE RETURN
2)	        J       OACOP2
2)	 
2)	:       ETX -  END OF BISYNC MSG
2)	OAC020  LIS     RMASK,0
2)	        LB      R6,DOAID,RDCB,          : GET AID CHAR
2)	        CHI     R6,AIDENT               : ENTER KEY PRESSED ?
2)	        JNR     R5                      :   N - RETURN FROM OACOPY
2)	:       ENTER KEY PRESSED , SEND CR TO RING THEN EXIT
2)	        LHI     R0,ACR
2)	        JAL     R4,PUTCH,,
2)	        JR      R5
2)	 
2)	:       ETB - END OF BISYNC MSG SEGMENT
2)	OAC030  JR      R5                      : RETURN FROM OACOPY
2)	 
2)	:       CENT CHAR
2)	OAC040  XHI     RMASK,$020              : COMPLEMENT BIT 2
2)	        J       OACOP1                  : GO ON TO NEXT CHAR
2)	 
2)	:       FIELD MARK
2)	OAC050  XHI     RMASK,$040              : COMPLEMENT BIT 1
2)	        J       OACOP1                  : GO ON TO NEXT CHAR
2)	 
2)175	:       ASCII MODE  ROUTINES FOR ISIS INPUT
2)	 
2)	:       IAD - RCVD ISIS DATA MSG
2)	:       
2)	IAD     PUSH(R5)
2)	        LR      R10,R2                  : PUT ISIS MSG CNT IN R10
2)	        LHL     RDEV,DDEV,RDCB,         :GET DEVICE NUMBER
2)	:	COUNT CHARACTERS IF REQUIRED
2)		LH	R0,CP.ON,,		:IS CPS TRACE ON
2)		JLFS	IAD10			:IF NOT, SKIP AHEAD
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

2)		LH	R0,CP.LN,,		:FOR LINE OR SLOT
2)		JLFS	IAD09			:IF SLOT, SKIP AHEAD
2)		CLB	R0,DEVLN,RDEV		:IS THIS RIGHT LINE
2)		JNFS	IAD10			:IF NOT, SKIP AHEAD
2)	IAD09	AM	R10,CP.CNT,,		:ADD IN CHARACTERS
2)	IAD10	JAL     R4,RIDTIM,,		:RESET INPUT DATA TIMER
2)	        LHL     RBA,DIRBA,RDCB,         : GET CURRENT BUF. ADDR
2)	        LH      RBX,DIRBX,RDCB,         : GET OFFSET
2)	        LHL     RSUM,DIRCNT,RDCB,       : GET ACCUMULATED CHECKSUM
2)	        LB      RCOL,DCOL,RDCB,         : GET COLUMN NO.
2)	IAD20   LR      RBA,RBA                 : NEED TO START NEW MSG ?
2)	        JNFS    IAD25                   :   N - SKIP
2)	        JAL     R5,XASM                 : START NEW BISYNC MSG
2)	IAD25   JAL     R4,GETCH,,              : GET NEXT CHAR FROM RING
2)	        NHI     R0,7F                   : SET BIT 0 = 0
2)	        LR      R7,R0
2)	        LB      R6,ASCEBC,R7            : TRANSLATE TO EBCDIC
2)	        LB      R0,REVTAB,R6            : REVERSE THE CHAR
2)	        LR      R0,R0                   : SET COND. CODE
2)	        JE      IAD100                  : SPECIAL HANDLING NEEDED ?
2)	:       NORMAL HANDLING FOR ASCII DATA CHAR
2)	        AIS     RCOL,1                  : ADVANCE COLUMN NUMBER
2)	        CLB     RCOL,DRSIZE,RDCB,       : END OF ROW ?
2)	        JLFS    IAD28                   :   N - SKIP
2)	:       LINE HAS WRAPPED AROUND
2)	        LIS     RCOL,0                  : SET COLUMN = 0
2)	        JAL     R5,INCROW               : INCREMENT THE ROW NUMBER
2)	IAD28   STB     R7,DLC,RDCB,            : UPDATE LAST CHAR
2)	:
2)	:(NSC)
2)		PUSH(RCOL)
2)		LHL	R11,DADEV,RDCB,		: GET ADJUSTED LINE # FOR CRC
2)	        JAL     R5,PBCIN                : PUT CHAR INTO BUFFER
2)		POP(RCOL)
2)	:
2)	IAD30   SIS     R10,1                   : REDUCE ISIS MSG CNT
2)	        JG      IAD20                   : REPEAT UNTIL CNT = 0
2)	 
2)	:       END OF ISIS DATA MSG - SAVE REGISTERS AND EXIT
2)	IAD40   STH     RBA,DIRBA,RDCB,         : CURRENT BUF. ADDR
2)	        STH     RBX,DIRBX,RDCB,         : OFFSET
2)	        STH     RSUM,DIRCNT,RDCB,       : ACCUMULATED CHECKSUM
2)	        STB     RCOL,DCOL,RDCB,         : SAVE COLUMN NO.
2)	        LHL     R5,DPDEV,RDCB,          :CHECK ON A PRINTER
2)	        LB      R5,DTYPE,R5,
2)	        THI     R5,PRTR
2)	        JNFS    IAD50
2)	        LHL     RDEV,DDEV,RDCB,
2)	        JAL     R4,SIDTIM,,		: SET INPUT DATA TIMER
2)	IAD50
2)	:       EXIT TO SCANNER
2)	        RETJ(R5)
2)	 
2)176	:       SPECIAL HANDLING FOR INPUT CONTROL CHARS
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

2)	IAD100  CHI     R7,ACR                  : CARRIAGE RETURN ?
2)	        JE      IAD110
2)	        CHI     R7,ALF                  : LINE FEED ?
2)	        JE      IAD120
2)	        CHI     R7,ABS                   BACK SPACE
2)	        JE      IAD130
2)	        CHI     R7,ABEL                 : BELL CHAR ?
2)	        JE      IAD140
2)	        CHI     R7,AFF          : FORM FEED ?
2)	        JE      IAD150
2)	:       DEFAULT CASE - UPDATE LAST CHAR AND GO ON TO NEXT CHAR
2)	        STB     R7,DLC,RDCB,    : UPDATE LAST CHAR PROCESSED
2)	        J       IAD30
2)	 
2)	:       CR - CLEAR REST OF LINE AND SET COL,ROW TO START OF NEW LINE
2)	IAD110  STB     R7,DLC,RDCB,            : UPDATE LAST CHAR
2)	        LB      R6,DROW,RDCB,           : GET ROW NUMBER
2)	:       CHECK FOR END OF LINE BEFORE CLEARING LINE
2)	        LB      R0,DRSIZE,RDCB,         : GET ROW SIZE
2)	        SIS     R0,1                    : MAX COL. = ONE LESS
2)	        CR      RCOL,R0                 : COMPARE TO COL.NO.
2)	        JGEFS   IAD115                  :JUMP IF AT LAST COLUMN
2)	:(NSC)
**************
1)173	        JAL     R5,CLRLN                : CLEAR REST OF CURRENT LINE
1)		POP(R11)
1)	:
1)	XAME05  LB      R6,DROW,RDCB,           : GET ROW NO. AGAIN
1)	        AIS     R6,1                    : ADVANCE ROW NUMBER BY ONE
1)	        CLB     R6,DMXROW,RDCB,         : AT END OF DISPLAY AREA ?
1)	        JGE     XAME20                  :   Y - SKIP
1)	:
1)						: (AND TAKE CARE OF END OF SCREEN)
1)	:(NSC)
1)		PUSH(R11)
1)		LHL	R11,DADEV,RDCB,		: GET ADJUSTED LINE #
1)	        JAL     R5,DSHLN                : CLEAR NEXT LINE
1)		POP(R11)
1)	:
1)	XAME20  LHI     R0,RETX                 : GET REVERSED ETX
1)	:
****
2)176	        JAL     R5,CLRLN                : CLEAR REST OF LINE
2)		POP(R11)
2)	:
2)	        JFS     IAD118
2)	IAD115  LIS     R0,0                    :GET REVERSED NULL
2)	:
**************
1)173		LHL	R11,DADEV,RDCB,		: GET ADJUSTED LINE #
****
2)176		LHL	R11,DADEV,RDCB,		: PREPARE FOR CRC MACRO
2)	        JAL     R5,PBCIN                :CLEAR LAST COLUMMN OF ROW
2)		POP(R11)
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

2)	:
2)	IAD118
2)	        LIS     RCOL,0                  : SET COLUMN = 0
2)	        JAL     R5,INCROW               : NEW ROW
2)	        J       IAD30                   : GO ON TO NEXT CHAR
2)	 
2)	:       LINE FEED - CLEAR REST OF LINE , ADVANCE ROW NUMBER
2)	:       AND CLEAR LINE TO COLUMN NUMBER
2)	IAD120  LB      R6,DLC,RDCB,    : GET LAST CHAR
2)	        CHI     R6,ACR          : WAS IT A CARRIAGE RETURN ?
2)	        JE      IAD125                  :   Y - DONT DO ANYTHING
2)	        STB     R7,DLC,RDCB,            : UPDATE LAST CHAR
2)	        LB      R6,DROW,RDCB,           : CLEAR REST OF LINE
2)	:       CHECK FOR END OF LINE BEFORE CLEARING IT
2)	        LB      R0,DRSIZE,RDCB,         : GET ROW SIZE
2)	        SIS     R0,1                    : MAX COL = ONE LESS
2)	        CR      RCOL,R0                 : COMPARE TO COL.NO.
2)	        JGEFS   IAD122                  :   SKIP IF AT END OF LINE
2)	:(NSC)
2)		PUSH(R11)
2)		LHL	R11,DADEV,RDCB,		: GET ADJUSTED LINE #
2)	        JAL     R5,CLRLN
2)		POP(R11)
2)	:
2)	        JFS     IAD123
2)	IAD122  LIS     R0,0                    :GET REVERSED NULL
2)	:
2)	:(NSC)
2)		PUSH(R11)
2)		LHL	R11,DADEV,RDCB,		: GET ADJUSTED LLINE#
2)	        JAL     R5,PBCIN                :CLEAR LAST COLUMN OF ROW
2)		POP(R11)S
2)	:
2)	IAD123
2)	        PUSH(RCOL)              :SAVE CURRENT COLUMN
2)	        LIS     RCOL,0          :RESET RCOL IF GOING TO NEXT SCREEN
2)	        JAL     R5,INCROW               : NEW ROW
2)	        POP(RCOL)                       :RESTORE CURRENT COLUMN NUMBER
2)	        LR      RCOL,RCOL               : CHECK COLUMN NUMBER
2)	        JE      IAD30                   :   0 - THRU
2)	:       NOW CLEAR THE NEW LINE UP TO COLUMN NUMBER
2)	:        LHI     R7,RA.                  : RA ORDER CHAR
2)	:        LB      R0,REVTAB,R7            : REVERSE IT
2)	:
2)		LHI	R0,R.RA			: REVERSED RTA
2)	:(NSC)
2)		PUSH(R11)
2)		LHL	R11,DADEV,RDCB,		: GET ADJUSTED LINE#
2)	        JAL     R5,PBCIN                : PUT IT IN BUF.
2)		POP(R11)
2)	:
2)	        LB      R6,DROW,RDCB,           : GET ROW NUMBER
2)	        LR      R7,RCOL                 : GET COLUMN NO. IN R7
2)	:(NSC)
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

2)		PUSH(R11)
2)		LHL	R11,DADEV,RDCB,
2)	        JAL     R5,DOBA                 : PUT BUFFER ADDR INTO BUF.
2)	        LIS     R0,0                    : R0 = NULL REVERSED
2)	        JAL     R5,PBCIN                        : PUT IT IN BUF.
2)		POP(R11)
2)	:
2)	        J       IAD30
2)	IAD125  STB     R7,DLC,RDCB,            : LF AFTER CR , UPDATE LAST 
2)	        J       IAD30                   : CHAR AND GO ON
2)	 
2)	:       BACK SPACE - BACK UP COLUMN NUMBER UNLESS IN COL. 0
2)	:       AND PUT OUT AN SBA SEQUENCE
2)	IAD130  STB     R7,DLC,RDCB,            : UPDATE LAST CHAR
2)	        SIS     RCOL,1                  : BACK UP COL. NO.
2)	        JGEFS   IAD135                  : SKIP IF COL. NO. > 0
2)	        LIS     RCOL,0                  : SET COLUMN = 0
2)	        J       IAD30                   : WE CANT BACK UP - SO GO TO
2)	:IAD135  LHI     R7,SBA.                 : GET SBA CHAR
2)	:        LB      R0,REVTAB,R7            : REVERSE IT
2)	:
2)	IAD135
2)		LHI	R0,R.SBA		: REVERSED SBA
2)	:(NSC)
2)		PUSH(R11)
2)		LHL	R11,DADEV,RDCB,		: GET ADJUSTED LINE #
2)	        JAL     R5,PBCIN                : PUT IN IN BUF.
2)		POP(R11)
2)	:
2)	        LB      R6,DROW,RDCB,           : GET ROW NO.
2)	        LR      R7,RCOL                 : GET COL. NO. IN R7
2)	:(NSC)
2)		PUSH(R11)
2)		LHL	R11,DADEV,RDCB,		: GET ADJUSTED LINE #
2)	        JAL     R5,DOBA                 : PUT BUF. ADDR. INTO BUF.
2)		POP(R11)
2)	:
2)	        J       IAD30
2)	 
2)	:       BELL CHAR
2)	IAD140  STB     R7,DLC,RDCB,            : UPDATE LAST CHAR
2)	        LHL     R6,DIFBA,RDCB,          : GET FIRST BUF. ADDR.
2)	        LB      R7,BBUFER+3,R6,         : GET WCC CHAR
2)	        LB      R7,REVTAB,R7            : REVERSE IT (TO NORMAL)
2)	        OI      R7,WCCALM               : TURN ON ALARM BIT
2)	        LB      R0,REVTAB,R7            : REVERSE IT
2)	        STB     R0,BBUFER+3,R6,         : REPLACE ORIGINAL WCC CHAR
2)	        J       IAD30
2)	 
2)	:       FORM FEED - ERASE TO END OF OUTPUT AREA,WRITE MSG
2)	:       AND SET ROW AND COLUMN TO TOP OF OUTPUT AREA FOR NEW MSG
2)	IAD150  STB     R7,DLC,RDCB,            : UPDATE LAST CHAR
2)	        LHI     R0,NULL.                : OUTPUT A NULL
2)	:(NSC)
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

2)		PUSH(R11)
2)		LHL	R11,DADEV,RDCB,		: GET ADJUSTED LINE #
2)	        JAL     R5,PBCIN
2)	:
2)	:        LHI     R7,PT.                  : AND THEN A PROGRAM TAB
2)	:        LB      R0,REVTAB,R7
2)	:
2)		LHI	R0,R.PT		: REVERSED TAB
2)	        JAL     R5,PBCIN
2)		POP(R11)
2)	:
2)	        LB      R7,DMXROW,RDCB,         : SET ROW NUMBER TO END OF AREA
2)	        STB     R7,DROW,RDCB,
2)	        LIS     RCOL,0                  : SET COLUMN NUMBER = 0
2)	        JAL     R5,INCROW               : ADVANCE ROW NUMBER TO FORCE
2)	                                        : END OF SCREEN WRITE
2)	        LB      R7,DMNROW,RDCB,         : SET ROW NUMBER TO TOP OF AREA
2)	        STB     R7,DROW,RDCB,
2)	        LIS     RCOL,0
2)	        J       IAD30
2)	 
2)	 
2)	:       INCROW - INCREMENT ROW NUMBER IN DCB AND END MSG
2)	:       IF SCREEN WRAPAROUND OCCURS
2)	:       IF THE MSG IS ENDED, A DELAY CMD WILL BE PLACED IN THE
2)	:       INPUT QUEUE ALSO. THIS WILL PREVENT OVERWRITING PART OF
2)	:       THE OUTPUT.
2)	INCROW  PUSH(R5)
2)	        LB      R6,DROW,RDCB,           : GET ROW NUMBER
2)	        AIS     R6,1                    : ADVANCE IT
2)	        STB     R6,DROW,RDCB,           :SAVE TEMPORARY ROW NUMBER
2)	        LHL     R5,DPDEV,RDCB,          :CHECK FOR A PRINTER
2)	        LB      R5,DTYPE,R5,
2)	        THI     R5,PRTR
2)	        JEFS    INCR10                  :BRANCH IF NOT A PRINTER
2)	        JAL     R5,XAME                 :FOR PRINTERS WE OUTPUT EACH LINE
2)	        J       INCR15
2)	:
2)	INCR10  CLB     R6,DMXROW,RDCB,         : AT END OF DISPLAY AREA ?
2)	        JL      INCR20                  :   N - SKIP
2)	:       RECHED END OF SCREEN - OUTPUT MSG,DELAY
2)	        JAL     R5,XAME                 : END BISYNC MSG AND PUT IN INPUT
2)	                                        : QUEUE
2)	        LHI     R2,DLYCMD               : GET DELAY CMD CODE
2)	        LHL     R5,DDEV,RDCB,           : GET DEVICE NO.
2)	        LHI     R0,FIRBIT!ETXBIT        : SET CONTROL BITS
2)	        PUTCMD(IN,R5,R5)
2)	        RLCMD(IN,R5,R5)
2)	INCR15  LB      R6,DMNROW,RDCB,         : RE-SET ROW NO. AT TOP
2)	        STB     R6,DROW,RDCB,           :SAVE ROW NUMBER
2)	        JAL     R5,XASM                 :START ANOTHER BSC MSG
2)	INCR20
2)	        RETJ(R5)
2)	DLYCMD  EQ      $A-10                   : DELAY CMD CODE
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

2)177	:       CLRLN - CLEAR  REST OF LINE IN DEVICE BUFFER
2)	:       INPUT - R6 = ROW NUMBER
2)	:	        R11 = ADJUSTED LINE # TO HW
2)	:
2)	CLRLN   PUSH(R5)
2)	        PUSH(R6)
2)	:        LHI     R5,RA.                  : GET RA ORDER CHAR
2)	:        LB      R0,REVTAB,R5            : REVERSE IT
2)	:
2)		LHI	R0,R.RTA		: REVERSED RTA
2)	        JAL     R5,PBCIN                : STORE IT IN BUF.
2)	        POPPSH(R6)                      : RETRIEVE ROW NO.
2)	        LB      R7,DRSIZE,RDCB,         : GET ROW SIZE
2)	        SIS     R7,1                    : SUBTRACT ONE TO GET LAST COL.
2)	        JAL     R5,DOBA                 : STORE BUF. ADDR CHARS
2)	        LIS     R0,0                    : GET REVERSED NULL
2)	        JAL     R5,PBCIN                        : STORE IT
2)	        JAL     R5,PBCIN                : STORE ANOTHER NULL TO ERASE LAST
2)	                                        : COL.
2)	        POP(R6)
2)	        RETJ(R5)
2)	 
2)	:       DSHLN - PUT A LINE OF DASHES IN MSG
2)	:       INPUT - R6 = ROW NUMBER
2)	:	       R11 = ADJUSTED LINE # TO HW
2)	:
2)	DSHLN   PUSH(R5)
2)	        PUSH(R6)
2)	:        LHI     R5,RA.                  : GET RA ORDER CHAR
2)	:        LB      R0,REVTAB,R5            : REVERSE IT
2)	:
2)		LHI	R0,R.RTA		: EVERSED RTA ORDER
2)	        JAL     R5,PBCIN                : STORE IT IN BUF.
2)	        POPPSH(R6)                      : RETRIEVE ROW NO.
2)	        LB      R7,DRSIZE,RDCB,         : GET ROW SIZE
2)	        SIS     R7,1                    : SUBTRACT ONE TO GET LAST COL.
2)	        JAL     R5,DOBA                 : STORE BUF. ADDR CHARS
2)	:        LHI     R5,DASH.
2)	:        LB      R0,REVTAB,R5            : GET REVERSE DASH
2)	:
2)		LHI	R0,R.DASH		: REVERSED DASH
2)	        JAL     R5,PBCIN                : STORE IT
2)	        JAL     R5,PBCIN                : STORE ANOTHER NULL TO ERASE LAST
2)	                                        : COL.
2)	        POP(R6)
2)	        RETJ(R5)
2)	 
2)178	:       DOBA - PUT BUFFER ADDRESS CHARS INTO BUF.
2)	:       INPUT - R6 = ROW NO.  , R7 = COL. NO.  (BOTH DESTROYED)
2)	:	       R11 = ADJUSTED LINE # TO HW
2)	:
2)	DOBA    PUSH(R5)
2)	        PUSH(R6)
2)	        LB      R0,DRSIZE,RDCB,         : GET ROW SIZE
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

2)	        MHR     R6,R0                   : R6 = ROW  NO * LENGTH
2)	        AR      R7,R6                   : R7 = BUFFER ADDRESS
2)	:       NOW CONVERT TO CHARS AND STORE
2)	        PUSH(R7)
2)	        SRHLS   R7,6                    : GET HIGH ORDER BITS INTO PLACE
2)	        JAL     R5,DOBA2                :  CONVERT TO CHAR AND STORE
2)	        POP(R7)
2)	        JAL     R5,DOBA2                : NOW DO LOW ORDER BITS
2)	        POP(R6)
2)	        RETJ(R5)
2)	:       DOSBA2 - TAKE 6 BITS CONVERT TO CHAR AND STORE
2)	DOBA2   PUSH(R5)
2)	        NHI     R7,3F                   : ISOLATE 6 BITS
2)	        LB      R7,SPCHRS,R7            : GET SPECIAL CHAR CORRESPONDING
2)	        LB      R0,REVTAB,R7            : REVERSE IT
2)	        JAL     R5,PBCIN                : STORE IT
2)	        RETJ(R5)
2)	 
2)179	:       XASM - START A BISYNC MSG ( ASCII MODE )
2)	:       SETS UP DIFBA , RBX , RSUM
2)	:
2)	XASM    PUSH(R5)
2)	        PUSH(R1)
2)	        LHI     R5,FIRBIT
2)	        STH     R5,DIR0,RDCB,
2)	        JAL     R5,PBHIN                : START MSG IN BUF.
2)	        STH     RBA,DIFBA,RDCB,         : SAVE FIRST BUF. ADDR
2)	        LA      R1,XASM30               : GET ADDR OF BEGINNING MSG STRING
2)	:       CHECK FOR DEVICE TYPE
2)	:       IF PRINTER , USE PRINTER HEADER
2)	        LHL     R6,DPDEV,RDCB,          : GET DEVICE NO.
2)	        LB      R6,DTYPE,R6,            : GET DEVICE TYPE
2)	        THI     R6,PRTR                 : IS IT A PRINTER ?
2)	        JE      XASM20                  :   N - SKIP
2)	        LA      R1,XASM40               :   Y - USE PRINTER HEADER
2)	        LIS     RCOL,0                  :      AND RESET COL AND ROW
2)	        LB      R7,DMNROW,RDCB,
2)	        STB     R7,DROW,RDCB,
2)	XASM20
2)	:
2)	:(NSC)
2)		PUSH(RCOL)
2)		LHL	R11,DADEV,RDCB,		: GET ADJUSTED LINE #
2)	        JAL     R5,PBSIN                : STORE IT
2)		POP(RCOL)
2)	:
2)	        LB      R6,DROW,RDCB,           : GET ROW NO.
2)	        LR      R7,RCOL                 : GET COL. NO.
2)	:
2)		PUSH(R11)
2)		LHL	R11,DADEV,RDCB,		: GET ADJUSTED LINE #
2)	        JAL     R5,DOBA                 : STORE BUF. ADDR CHARS
2)		POP(R11)
2)	:
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

2)	        POP(R1)
2)	        RETJ(R5)
2)	 
2)	XASM30  HC      4
2)	        BC      ESC.,WCMD,WCCK,SBA.
2)	XASM40  HC      4                       : PRINTER HEADER
2)	        BC      ESC.,EWCMD,WCCP8S,SBA.
2)	 
2)	:       XAME - END BISYNC MSG (ASCII MODE)
2)	:       CLEARS REST OF CURRENT LINE AND ALL OF THE NEXT LINE
2)	:       THEN IT ENDS THE MSG AND PUTS IT THE INPUT QUEUE
2)	:       RBA IS SET TO ZERO SO THAT A NEW MSG WILL BE STARTED
2)	:
2)	XAME    PUSH(R5)
2)	:       CHECK DEVICE TYPE - IF PRINTER,DONT PUT CENT,AND DASHES
2)	        LHL     R6,DPDEV,RDCB,           : GET DEVICE NO.
2)	        LB      R6,DTYPE,R6,            : GET DEVICE TYPE
2)	        THI     R6,PRTR                 : IS IT A PRINTER
2)	        JN      XAME20                  :   Y - SKIP CENT AND DASHES
2)	:       CHECK ROW NUMBER-IF AT END OF SCREEN,DONT OUTPUT CENT +DASHES
2)	        LB      R6,DROW,RDCB,           : GET ROW NO.
2)	        CLB     R6,DMXROW,RDCB,         : COMPARE TO END OF DISPLAY AREA
2)	        JGE     XAME20                  : SKIP IF AT END
2)	        LHI     R5,CENT.                : PUT CENT CHAR AT CURRENT
2)	        LB      R0,REVTAB,R5            : ROW AND COLUMN
2)	:(NSC)
2)		PUSH(R11)
2)		LHL	R11,DADEV,RDCB,		: GET ADJUSTED LINE #
2)	        JAL     R5,PBCIN
2)		POP(R11)
2)	:
2)	        LR      R0,RCOL                 : CHECK FOR END OF ROW
2)	        AIS     R0,2                    : ADVANCE ONE FOR CENT,ONE TO
2)	                                        : COMPENSATE FOR ZERO ORIGIN
2)	        CLB     R0,DRSIZE,RDCB, 
2)	        JGEFS   XAME05                  : SKIP IF AT END OF ROW
2)	        LB      R6,DROW,RDCB,           : GET ROW NO.
2)	:(NSC)
2)		PUSH(R11)
2)		LHL	R11,DADEV,RDCB,		: GET ADJUSTED LINE #
2)	        JAL     R5,CLRLN                : CLEAR REST OF CURRENT LINE
2)		POP(R11)
2)	:
2)	XAME05  LB      R6,DROW,RDCB,           : GET ROW NO. AGAIN
2)	        AIS     R6,1                    : ADVANCE ROW NUMBER BY ONE
2)	        CLB     R6,DMXROW,RDCB,         : AT END OF DISPLAY AREA ?
2)	        JGE     XAME20                  :   Y - SKIP
2)	:
2)						: (AND TAKE CARE OF END OF SCREEN)
2)	:(NSC)
2)		PUSH(R11)
2)		LHL	R11,DADEV,RDCB,		: GET ADJUSTED LINE #
2)	        JAL     R5,DSHLN                : CLEAR NEXT LINE
2)		POP(R11)
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

2)	:
2)	XAME20  LHI     R0,RETX                 : GET REVERSED ETX
2)	:
2)	:(NSC)
2)		PUSH(R11)
2)		LHL	R11,DADEV,RDCB,		: GET ADJUSTED LINE #
**************
1)175	        JAL     R5,DOZAP                : ZAP PORT AND DEVICE
****
2)181	        JAL     R5,ACKZAP               :NSR 821 ACKNOWLEDGE ZAPPERS
2)	        JAL     R5,DOZAP                : ZAP PORT AND DEVICE
**************
1)177	        SUBTTL   RCV QUEUE PROCESSING ROUTINES
1)	:
1)	: RCVQ.X21
1)	:	02/20/86 PC NSC
1)	:	03/10/86 RJR TYM           
1)	:	04/30/86 SWB BOM
1)	:	07/16/86 PC NSR# 795, REFRESH ETB BLOCKS AFTER NSS FOR HICHI
1)	:	11/10/86 PC FIX 2D IN NSS MODE PER NSR# 825
1)	:	11/18/86 sdw FIX RDP404 AS PER V6.01 PATCH FILE (PRINTER DCB)
1)	:	
****
2)183	        SUBTTL   RCVQ-RCV QUEUE PROCESSING ROUTINES
2)	:
2)	: RCVQ.X21
2)	:	03/11/87 ALO fix esc#66718 -- NSS refersh ETB for Hitachi devices (RDN815)
2)	:	02/17/87 ALO fix incorrect slot # on network service screen (XMNE10)
2)	:	11/18/86 sdw FIX RDP404 AS PER V6.01 PATCH FILE (PRINTER DCB)
2)	:	11/10/86 PC FIX 2D IN NSS MODE PER NSR# 825
2)	:	07/16/86 PC NSR# 795, REFRESH ETB BLOCKS AFTER NSS FOR HICHI
2)	:	04/30/86 SWB BOM
2)	:	03/10/86 RJR TYM           
2)	:	02/20/86 PC NSC
2)	:	
**************
1)180		STB	R6,13,R2		:INSERT LAST DIGIT INTO BUFFER
1)	:
****
2)186	:
2)	: 2/17/87 ALO - fix NSS wrong slot # 
2)		STB	R1,13,R2		:INSERT LAST DIGIT INTO BUFFER
2)	:
**************
1)180	:        LB      R1,DEVLA+1,R5,           :GET CU ADR.
1)	:        STB     R1,NETS7B+13,,           :INSERT IT
1)	:        LB      R1,DEVLA+2,R5,          :GET DEV ADR.
1)	:        STB     R1,NETS7B+20,,
1)	:
1)	XMNE20
****
2)186	XMNE20
**************
1)180	:	STB	R1,NETS7B+14,,		: SAVE SECOND CHAR
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

1)		SRLS	R1,8
****
2)186		SRLS	R1,8
**************
1)180	:	STB	R1,NETS7B+13,,		: SAVE SECOND CHAR
1)		POP(R5)
****
2)186		POP(R5)
**************
1)180	:	STB	R1,NETS7B+22,,
1)		SRLS	R1,8
****
2)186		SRLS	R1,8
**************
1)180	:	STB	R1,NETS7B+21,,
1)	XMNE30
****
2)186	XMNE30
**************
1)182	:
1)	:        LHL     R3,SAVHED       	:(EDF)RELEASE SAVEQ BUFFER POINTER
1)	:
1)		PKCMD(SAV,RDEV,RDEV)		:(EDF) LOOK AT NEXT CMD LINK
1)	:
1)	:        LIS     R1,1            	:RESET COUNTER
1)	:
1)	        J       RDN77			: START FROM BEGINNING AGAIN
****
2)188		PKCMD(SAV,RDEV,RDEV)		:(EDF) LOOK AT NEXT CMD LINK
2)		JE	RDN92			: NO MORE DATA, EXIT - ALO
2)	        J       RDN77			: START FROM BEGINNING AGAIN
**************
1)189	:
1)	: NSR 545 06/09/86 RJR
1)	:
1)	: THIS FILE CONTAINS MISCELLANEOUS LOGIN SCREENS, SCREEN ADDRESSES,
****
2)195	:	
2)	: NSR 545 06/09/86 RJR
2)	: NSR 913 05-19-87 RJR
2)	: THIS FILE CONTAINS MISCELLANEOUS LOGIN SCREENS, SCREEN ADDRESSES,
**************
1)189	:
1)	NZMPTI	HC	$A9
1)		BC      ESC.,WCMD,WCCKPM,SBA.
1)	        SBAC($A22,1,$A80)
****
2)195	: NSR 913 WCCKPM TO WCCKM
2)	NZMPTI	HC	$A9
2)		BC      ESC.,WCMD,WCCKM,SBA.
2)	        SBAC($A22,1,$A80)
**************
1)200	: BOM.L04 09/11/85 PC
****
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

2)206	:	07-02-87 rjr esc 49510 code command change version to decimal display
2)	:	NSR 1399 07-08-87 RJR ZERO OUT WORD IN EREST RESP AVE FIELD
2)	:
2)	: BOM.L04 09/11/85 PC
**************
1)200	:
1)	:	BISYNC OPERATION MONITOR 
****
2)206	:	ESC 16824 CHANGE R12 TO R3 AT DNP25
2)	:	05-19-87 RJR FIX HALFWORD INDEX FOR KILL COMMAND
2)	:
2)	: 
2)	:	BISYNC OPERATION MONITOR 
**************
1)203		DPRINT(3,.O!.B)
1)		PRINT(DOT)
1)		LHI	R0,REVLEV
1)		DPRINT(2,.O!.Z)
1)		PRINT(NL)
****
2)209		DPRINT(3,.D!.B)
2)		PRINT(DOT)
2)		LHI	R0,REVLEV
2)		DPRINT(2,.D!.Z)
2)		PRINT(NL)
**************
1)216		LH	R13,FDEVL,R15		:get first device on line
1)		LH	R14,FDEVL+2,R15		:get first device on next line
1)	KLL06	LR	R9,R9			:build or kill
****
2)222	:
2)	: CHANGE INDEX FROM BYTE TO HALFWORD 05-19-87 RJR
2)	:
2)		LHL	R13,FDEVL,R15,R15	:get first device on line
2)		LHL	R14,FDEVL+2,R15,R15	:get first device on next line
2)	KLL06	LR	R9,R9			:build or kill
**************
1)217		LB	R0,CUADR,R12,		:print CU address
1)		ELSE
1)		LB	R0,CULA,R12,		:print CU address
1)		EI	:HSBCSW
****
2)223		LB	R0,CUADR,R3,		:print CU address
2)		ELSE
2)		LB	R0,CULA,R3,		:print CU address
2)		EI	:HSBCSW
**************
1)220	        STH     R0,RE.RSP,,             :zero total tick
1)		STH	R11,RE.SAV,,		:save DEVICE number
****
2)226	        ST      R0,RE.RSP,,             : RJR 070887 zero WORD total tick
2)		STH	R11,RE.SAV,,		:save DEVICE number
**************
1)221		JL	DPRT35			:skip ahead if valid
File 1)	DSK:THOST9.R01[21476,261167]	created: 0034 11-JUL-89
File 2)	DSK:PBT09.R03[21476,404152]	created: 1114 01-JUL-88

1)		PRINT(PTRCV)			:'rcv:  '
1)		PRINT(INVLD)			:'Invalid!'
1)		J	DPRT40			:check out address
1)	DPRT35	PRINT(PTRCV)			:'rcv:  '
****
2)227		JLFS	DPRT35			:skip ahead if valid
2)		PRINT(PTRCV)			:'rcv:  '
2)		PRINT(INVLD)			:'Invalid!'
2)		JFS	DPRT40			:check out address
2)	DPRT35	PRINT(PTRCV)			:'rcv:  '
**************
0	p?