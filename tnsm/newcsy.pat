:	reuse connect XPI svc.  I think it is pretty unlike that XPI will
:	be used with this consat patch.  as this is a patch it cannot create
:	a new svc, so it must reuse one.

	if	nasyng
	remark%%ISIS patch to redo SVC IO 3 (old async connect) into a
	remark%%pass bit array to drive busy signal svc.
	lo	kernel

	org	coniot+34
	hc	0,0
	org	coniot+34
	j	nbusy

	org	snext

ABSYP	hs	nasyng*2		:for rts (busy) signalling
snext	eq	.

:	ASYNC connect BUSY (RTS) signal to bit array.  needed to allow
:	toggling of RTS without worrying about whether port is BPed by
:	the user (if signal toggle via control message then isis must
:	read the control message from the ring and isis stop reading if
:	told to stop sending by the consat).

:	this is the connect async svc renamed and lots of stuff deleted and
:	ABSYP instead of the other bit arrays.
:	form of the svc is rx is LU#, rx+1 is address of bit array

	org	knext
NBUSY	lis	r4,0f
	nh	r4,f1argl		:locate register
	clhi	r4,r14			:not going to worry about folding regs
	jg	kret
	slls	r4,2
	LHL	R15,RREG,R1,r4		:get register of LU
	clhi	r15,nlu
	jg	kret
	LHL	R13,RPSW+2,R1		:get PSW status
	l	r12,rreg+4,r4,r1	:get reg with address
	JAL	R11,ACCESS		:convert to physical address
	 J	KRET			:no access...normal return
	LB	R9,LUN,R4,R1		:get LUN entry
	SIS	R9,1			:must be type 1
	 JN	KRET			:wrong type...ERROR
	L	R9,LUN,R4,R1		:get LU pointer
	LB	R8,1,R9			:locate physical group number

	L	R12,4,R10		:locate BUSY array (in 2nd register)
	JAL	R11,TTRW		:translate
	 J	NCASY3
	ST	R12,ABSYP,R9		:set it up

	J	KSKIP			:finished...skip return to slot
knext	eq	.

:	now patch the async background routine to copy status from slot's
:	bit arrays to the controlling bit array and then write signal to
:	board

	lo	clocks
	org	aback
	hc	0,0
	org	aback
	j	snext

	org	snext
	lhi	r3,(nasyng*2)-2		:number of ports to do
ABABSY	l	r4,absyp,r3,r3		:address of the bit array in the slot
	jlefs	ababs1			:not assigned so don't use
	lhl	r5,0,r4			:get slot's value
	sth	r5,rts,r3		:write into isis's controlling array
ababs1	sis	r3,2
	jgebs	ababsy
	lr	r6,r2			:need r2 for exit of aback
	jal	r2,sndrts
	lr	r2,r6
	lhi	r3,ada+1		:overwritten instruction
	j	aback+4
snext	eq	.

:	and finally when disconnectng devices the bit array reference must
:	also be cleared.

	org	dcdev2+0c
	hc	0,0
	org	dcdev2+0c
	j	snext

	org	snext
	st	r12,adtrp,r14		:overwritten instruction
	st	r12,absyp,r14		:clear out ref to busy
	j	dcdev+0e,,
snext	eq	.

	ei	:nasyng
 