: **********************************************************************
: *                                                                    *
: *  File     : PBT053.PAT                                             *
: *  Customer : FIRN                                                   *
: *  Comments : Original file - GAUGIN.PAT                             *
: *           : Use in all FIRN PBT 5.05 code                          *
: *                                                                    *
: **********************************************************************

:  Patch to store correct DMODE when using PVC login process
:  #########################
:  #                       #
:  #  3270 PBT  5.05 ONLY  #
:  #                       #
:  #########################
:
:  Make sure we reflect terminal is in Logon Mode
:
PATCH(022085,1400,P/CHU,RLB305-6,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,80)
        LIS     R0,4
        LHL     R1,DPORT,RDCB,
        PUSH(R2)
        PUSH(R3)
        LHI     R2,0B3
        JAL     R4,SLOR,,
        POP(R3)
        POP(R2)
        LHI     R0,84
        JAL     R4,PUTCH,,
        JAL     R4,ELOR,,
        JAL     R5,SNLFB,,
        J       RLB308,,
:
ENDPATCH(PBT053.PAT - CORRECT DMODE FOR PVC LOGIN / PBT 5.05)
   