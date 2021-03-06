:*************************************************************************
: Patchname: XIDQUE.TST                   (SDLC 2.04)
:   AUthor : JAMES WANG    (STS)
: CUSTOMER: FRANK RUSSEL                      (JAN 30, 1990)
: Description of the problem:
:           WHen CU is not ready or in slow response mode for some reason,
:           HIF may continue to queue up XID frames whenever timer expires.
:           This may causes receive overrun and become unrecoverable.
:                  
:****************************************************************************

   IF     (\SHDPTS))!(\(SHDMPS))
pa0ptr	eq	((pa0ptr+3)/4)*4
PATCH(900128,1000,JWANG,PA0PTR,,58)
XIDQUE	BS	50
SAVE1	WC	0
SAVE5	WC	0
CONPATCH(HSDXID,,8)
	J	PA1PTR,,
	NOPR	0,0
CONPATCH(PA1PTR,,76)
	JAL	RLINK5,CHKXID,,
	J	HSDX09
	ST	R1,SAVE1,,
	ST	R5,SAVE5,,
	LB	R5,SCBLKS+SCBREL,RSCB,
	LHL	R1,LSDPTR,RL2,
DCBLP	SIS	R5,1
	JL	SCBDCB
	AHI	R1,LSDLEN
	J	DCBLP
SCBDCB	LHL	R5,LSDTAB+LSDDCB,R1,
	LHL	R1,DCBLKS+DCBPRT,R5,
	LB	R5,XIDQUE,R1,
	CLHI	R5,3
	JGE	HSDX07
	AIS	R5,1
	STB	R5,XIDQUE,R1,
	L	R1,SAVE1,,
	L	R5,SAVE5,,
	J	HSDXID+8,,
HSDX07	L	R1,SAVE1,,
	L	R5,SAVE5,,
HSDX09  J	HSDXI0,,
CONPATCH(OUTDX1,,6)
	J	PA1PTR,,
CONPATCH(PA1PTR,,54)
	LHL	R11,CMDTBL,R7,R7
	CLHI	R7,7
	JE	OUTDX3
	CLHI	R7,2
	JN	OUTDX1+6,,
OUTDX3	ST	R1,SAVE1,,
	ST	R5,SAVE5,,
	LHL	R1,DCBLKS+DCBPRT,RDCB,
	LB	R5,XIDQUE,R1,
	SIS	R5,1
	CLHI	R7,7
	JE	.+6
	LIS	R5,0
	STB	R5,XIDQUE,R1,
	L	R1,SAVE1,,
	L	R5,SAVE5,,
	J	OUTDX1+6,,
ENDPATCH(ONLY QUEUES UP TO THREE XID FRAMES SENT FROM FEP)
     EI

        
  