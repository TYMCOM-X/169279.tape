	LO CONSAT
PATCH(881208,1100,J/RIDDINGTON,AGCI,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,50)
	L	R4,AR.FT,RP2,RP2
	LI	R3,030080
	CR	R4,R3
	JN 	T1
	LH	R3,GC,,
	AHI	R3,1
	STH	R3,GC,,
	J	AGCI+6,,
T1	LH	R3,BC,,
	AHI	R3,1
	STH	R3,BC,,
	J	AGCI+6,,
CONPATCH(PA0PTR,,8)
GC	HC	0
BC	HC	0
ENDPATCH(IBSTOCK diagnostic patch part 1)
   
	FO CONSAT
