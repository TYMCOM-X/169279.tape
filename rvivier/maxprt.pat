:
:	REDUCE THE NUMBER OF SHAMAN PORTS TO "0F" MAX IF NEEDED
:
	IF	MAXPRT-$00F
	ORG	0E0082
	BC	0,0
	ORG	0E0082
	HC	0F
	EI	:MAXPRT-$00F
  