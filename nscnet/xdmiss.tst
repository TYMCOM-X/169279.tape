:************************************************************
: Patchname: XDMISS.TST                    SDLC 2.04
:   AUthor : James Wang                    STS
:  CUstomer: NIS
:     Date : Nov 8, 1989
:  Task:
:       After xmitting last frame, force the interface to dismiss.
:       (at XSET56)
:*********************************************************************

   IF  SIOEVR
PATCH(891108,1000,JWANG,XSET56+6,,2)
        JFS     XSET60
ENDPATCH(DISMISS FORGROUND AFTER XMITTING LAST FRAME)
   EI

  