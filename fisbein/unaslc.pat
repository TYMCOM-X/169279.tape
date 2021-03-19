
:****************************************************************
:
:	Patch by :		Stephane Fisbein - TSG - MDISI
:	Patch to module :	XCOMRT.F43
:	Version :		4.03
:	Related NSR # :		1678
:	Description :
:
:	When a call is received from the link on an unassigned channel,
:	the XCOM just discards the packet as any packet on an unassigned
:	LCN, except if it is a Clear Request. This is conform to CCITT
:	recommendation. However, some Public Networks, such as British
:	Telecom PSS network, would expect such call attempt to be
:	cleared. This patch clears a call request coming in from the
:	link on an unassigned LCN. All other packet type processings
:	remain unchanged. A flag could be designed in future versions of
:	the code to allow customer to choose whether he wants this kind
:	of behaviour or not.

patch(040188,1235,S/FISBEIN,RTD460+04,,6)
	J	PA1PTR,,
conpatch(PA1PTR,,1E)
	CLHI	R0,YCLRR		: original code
	JE	RTD480,,		: original code
	LHI	R13,CLRCAU^8!DIA036	: packet on unassigned channel
	CLHI	R0,YCALR		: call request ?
	JE	RTD480,,		: clear it then !
	J	RTD460+0A,,		: else back to source to ignore it
endpatch(clear call request received on unassigned channel)
