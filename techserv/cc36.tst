
:      Patch REMOVED Jan. 27 - Too many problems with design


:DATE>   JULY 2, 1986
:VERSION>SDLC 1.12
:PURPOSE> IF FRAME LEN = 0 IS RECEVIED, SKIP 2 BYTES
:        AND CHECK IF RING NEEDS TO WRAP AROUND.

        LO      SFGRCV
        LO      SDLCDF
        LO      SIODEF
PATCH(861124,1600,J/MCKIERNAN,PA0PTR,,0C4)
RCVZRO  EQ      01
RCVBFS  EQ      0C0
        HS      0
RCVBFP  HC      0
RCVBUF  BS      RCVBFS
CONPATCH(RSTRT1+1A,,6)
RSTRT0  LH      R0,RBUF,R2,RSIO
CONPATCH(RSTRT1+28,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,66)
        LHL     R4,RCVBFP,,
        STB     RL,RCVBUF,R4,
        LIS     R0,RCVZRO
        STB     R0,RCVBUF+1,R4,
        LB      R3,0,RSIO
        STB     R3,RCVBUF+2,R4,
        LB      R3,1,RSIO
        STB     R3,RCVBUF+3,R4,
        LB      R3,6,RSIO
        STB     R3,RCVBUF+4,R4,
        LB      R3,8,RSIO
        STB     R3,RCVBUF+5,R4,
        AIS     R4,6
        CLHI    R4,RCVBFS
        JLFS    RSTRT2
        LIS     R4,0
RSTRT2  STH     R4,RCVBFP,,
        AIS     R2,2
        LHL     R3,RBUFRM,RL,RL
        CR      R2,R3
        JLEFS   RSTRT4
        LIS     R2,0
RSTRT4  STH     R2,RINDEX,RL,RL
        J       RSTRT0,,
ENDPATCH(TO SKIP OVER FRAME IF RCV. LENGTH = 0)
        FO      SFGRCV
        FO      SDLCDF
        FO      SIODEF


  