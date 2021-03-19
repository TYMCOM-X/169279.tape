
:......................................................................
:.                                                                    .
:.             ==*  Morgan Global Data Network  *==                   .
:.                                                                    .
:.                          [ 2780/3780 ]                             .
:.    Node : 2017                                 Updated: JUL-30-85  .
:.  Kernal : 17                                        By: CAR        .
:.   Hosts :MAILWAY                               Version: 5.01       .
:.           22017                                                    .
:......................................................................
:.Revision History:                                                   .
:.                                                                    .
:***********************  NODE PARAMETERS  *****************************
:
LOCATION(2017,2)	: Node and slot numbers (node,slot)
OPTION(CONFIG,YES)	: Display configuration
CRSTOP	EQ	1	: Stop this slot on crash
:OPTION(OFFTIM,60)
:
:********************* LINE COUNTERS AND TIMERS ************************
:
SIGTIM	EQ	$A 600	: Time to sign on (5 minutes)
:
:***********************  LINE PARAMETERS  *****************************
:
:----------------------------------------------------------------------:
:
:	Line 0 -Switched Terminal Port 
:
:	For access to: MAILWAY/INFLOWS
:
	DIALECT(0,E2780)		: 2780/3780 dialect only
	PVC(0,PVC1449,1449,WELCOME)     :
	LOPTION(0,BNDC,0)               : Clear curcuit,drop DTR after disconne
	LOPTION(0,BKPA,0)               : No line bid after EOT.
	LOPTION(0,BMSG,0)               : Do not transmit net message
	LOPTION(0,BETN,1)               : 
        LOPTION(0,BDTR,0)
        LOPTION(0,BDSC,1)
        LOPTION(0,BRTS,0)
:
:----------------------------------------------------------------------:
:
:	Line 1 - Leased Host Port
:
:	For access to: Testing
:
	DIALECT(1,E3780)		: 3780 dialect only
	LEASED(1)
	MASTER(1,762,1,6)		: host for london PVC
        LOPTION(1,BETX,1)               :
        LOPTION(1,BDTR,0)               :
        LOPTION(1,BMSG,0)
:----------------------------------------------------------------------:
AHOST  EQ 22017			: ACCOUNTING HOST NUMBER
:--EOF--
