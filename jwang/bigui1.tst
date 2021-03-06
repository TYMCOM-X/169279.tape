:*****************************************************************
: PATCHNAME: BIGUI.TST                   PRODUCT VERSION: SDLC 2.04
:   AUTHOR : JAMES WANG                    
: CUSTOMER : TELERATE                    DATE WRITTEN : APR 27,1991
: DESCRIPTION OF PROBLEM:
:    UI FRAME EXCEEDS ISIS MAX SIZE AND BUFFERLET SIZE IS NOT HANDLED
:    BY SDLC CURRENT VERSION.
:**********************************************************************

PATCH(910429,1000,JWANG,OUTD2+2,,6)
        J       OUTD6,,
CONPATCH(OUTD8+0E,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,1A)
        lb	R2,XLIMIT,R1,
        CR      R2,R8
        JLE     .+6
        LR      R2,R8
        JAL     R4,SLOR,,
        J       OUTD6,,
conpatch(uix+30,,2)
        sis     r2,dqplen
ENDPATCH(SPLIT MESSAGE IF SIZE EXCEEDS ISIS MAX SIZE- TO ORING)

  