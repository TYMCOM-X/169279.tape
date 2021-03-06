
:**********************************************************************
: Patchname: XIDQU3.TST      (SDLC 2.04)
:    Author: James Wang    (STS)
:  Customer: FRank Russell
:    Task:   discard XID if the receive quota is less than 4.
:            For PU4 to PU4 connection, XID was queued up so 
:            quicker than the CU can respond and then causes
:            receive overrun.
:****************************************************************************

   IF   (\(SHDPTS))!(\(SHDMPS))
PATCH(900201,1000,JWANG,FINDS1,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,30)
        LB      R1,RBUF+1,R2,
        CLHI    R1,0BF
        JE      FINDS5
FINDS3  STB     R3,LCBTAB+LSARCV,RLCB,
        J       FINDS1+6,,
FINDS5  LHL     R1,SCBLKS+SCBRQA,RSCB,
        CLHI    R1,4
        JGE     FINDS3
        LCS     RSCB,1
        J       RCVEN7,,
ENDPATCH(DISCARD XID IF THE RECEIVE QUOTA IS LESS THAN 4)
   EI

   