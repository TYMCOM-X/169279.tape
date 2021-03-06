:--------------------------------------------------------------------------
: DATE: 07-27-89
: NSR: 
: ESCALATION: 252745 (SUN LIFE), 250767 (MINNESOTA MUTUAL).
: VERSION: CMTI 7.04
: AUTHOR: RICHARD HO
:
: PROBLEM: CMTI does not display the status line at the VTAM banner
:	   screen for full duplex terminals..
:
: SOLUTION: A couple of instructions (for full duplex terminals) were
:	    destroyed by the half duplex code causing this problem.
:	    Restore the instructions to fix this problem.
:
: NOTE: This patch is a fix for the above patch #15. Therefore, has to
:	used in conjunction with patch #15 above (in this patch file).
:
	LO	CCB
	LO	TPF
	LO	DSP
PATCH(890727,1500,R/HO,dspe02,,6)
	j	pa1ptr,,
conpatch(pa1ptr,,60)
	chi	r2,t78h			:is TYMNET78 ?
	jn	NBACK			:back to source
	lhi	r2,t.writ		:erase/write bit
	tbt	r2,tbits,r11		:received e/write command ?
	jefs	ndpew			:yes, skip
:
NBACK	LCS	R7,1			:FIX MISSING OF STATUS LINE AT VTAM.
	STH	R7,CPREBT,R11,		:
:
	j	dspe02+6,,		:no, to source
:
ndpew	lcs	r7,1			:make sure status line is updated
	sth	r7,cprebt,r11
	l	r6,tcscn,r11		:get old scn addr
	lis	r7,0			:start position 0
ndpew1	tbt	r7,scnmap,r8		:is in attr pos ?
	jnfs	ndpew3			:yes, skip
	lb	r0,scn,r7,r8		:get the character
	chi	r0,e.sp			:is the character graphic ?
	jlefs	ndpew3			:no, skip
	sbt	r7,cgraph,r11		:yes, set CGRAPH bit
	jfs	ndpew5
ndpew3	rbt	r7,cgraph,r11		:reset CGRAPH bit
ndpew5	ais	r7,1			:increment char position
	ch	r7,cscnsz,r11		:to the end of scn
	jl	ndpew1			:no, loop back
	j	dspe90+0e,,		:yes, back to source
ENDPATCH(FIX MISSING OF STATUS LINE AT VTAM BANNER)
	FO	DSP
	FO	TPF
	FO	CCB
 