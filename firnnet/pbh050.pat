: **********************************************************************
: *                                                                    *
: *  File     : PBH050.PAT                                             *
: *  Customer : FIRN                                                   *
: *  Comments : Original file - ENQ705.PAT                             *
: *           : Use in all FIRN PBH 7.05 code                          *
: *                                                                    *
: **********************************************************************

:  ORIGIONAL FILE NAME: ENQ705.PAT
:  DATE: Aug 18, 1986
:  modified by DeeJong on 10/30/86
:  replace RAD with R15
:
:  PBH 7.05 does not handle Forward Abort correctly. 
:
:  When a BCC is checked to be incorrect, PBH sends 2D
:  to abort the block of message, but still increases the
:  sequence number. This patch modifies the ETXBIT into
:  ENQBIT so the sequence number will not be incremented
:  for the retransmitted block.
:
:  For ESC# 12042, BRODART
:
	LO   BSCRCV
PATCH(081886,1600,D/TAI,RPABT4,,4)
     LHI  R15,ENQBIT
ENDPATCH(SEND ENQ FOR FORWARD ABORT, PBH 705)
	FO   BSCRCV
P0END     EQ   PA0PTR
P1END     EQ   PA1PTR

  