
:************************************************************
: Patchname: SNRMBP.TST           Product version: SDLC 2.04
:   AUthor : James Wang                Organization: STS
:    DAte  : APr 12, 1990
:  Ticket  : 294644
: problem:   Host keep sending SNRMs to HIF while the network is still
:            backpressured. This will soon cause the command link block 
:            empty and then crash the slot.
:**********************************************************************


PA0PTR  EQ      ((PA0PTR+3)/4)*4
PATCH(900411,1500,JWANG,PA0PTR,,8)
SAVE1  WC      0
SAVE5  WC      0
CONPATCH(HSOP1,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,66)
        ST      R1,SAVE1,,
        ST      R5,SAVE5,,
        LB      R5,SCBLKS+SCBREL,RSCB,
        LHL     R1,LSDPTR,RL2,
HSOPLP  SIS     R5,1
        JL      HSOP
        AHI     R1,LSDLEN
        J       HSOPLP
HSOP    LHL     R5,LSDTAB+LSDDCB,R1,
        LHL     R1,DCBLKS+DCBPRT,R5,
        TBT     R1,TOISIS,,
        JN      HSOP02          :NO BACKPRSSURE, 
        L       R1,SAVE1,,
        L       R5,SAVE5,,
        J       HSOP10,,        :BACKPRESSURE IS ON, DISCARD SNRM
HSOP02  L       R1,SAVE1,,
        L       R5,SAVE5,,
        ST      R3,R3SAVE,,
        J       HSOP1+6,,
ENDPATCH(discard SNRM sent from host if network backpressure is still on)
 