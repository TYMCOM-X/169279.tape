:***********************************************************************
: Patchname: ILRST.TST                 Product version: SDLC 2.04
:   Author : James Wang                      organization: STS
:  Customer: VA                              DAte written: APR 12, 1990
: Description of problem:
:   incoming line reset and the circuit state is changed to 2A for 
:   non-active circuit. This circuit state change causes all incoming
:   pvc request for this particular PU be rejected by the interface.
:************************************************************************

PATCH(900412,0900,JWANG,ILRST1+2A,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,18)
        SBT     R1,LCBTAB+BPINIT,R4,
        LHL     RDCB,LSDTAB+LSDDCB,R11,
        JE      ILRST2,,
        J       ILRST1+30,,
ENDPATCH(ILRST ACCIDENTLY CHANGE THE CIRCUIT STATE FOR NON-ACTIVE CIRCUIT)
 