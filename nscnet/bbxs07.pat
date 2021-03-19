        IF      \BJSN
:=======================================================================
:
:       CENTER CODE & STATION CODE = USER NAME
:
:=======================================================================
:
        LO      FCB
        LO      R100
        LO      LINE
        LO      MAIN
PATCH(880302,1500,NIS.KOBAYASHI,DAT261+4,,2)
        LIS     R5,7            :ADVANCE THE POINTER TO THE CALLING CENTR ID.
CONPATCH(DAT264-2,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,20)
        LHI     R5,$A 14        :MOVE THE USER ID CENTER BLOCK
DAT269  LB      RDATA,BBUFER+BBSZ-1,RABI,RABIX
        JAL     R4,ADDBLK,,
        JAL     R4,ADVRBI,,
        SIS     R5,1
        JGBS    DAT269
        J       DAT267,,
ENDPATCH(USER NAME = CENTER CODE + STATION CODE)
        FO      FCB
        FO      R100
        FO      LINE
        FO      MAIN
        EI      (\BJSN)
