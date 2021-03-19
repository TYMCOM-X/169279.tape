        ORG     QHA5+0C
        HC      0,0,0
        ORG     QHA5+0C
        J       PATCH1,,

        ORG     PATCH1
        RE      17
        HC      0
        ER
        ORG     PATCH1
        TBT     RP,DINKS
        JE      EXIT
        L       RBP,.TTBUF,RPI,,
        LA      R6,LSMS1,,
        J       QHA5+14,,
EXIT    L       RBP,.TTBUF,RPI,,
        LA      R6,LSMS0,,
        J       QHA5+14,,
PATCH1  EQ      .
