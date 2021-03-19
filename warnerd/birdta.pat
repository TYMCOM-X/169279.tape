        SEG     0
        ORG     PATCH0
LOGCNT  BS      20
PORT    BS      1
TEMP1   WS      1
TEMP2   WS      1
TEMP14  WS      1
PATCH0  EQ      .
        SEG     1

        LO      CONSAT
        LO      DATA
        LO      LOGGER
        LO      ISIS

        ORG     XNF0
        HC      0,0,0
        ORG     XNF0
        J       PATCH1,,

        ORG     PATCH1
        RE      4C
        HC      0
        ER
        ORG     PATCH1
        ST      R1,TEMP1
        ST      R2,TEMP2
        LIS     R1,0
        STB     R1,PORT
TESTLG  TBT     R1,TATBIN
        JE      NOTLOG,,
        TBT     R1,LOGER
        JE      NOTLOG,,
        LB      R2,LOGCNT,R1
        CHI     R2,1E     :SHOULD BE 1E FOR 1/2 SEC = 15SEC.
        JGE     DISCCQ,,
        AIS     R2,1
        STB     R2,LOGCNT,R1
NOTLOG  AIS     R1,1
        STB     R1,PORT
        CHI     R1,20
        JL      TESTLG
        J       OUT,,
DISCCQ  L       R1,TEMP1
        L       R2,TEMP2
        ST      R14,TEMP14,,
        LB      R14,PORT,,
        JAL     R10,HANGUP,,
        L       R14,TEMP14,,
        ST      R1,TEMP1
        ST      R2,TEMP2
        LIS     R2,0
        LB      R1,PORT,,
        STB     R2,LOGCNT,R1
OUT     L       R1,TEMP1
        L       R2,TEMP2
        L       R0,RLA,RPOL,,
        N       R0,ASYNC,RPOL,,
        J       XNF0+8,,
PATCH1  EQ      .
