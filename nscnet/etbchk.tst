	LO	DSP
PATCH(910514,1525,IKU,ADRHIT+2C,,6)
        J        PA1PTR,,
CONPATCH(PA1PTR,,28)
	CHI	R0,E.ETB		:Is it ETB ?
	JNFS	ADRH01			:No
	LA	R4,ADRHIT,,		:Yes, One more Next read
	ST	R4,DETBBR,R12,,		:Set Return AddRess to R4
	J	ETBHIT,,		:Jump ETB Routine
ADRH01	NHI	R0,1F			:Forward Abort ?
	STH	R0,DUNAME+4,R12,,	:Store Byte (Right-Hand part)
	J	ADRHIT+36,,			:
 
CONPATCH(ADRHIT+61,,6)
        J	PA1PTR,,
CONPATCH(PA1PTR,,28)
	CHI	R0,E.ETB		:Is it ETB ?
	JNFS	ADRH03			:No
	LA	R4,ADRHIT+36,,		:Yes, One more Next read
	ST	R4,DETBBR,R12,,		:Set Return Address to R4
	J	ETBHIT,,		:Jump ETB Routine
ADRH03	NHI	R0,3F			:Strip off 2 hi-order bits
	SLLS	R0,5              	:1st part of buffer calculation
	J	ADRHIT+68,,			:
ENDPATCH(Check for the ETB, when show up SBA Hitach)
        FO	DSP
   