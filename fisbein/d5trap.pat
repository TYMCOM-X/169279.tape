:	patch to trap bufferlet information when building the call accepted
:	packet in order to trap the D5 crash at ESP179 in the XTP context.
patch(032290,1020,S/FISBEIN,PA0PTR,,130*NDPORT+8)

D5SAV1	EQ	0		: Save area at RMBL40
D5REG	EQ	0		: 40 bytes : all 16 registers
D5BUF1	EQ	40		: 10 bytes : FACBUF 1st bufferlet
D5BUF2	EQ	D5BUF1+10	: 10 bytes : FACBUF last bufferlet
D5BUF3	EQ	D5BUF2+10	: 10 bytes : DIBUF 1st bufferlet
D5BUF4	EQ	D5BUF3+10	: 10 bytes : DIBUF last bufferlet
D5BBFA	EQ	D5BUF4+10	: 4 bytes  : FACBUF 1st buflet pointer
D5BEFA	EQ	D5BBFA+4	: 4 bytes  : FACBUF last buflet pointer
D5BBDI	EQ	D5BEFA+4	: 4 bytes  : DIBUF 1st buflet pointer
D5BEDI	EQ	D5BBDI+4	: 4 bytes  : DIBUF last buflet pointer
D5FACB	EQ	D5BEDI+4	: 2 bytes  : FACBUF
D5DIBF	EQ	D5FACB+2	: 2 bytes  : DIBUF
D5DPRT	EQ	D5DIBF+2	: 2 bytes  : DPORT
D5IPRT	EQ	D5DPRT+2	: 2 bytes  : IPORT
D5SAV2	EQ	D5IPRT+2	: Save area at RMBL75 when exiting
D5SAV0	HS	D5SAV2*NDPORT	: Reserve space for save area
D5SVR1	HS	2		: temporary register save area
D5SVR2	HS	2		: temporary register save area

conpatch(RMBL40,,6)
	J	PA1PTR,,
conpatch(PA1PTR,,202)
	ST	R1,D5SVR1,,		: save R1
	LB	R1,PACKET,,		: get packet type
	CLHI	R1,YCALA		: trap only if Call Accepted
	JN	D5RB40			: if not, return
	ST	R2,D5SVR2,,		: save R2
	LHI	R2,2*D5SAV2		: prepare multiply factor and
	MH	R2,DPORT,,		: calculate base for this DPORT
	LA	R1,D5SAV0,,		: prepare save buffer address
	AHI	R1,D5SAV1
	AR	R2,R1			: buffer in R2
	JAL	R1,D5SAVE		: go and save context
D5RB40	L	R1,D5SVR1,,		: restore R1
	RBT	RL,RMDIAG,,		: original instruction
	JE	RMBL60,,		: original instruction
	J	RMBL40+8,,		: back to source code

