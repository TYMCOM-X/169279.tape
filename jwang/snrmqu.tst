
:*********************************************************************
: Patchname: SNRMQU.TST                Product version: SDLC 2.04
:   AUthor : James Wang                   Organization: STS
:  Customer: NIS                          DAte written: July 18, 1990
: Description of the problem:
:            HIF continuously sends SNRM to TIF so quickly or no
:            response from CU, the SNRMs may be accumulated in the
:            command link block and finally runs out of the available
:            command link entry and then crashes the slot.
:            SOmetimes it is not so easy to adjust the retry counter
:            and timer to fix the problem. 
:            Here we set a limit of SNRMs that can be queued in TIF
:            sent from HIF at any time. The limit constant is SNRMS.
:
: NOTE: USER CAN DEFINE ANY VALUE FOR SNRMS IN SLOT TYMFILE WITH
:       'SNRMS   EQ  ??'. IF USER DOES NOT DEFINE A VALUE FOR SNRMS,
:       THIS PATCH WILL SET A DEFAULT VALUE OF 5 FOR SNRMS.
: Note: this patch is used on TIF only.
:
:***********************************************************************

   IF   (\(PHDPTS))!(\(PHDMPS))

        IF      \SNRMS
        ELSE
SNRMS	EQ	5
        EI

PA0PTR	EQ	((PA0PTR+3)/4)*4
PATCH(900718,1000,JWANG,PA0PTR,,8+NPORT)
FDCLR4	WS	1
HPOPR1	WS	1
SNRMNO	BS	NPORT
CONPATCH(QUTOFG,,6)
	J	PA1PTR,,
CONPATCH(PA1PTR,,3A)
	LHL	R3,DCBLKS+DCBLSD,RDCB,
	CLHI	R8,0FFFE		:snrm ?
	JN	QUTOFG+6,,		:NO, SKIP
	LHL	R3,DCBLKS+DCBPRT,RDCB,	:GET RPORT 
	LB	R13,SNRMNO,R3,		:CHECK THE CURRENT QUEUED SNRM NO
	CLHI	R13,SNRMS			:REACH MAX LIMIT?
	JG	QUTOF2,,		:YES, DISCARD IT
	AIS	R13,1
	STB	R13,SNRMNO,R3,
	LHL	R3,DCBLKS+DCBLSD,RDCB,
	J	QUTOFG+6,,
CONPATCH(FDCLC1+16,,6)
	J	PA1PTR,,
CONPATCH(PA1PTR,,64)
        LH      R2,CMDBLK,RARG,
	CHI	R2,0FFFE		:SNRM?
	JN	FDCLC1+1C,,
	ST	R4,FDCLR4,,
	LB	R2,SCBLKS+SCBREL,RSCB,
	LHL	R4,LSDPTR,RL2,
FDCLLP	SIS	R2,1			:LOOP TO FIND RDCB
	JL	FDCL4
	AHI	R4,LSDLEN
	J	FDCLLP
FDCL4	LHL	R2,LSDTAB+LSDDCB,R4,	:GET RDCB
	LHL	R4,DCBLKS+DCBPRT,R2,	:GET RPORT
	LB	R2,SNRMNO,R4,		:GET SNRM NUMBER
	JEFS	.+0A
	SIS	R2,1
	STB	R2,SNRMNO,R4,
	L	R4,FDCLR4,,
	LH	R2,CMDBLK,RARG,
	J	FDCLC1+1C,,
CONPATCH(HPOP2+16,,6)
	J	PA1PTR,,
CONPATCH(PA1PTR,,46)
	STH	R5,SCBLKS+SCBIC,RSCB,
	ST	R1,HPOPR1,,
	LB	R5,SCBLKS+SCBREL,RSCB,
	LHL	R1,LSDPTR,RL2,
HPOPLP	SIS	R5,1
	JL	HPOP7
	AHI	R1,LSDLEN
	J	HPOPLP
HPOP7	LHL	R5,LSDTAB+LSDDCB,R1,	:GET RDCB
	LHL	R1,DCBLKS+DCBPRT,R5,	:GET RPORT
	LIS	R5,0
	STB	R5,SNRMNO,R1,		:RESET THE COUNTER TO ZERO
	L	R1,HPOPR1,,
	J	HPOP2+1C,,
CONPATCH(ACT3+6,,6)
	J	PA1PTR,,
CONPATCH(PA1PTR,,14)
	STH	RPORT,DCBLKS+DCBPRT,RDCB,
	LIS	R3,0
	STB	R3,SNRMNO,RPORT,
	J	ACT3+0C,,
CONPATCH(MSGZAP+6,,6)
	J	PA1PTR,,
CONPATCH(PA1PTR,,14)
	LHL	R1,DCBLKS+DCBPRT,RDCB,
	LIS	R10,0
	STB	R10,SNRMNO,R1,
	J	MSGZAP+0C,,
CONPATCH(MSGB2+4A,,6)
	J	PA1PTR,,
CONPATCH(PA1PTR,,14)
	STH	R1,DCBLKS+DCBPRT,R12,
	LIS	R0,0
	STB	R0,SNRMNO,R1,
	J	MSGB2+50,,
CONPATCH(RSTUSR+24,,6)
	J	PA1PTR,,
CONPATCH(PA1PTR,,12)
	STH	R2,PORTAB,R1,R1
	STB	R0,SNRMNO,R1,
	J	RSTUSR+2A,,
CONPATCH(IZ0100+0E,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,14)
        STH     R5,PORTAB,R1,R1
        LIS     R0,0
        STB     R0,SNRMNO,R1,
        J       IZ0100+14,,
ENDPATCH(SET A LIMT FOR SNRM TO BE QUEUED UP IN tif)

   EI

    