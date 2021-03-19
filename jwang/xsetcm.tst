:**********************************************************************
: Patchname: XSETCM.TST                   Product version: SDLC 2.04
:    AUthor: James Wang                      Organization: STS
:  Customer: CANNET                          Date written: July 6,1990
: Description of problem:
:            SIO receiver was disabled. SIO hardware cause was unclear.
:            This patch is trying to mask off the SIO problem.
:            WHen last frame is transmitted, SDLC will disable the transmitter
:            and then this patch will force the sio to enable the receiver
:            no matter the receiver is disabled or still enabled.
: *** To use this patch, tymfile needs specify MSIOTP(M.TYP1) ****
:***************************************************************************

   IF   SIOEVR
PATCH(900706,1000,JWANG,XSET30+30,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,18)
        LI      R4,000613D9
        ST      R4,OCPW+4,RSIO,
        LI      R4,TXDSAB
        J       XSET32,,
CONPATCH(XSET62,,4)
        LHL     R4,OCPW+4,RSIO
CONPATCH(DTRUP1,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,14)
        ST      R3,OCPW,R4,
        LIS     R3,0
        ST      R3,OCPW+4,R4,
        J       DTRUP1+6,,
ENDPATCH(FORCE SIO TO ENABLE RECEIVER WHEN SDLC DISABLE THE TRANSMITTER)
   EI
