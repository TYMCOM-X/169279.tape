
:*********************************************************************
: Patchname: SNRMHF.TST                Product version: SDLC 2.04
:   AUthor : James Wang                   Organization: STS
:  Customer: NIS                          DAte written: jan 31, 1990
: Description of the problem:
:       Fep sends snrm to hif while hif dispatch port is backpressured.
:       this incoming snrm will sonn fill out all cmooand link block
:       and then crashes slot.
: Task: set a limit on the number of snrms that hif will queue it up.
:       the label to define the limit is 'SNRMP'.
:
: NOTE: USER CAN DEFINE ANY VALUE FOR SNRMP IN SLOT TYMFILE WITH
:       'SNRMP   EQ  ??'. IF USER DOES NOT DEFINE A VALUE FOR SNRMS,
:       THIS PATCH WILL SET A DEFAULT VALUE OF 5 FOR SNRMP.
: Note: this patch is used on HIF only.
:
:***********************************************************************
 
   IF   (\(SHDPTS))!(\(SHDMPS))
 
        IF      \SNRMP
        ELSE
SNRMP   EQ      5
        EI
 
PA0PTR  EQ      ((PA0PTR+3)/4)*4
PATCH(910131,1000,JWANG,PA0PTR,,14+NPORT)
OUTDR3  WS      1
OUTDR4  WS      1
OUTDR5  WS      1
HSOPR3  WS      1
HSOPR5  WS      1
SNRMIN  BS      NPORT
CONPATCH(OUTDX1,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,5E)
        LHL     R11,CMDTBL,R7,R7
        CLHI    R7,2                      :snrm?
        JN      CMDTBL,R11,
        ST      R3,OUTDR3,,
        ST      R4,OUTDR4,,
        ST      R5,OUTDR5,,
        LHL     R3,DCBLKS+DCBLSD,RDCB,     :GET LSD
        LHL     R4,LSDTAB+LSDSCB,R3,       :GET SCB
        LB      R5,SCBLKS+SCBSTN,R4,       :GET RELATIVE # TO THE TOTAL STN
        LB      R3,SNRMIN,R5,              :GET SNRMIN
        SIS     R3,1                       :DECREMENT BY 1
        JL      .+0A                       :SKIP IF LESS THAN ZERO
        STB     R3,SNRMIN,R5,              :SAVE COUNTER
        L       R3,OUTDR3,,                :RESTORE R3
        L       R4,OUTDR4,,                :RESTORE R4
        L       R5,OUTDR5,,                :RESTORE R5
        J       CMDTBL,R11,,               :JUM
CONPATCH(HSOP1+14,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,2A)
        LB      R5,SCBLKS+SCBSTN,RSCB,     :GET RELATIVE #
        LB      R0,SNRMIN,R5,              :GET SNRM #
        CLHI    R0,SNRMP                   :LARGER THAN LIMIT?
        JGE     HSOP10,,                   :YES, DISCARD SNRM
        AIS     R0,1                       :INCREASE 1
        STB     R0,SNRMIN,R5,              :SAVE IT
        LB      R0,SCBLKS+SCBREL,RSCB,     :GET REL
        J       HSOP1+1A,,                 :JUMP
CONPATCH(HSOP13+18,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,3C)
       JAL      RLINK5,SXMT,,              :XMIT UA
       J        HSOP99                     :TIMEOUT
       ST       R3,HSOPR3,,                :SAVE R3
       ST       R5,HSOPR5,,                :SAVE R5
       LB       R3,SCBLKS+SCBSTN,RSCB,     :GET RELATIVE #
       LIS      R5,0                       :SET 0
       STB      R5,SNRMIN,R3,              :RESET TO ZERO
       L        R3,HSOPR3,,                :RESTORE R3
       L        R5,HSOPR5,,                :RESTORE R5
       J        HSOPXR,,                   :JUMP TO HSOPC
HSOP99 J        HSXTMO,,                   :JUMP TO TIMEOUT
CONPATCH(IZSCB0+18,,6)
       J        PA1PTR,,
CONPATCH(PA1PTR,,12)
       STB      R0,NXTSEC,R1,              :RESET TO ZERO
       STB      R0,SNRMIN,R1,              :RESET TO ZERO
       J        IZSCB0+1E,,                :JUMP
ENDPATC(SET A LIMIT FOR HIF TO QUEUE INCOMING SNRM FROM FEP)
    EI
 
 
 
    