D5SAVE	ST	R0,D5REG,,R2		: save R0
	ST	R3,D5REG+0C,,R2		: save R3
	L	R3,D5SVR1,,		: get R1 back
	ST	R3,D5REG+4,,R2		: and save it
	L	R3,D5SVR2,,		: get R2 back
	ST	R3,D5REG+8,,R2		: and save it
	ST	R4,D5REG+10,,R2		: save R4
	ST	R5,D5REG+14,,R2		: save R5
	ST	R6,D5REG+18,,R2		: save R6
	ST	R7,D5REG+1C,,R2		: save R7
	ST	R8,D5REG+20,,R2		: save R8
	ST	R9,D5REG+24,,R2		: save R9
	ST	R10,D5REG+28,,R2	: save R10
	ST	R11,D5REG+2C,,R2	: save R11
	ST	R12,D5REG+30,,R2	: save R12
	ST	R13,D5REG+34,,R2	: save R13
	ST	R14,D5REG+38,,R2	: save R14
	ST	R15,D5REG+3C,,R2	: save R15
	LHL	R3,DPORT,,
	STH	R3,D5DPRT,,R2		: save DPORT
	LHL	R3,IPORT,,
	STH	R3,D5IPRT,,R2		: save IPORT
	LHL	R3,FACBUF,,
	STH	R3,D5FACB,,R2		: save FACBUF
	L	R4,BB,R3,
	ST	R4,D5BBFA,,R2		: save FACBUF 1st buflet pointer
	SRLS	R4,4
	SLLS	R4,4			: adjust to beginning of buflet
	L	R5,2,,R4
	ST	R5,D5BUF1,,R2		: save FACBUF 1st bufferlet
	L	R5,6,,R4
	ST	R5,D5BUF1+4,,R2
	L	R5,0A,,R4
	ST	R5,D5BUF1+8,,R2
	L	R5,0E,,R4
	ST	R5,D5BUF1+0C,,R2
	L	R4,BE,R3,
	ST	R4,D5BEFA,,R2		: save FACBUF last buflet pointer
	SRLS	R4,4
	SLLS	R4,4			: adjust to beginning of buflet
	L	R5,2,,R4
	ST	R5,D5BUF2,,R2		: save FACBUF last bufferlet
	L	R5,6,,R4
	ST	R5,D5BUF2+4,,R2
	L	R5,0A,,R4
	ST	R5,D5BUF2+8,,R2
	L	R5,0E,,R4
	ST	R5,D5BUF2+0C,,R2
	LHL	R3,DIBUF,,
	STH	R3,D5DIBF,,R2		: save DIBUF
	L	R4,BB,R3,
	ST	R4,D5BBDI,,R2		: save DIBUF 1st buflet pointer
	SRLS	R4,4
	SLLS	R4,4			: adjust to beginning of buflet
	L	R5,2,,R4
	ST	R5,D5BUF3,,R2		: save DIBUF 1st bufferlet
	L	R5,6,,R4
	ST	R5,D5BUF3+4,,R2
	L	R5,0A,,R4
	ST	R5,D5BUF3+8,,R2
	L	R5,0E,,R4
	ST	R5,D5BUF3+0C,,R2
	L	R4,BE,R3,
	ST	R4,D5BEDI,,R2		: save DIBUF last buflet pointer
	SRLS	R4,4
	SLLS	R4,4			: adjust to beginning of buflet
	L	R5,2,,R4
	ST	R5,D5BUF4,,R2		: save DIBUF last bufferlet
	L	R5,6,,R4
	ST	R5,D5BUF4+4,,R2
	L	R5,0A,,R4
	ST	R5,D5BUF4+8,,R2
	L	R5,0E,,R4
	ST	R5,D5BUF4+0C,,R2
	L	R5,D5REG+14,,R2		: restore R5
	L	R4,D5REG+10,,R2		: restore R4
	L	R3,D5REG+0C,,R2		: restore R3
	L	R2,D5REG+8,,R2		: restore R2
	JR	R1

conpatch(RMBL75,,6)
	J	PA1PTR,,
conpatch(PA1PTR,,46)
	STH	R14,BYTCNT,R13,		: original instruction
	ST	R1,D5SVR1,,		: save R1
	LB	R1,PACKET,,		: get packet type
	CLHI	R1,YCALA		: trap only if Call Accepted
	JN	D5RB75			: if not, return
	ST	R2,D5SVR2,,		: save R2
	LHI	R2,2*D5SAV2		: prepare multiply factor and
	MH	R2,DPORT,,		: calculate base for this DPORT
	LA	R1,D5SAV0,,		: prepare save buffer address
	AHI	R1,D5SAV2
	AR	R2,R1			: buffer in R2
	JAL	R1,D5SAVE		: go and save context
D5RB75	L	R1,D5SVR1,,		: restore R1
	J	RMBL75+6,,		: back to source

conpatch(ESP179,,4)
	TRAP(R7,D5)
endpatch(trap patch for D5 crash in XTP environment)
  