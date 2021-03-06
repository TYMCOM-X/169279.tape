:--------------------------------------------------------------
:
: INTERFACE : CMTK
: VERSION   : 6.01
:
:       Fixing bug of CR/LF for printer.
:
:       1. CMTK sends LF and CR to printer.
:
:       2. Some printer (made by NEC) doesnot feed line 
:          when it receives LF and CR. 
:          If CR and LF is received, it works well.
:
:-----------------------------------------------------------------------
:
        IF      \PRTSW
       LO    PRT
PATCH(090386,1430,M/TOCHIKAWA,PNTNL,,6)
       J     PA1PTR,,
CONPATCH(PA1PTR,,1A)
       LHI   R0,A.CR                      : SEND  C/R
       JAL   R4,PUTONE,,
       LHI   R0,A.LFED                    : SEND  L/F
       JAL   R4,PUTONE,,
       J     PNTCR+0A,,
ENDPATCH(NEC PRINTER PROBLEM    L/F,C/R ---> C/R,L/F )
       FO    PRT
        EI
   