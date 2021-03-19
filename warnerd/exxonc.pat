
:	Seriously, this patch assumes a configuration WITHOUT TELEX,
:	LISA, SIO Async, PVC or MPVC. If any of the above are included
:	in the configuration, the value '9C' needs to be changed.

	LO	ISIS

	ORG	INIT1+0AC
	HC	0,0,0
	ORG	INIT1+0AC

	LI	R2,RATE/4	:schedule HANGAN every 1/4 sec

::	EOF			


