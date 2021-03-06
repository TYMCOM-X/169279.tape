
:*********************************************************************
: Patchname: OLRST3.TST                        organization: STS
:   AUthor:  JAmes Wang                          DAte written: OCT 18, 1990
:  CUstomer: SFBNET
: description of the problem: 
:            during the logon mode, line reset cause the BG to send
:            A2 and reset IIX message to oring. This forces the ISIS to
:            crash the slot with dispatcher crash.
:****************************************************************************


PATCH(901018,1700,JWANG,PA0PTR,,4)
LOGON   BC      0,0,0,0
CONPATCH(MSGB2,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,18)
        SBT     RPORT,LOGON,,
        JAL     R4,GETCH,,
        J       MSGB2+6,,
CONPATCH(MSGB6+2,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,18)
        STM     R0,LOGSAV,,
        RBT     R1,LOGON,,
        J       MSGB6+8,,
CONPATCH(OLRST3,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,24)
        STB     R0,LSDTAB+LSDCST,R11,
        LHL     RDCB,LSDTAB+LSDDCB,R11,
        LHL     RPORT,DCBLKS+DCBPRT,RDCB,
        TBT     RPORT,LOGON,,
        JN      OLRST2,,
        J       OLRST3+6,,
ENDPATCH(DONOT SEND A2 AND IIX RESET MSG DURING LOGON MODE IF LINE RESET)


   