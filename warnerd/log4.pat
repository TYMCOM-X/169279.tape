        LO      CONSAT
        LO      DATA
        LO      ISIS
        LO      LOGGER

        ORG     LOG4+4
        HC      0,0,0
        ORG     LOG4+4
        J       PATCH1,,

        ORG     PATCH1
        RE      14
        HC      0
        ER
        ORG     PATCH1
        ST      R2,TEMP2,,
        LHI     R2,0
        STB     R2,LOGCNT,R14,,
        L       R2,TEMP2,,
        SBT     RP,FL.LOG,,
        J       LGRET,,
PATCH1  EQ      .
    