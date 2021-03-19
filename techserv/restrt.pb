:**************************************************** PHB 01/15/87**
patch(861212,1800,PHB,ICZAP+0A,,6)
	J	PA1PTR,,
conpatch(PA1PTR,,36)
	LHL	R1,IPORT,,
	TBT	R5,TURKEY,,	:are we talking turkey on this port?
	JE	IZAP10,,	:if non turkey then jump
	RBT	R1,CCDRCV,,	:raz and setting of cond.flag
	JN	IZAP20,,	:jump if we received a clear be4
	LHI	R0,CNETCG^8!DIA000	: NETWORK CONGESTION
	STH	R0,PSDIAG,R1,R1	: placed for the clear packet
	LIS	R1,AA.NET	: FOR TERMINATION CODE
	J	IZAP30,,
IZAP10	J	ICZAP+18,,	: return to where we come from
conpatch(ESP16-6,,6)
	J	PA1PTR,,
conpatch(PA1PTR,,0C)
	SBT	R2,CCDRCV,,	: memorize the clear C & D for ICZAP
	J	MMFRA,,
conpatch(esp4,,16)
        jal     r4,gci,,
        lhl     r4,iport
        sbt     r4,ccdrcv,,
        j       esp4+8,,
conpatch(PA0PTR,,2*NIGRPS)
CCDRCV	HS	NIGRPS
endpatch(FIX THE PB OF DISTINCTION BETWEEN CLEAR BY DTE OR NETWORK)
