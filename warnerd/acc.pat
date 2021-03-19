        LO      ILS00

PATCH(891121,1730,WARNERD,PA0PTR,,14)
TMP1    WS      3
ACCMSG  BC      0B7

CONPATCH(ILSL1,,6)
        J       PA1PTR,,

CONPATCH(PA1PTR,,6C)

        ST      R0,TMP1,,
        ST      R1,TMP1+4,,
        ST      R2,TMP1+8,,

        LIS     R0,8
        LHL     R1,IPORT
        LB      R2,ACCMSG
        JAL     R4,SLOR,,
        LIS     R0,0
        JAL     R4,PUTCH,,

        LHI     R0,0E009
        JAL     R4,PUTH,,

        LIS     R0,05
        JAL     R4,PUTCH,,

        LB      R0,F.LINE,RAFCB,
        JAL     R4,PUTCH,,
        JAL     R4,ELOR,,

        L       R0,TMP1,,
        L       R1,TMP1+4,,
        L       R2,TMP1+8,,

        LB      R1,F.LINE,RAFCB,
        J       ILSL1+6,,

ENDPATCH()
