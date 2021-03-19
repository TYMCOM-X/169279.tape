:-------------------------------------------------------------------
: 
: INTERFACE : CMTI
: VERSION   : 11.01
:
:       To avoid to display black square for null code of 
:       KANJI character (X"0000)
:
:       1. In native environment of SDLC, the null code KANJI character
:          (X"0000) is displayed as SPACE of KANJI character (X"4040)
:          on the terminal display. But CMT display it as an invalid KANJI 
:          character(black square).
:
:       2. So, this patch convert X"0000 KANJI character code to X"4040
:          KANJI character code for host.
:
:
:-------------------------------------------------------------------
:
        LO      TM
PATCH(900426,1000,NIS.KOBAYASHI,IBM2JIS,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,18)
        PUSH(R5)                        :FROM SOURCE
        LR      R0,R0                   :IS IT NULL KANJI CODE
        JN      IBM2JIS+6,,             :NO. BACK SOURCE
        LHI     R0,JIS.SP               :GET JIS SPACE
        J       EXTI2J,,                :EXIT ROUTINE
ENDPATCH(Suppoting of null code change to X"40)
        FO      TM
