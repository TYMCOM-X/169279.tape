:****************************************************************
: Patch name:  IHSPAT.703	Product and Version:  ISIS 7.03
:     Author:  Clive Rowe	       Organization:  STS
:   Customer:  Morgan		       Date Written:  08/18/88
: Reason for patch:
	REMARK	% ISIS 7.03 PATCH 17
	REMARK	% This patch fixes timing problems associated
	REMARK	% with the initialization of HDLC micro-engine
	REMARK	% channels that are emulating TYMNET sync.
:****************************************************************
:
				:********************************
PATMAX	EQ	$A 17		:
	IF	HMICRO		:
	LO	SYNC		:
	ORG	IHSYN2		:
	HC	0,0,0		:
	ORG	IHSYN2		:
	J	IHSP01,,	:
				:********************************
	ORG	SNEXT		:
IHSP01				:********************************
	RBT	R5,HMASK	: MARK IT STARTED
	lhi	r7,0D0		: Set up a timer
	epsr	r6,r7		:
	lhi	r14,rate/4	: 250 millisec pause
	la	r15,IHSP03	:
	lhi	r13,60f0	:
	epsr	r12,r13		:
	LIS	R7,0F		: GET HIGHEST LINE #
	SR	R7,R5		: GET LINE # (ARRAY IS REV ORDER)
	SBT	R7,IHINT	: SIGNAL INT EXP ON DEV 80
	SBT	R7,HSDTR	: SET DTR INACTIVE
	SBT	R7,HSRTS	: SET RTS INACTIVE
	LHI	R6,IHSYN3	: GET ADDR OF NEXT INIT STEP
	SLLS	R7,1		: MAKE HW INDEX
	STH	R6,SYNVEC+2,R7,R7: PLACE IN VECTOR TABLE
	SLLS	R7,7		: MOVE LINE # TO HIGH BYTE
	OI	R7,HCMD1	: MAKE START OUTPUT CMD
	LI	R6,HPAIR1/10	: GET QUAD ADDR OF CHAN PGM
	HLOG(R7,R6)		:
	WDR	R7,R6		: INIT SIO FOR THIS CHAN
IHSP02				:********************************
	lis	r5,5		:
	wdr	r5,r5		:
	jbs	IHSP02		:
IHSP03				:********************************
	lhi	r13,20f0	: turn off I/O interrupts
	lis	r14,8		: and restore timekeeper things
	la	r15,timek	: in case this is the last line
	epsr	r12,r13		:
	J	IHSYN1,,	: DO NEXT LINE
SNEXT				:********************************
	HS	0		:
	FO	SYNC		:
	EI	(HMICRO)	:
				:********************************
				: End of Patch
				:********************************

:****************************************************************
: This places the # of the last patch in PATLEV and must
: remain at the end of the patch file.
:****************************************************************
:
				:********************************
	ORG	PATLEV		:
	HC	0		:
	ORG	PATLEV		:
	HC	PATMAX		:
				:********************************

:****************************************************************
: Check that there is no overflow in any of the patch areas.
:****************************************************************
:
				:********************************
	LO	DDT		:
	IF	DNEXT-HGHDDT	:
	REMARK	%%***  ERROR - DPATCH OVERFLOW  ***%%
	EI			:
	FO	DDT		:
				:********************************
	IF	SHARE		:
	LO	SHARE		:
	IF	HNEXT-(HPATCH+(2*80))
	REMARK	%%***  ERROR - HPATCH OVERFLOW  ***%%
	EI			:
	FO	SHARE		:
	EI	(SHARE)		:
				:********************************
	LO	KERNEL		:
	IF	KNEXT-F1	:
	REMARK	%%***  ERROR - KPATCH OVERFLOW  ***%%
	EI			:
	FO	KERNEL		:
				:********************************
	IF	SNEXT-(SPATCH+(2*100))
	REMARK	%%***  ERROR - SPATCH OVERFLOW  ***%%
	EI			:
				:********************************
    