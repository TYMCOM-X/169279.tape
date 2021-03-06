:****************************************************************
: Patch name: REBTAK.TST	   Product and Version:  TII 5.22
:     Author: STEVE MURRAY    	       Organization:  STS
:   Customer: ALL    		       Date Written:  06/13/91
:  
:   Description:  allow rebuild requests to be sent after the SUP
:		  takes over the node.  Before, if the SUP circuit
:		  did not exist all circuits in rebuild limbo would
:		  just timeout.
:****************************************************************

	IF	REBILD&(1-T2GATE)

PATCH(910607,1100,SHM,PA0PTR,,4)
LP8RS1	WS	1			:save for new rebuild resend
CONPATCH(LEP08R,,2C)
	J	LPCR40			:go to rebuild area
CONPATCH(LPCR40,,6)		        
	J	PA1PTR,,
CONPATCH(PA1PTR,,0C4)	
	LIS	R5,0			:index into array
LP8RB0	L	R6,REBTMO,R5		:on rebuild timout?
	O	R6,REBTMI,R5		:on either of the rebuild timouts?
LP8RB2	JFFO	R6,LP8RB1		:got one
	AIS	R5,4			:next group			###sdw
	CLHI	R5,NCIRCS/20		:done with all ports?
	JLBS	LP8RB0
	J	LP8RB9			:done with rebuild resending 
LP8RB1	SLLS	R5,3			:make into real number
	ST	R6,LP8RS1,,		:save active flags
	RBT	R7,LP8RS1,,		:this one serviced
	AR	R7,R5
	SRLS	R5,3			:restore index into flags
	SLLS	R7,2			:make buffer index
	AI	R7,HBUFN,,		:got our history buffer
	LHL	R0,RNFLAG,R7,		:origination?
	JE	LP8RB8			:nope, skip resending
	LHL	R2,TVRBUF,,		:
	LHI	R1,8000+MACHNM		:make rebuild request supe msg
	JAL	R9,WHWI,,
	LHI	R1,0D80 		:type 0D
	JAL	R9,WHWI,,
	LHL	R1,RNFLAG,R7,		:needle flags
	JAL	R9,WHWI,,
	LHI	R1,8080 		:scratch port number
	JAL	R9,WHWI,,
	LHL	R1,RBASE,R7,		:base and host #
	JAL	R9,WHWI,,
	LHL	R1,RHOSTN,R7,
	JAL	R9,WHWI,,
	LHL	R1,RINVC,R7,		:invoice number
	JAL	R9,WHWI,,
	LHL	R1,RINVC+2,R7,		:all of invoice number
	JAL	R9,WHWI,,
	LCS	R1,1			:no idea of which link and node though
	JAL	R9,WHWI,,
	JAL	R9,WHWI,,
LP8RB8	L	R6,LP8RS1,,		:get back bits still to do
	J	LP8RB2
LP8RB9	J	LEP1,,			:end of takeover
CHKHST	LIS	HN,1			:ORIGINAL INSTRUCTION
	J	CHKENT,,
CONPATCH(TRCR10+44,,4)	
	JE	TRCZHC
CONPATCH(LEP08+4,,6)
	J	PA1PTR,,
CONPATCH(PA1PTR,,12)
	JAL	R7,CHKHST,,
	L	R2,HSTSAV,,
	J	LEP08+0C,,
ENDPATCH(Allow rebuilds to work once SUP takes node over)

	EI	:(1-T2GATE&REBILD)
   