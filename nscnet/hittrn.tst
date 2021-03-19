:-------------------------------------------------------------------
:
:       This is patch support a transparent logon to Hitachi host
:
:------------------------------------------------------------------
:
        LO      LOGON
PATCH(910423,1200,Iku,DSP224+10,,6)
        J       DSP227,,
ENDPATCH(Transparent(XPRT) logon to Hitachi host)
        FO      LOGON
