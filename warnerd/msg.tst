Q        EQ 0
         RE MAXHST
         ORG HOSTAB+3+Q*HSTLEN
                IF -MSGWT|Q|
                REMARK %ERROR CANT USE NEGATIVE VALUE
                ELSE
        IF -MSGWT|Q|*(1-MSGWT|Q|)*(1+MSGWT|Q|)
        REMARK %ERROR  YOU BOOB ZERO OR ONE
        ELSE
      IF \MSGWT|Q|
      BC MSGWT|Q|
      ELSE
      EI
        EI
                EI
Q        EQ Q+1
         ER
 