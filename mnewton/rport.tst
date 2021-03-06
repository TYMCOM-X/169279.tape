:*****************************************************************
:* Patchname: rport.tst    (sdlc 2.04)
:     author: JAmes Wang   (STS)
:     CUstomer: ANZNET
:  problem:  After pvc req/confirmed, Oring receives lots of xid frames
:            and then causes qutof1 to send backpresure to oring.
:            Bug is here. the routine qutof1 does not prepare rport.
:*********************************************************************


PATCH(900307,1700,JWANG,QUTOF2-12,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,12)
        LHL     R1,DCBLKS+DCBPRT,RDCB,
        JAL     R4,SLOR,,
        J       QUTOF2-0C,,
ENDPATCH(PREPARE RPORT WHEN SEND BACKPRESSURE TO ORING)
   