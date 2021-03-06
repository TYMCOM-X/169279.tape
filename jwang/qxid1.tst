:****************************************************************
: PATCHANME: QXID1.TST                    PRODUCT VERSION: SDLC 1.12
:    AUTHOR: JAMES WANG                     ORGANIZATION:  STS
:  CUSTOMER: NSC                            DATE WRITTEN:  JULY 12, 1989
: PROBLEM:
:    IIX MESSAGE C094 (QXID) WAS RECEIVED VIA TWO MESSAGE (ONE IIX
:    AND ONE ISIS MESSAGE). THE FIRST IIX MESSAGE ENDS AFTER QXID BYTE
:    ('AF').
:*********************************************************************

PATCH(890712,1300,JWANG,PA0PTR,,4)
RETRN1  WS      1
CONPATCH(ACTIV,,4)
        ST      R4,RETRN1
CONPATCH(ACTIV2,,4)
        L       R4,RETRN1
CONPATCH(INPDQ4+10,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,20)
        LR      RLEN,RLEN
        JN      INPDQ0
        LHI     R0,INPDQ0-SEG|A.CODE|
        STH     R0,DCBLKS+ACTIVD,RDCB,
        JR      R5
INPDQ0  JAL     R4,GETCH,,
        J       INPDQ4+16,,
ENDPATCH(IIX MESSAGE QXID WAS RECEIVED VIA TWO IRING MESSAGES)
  