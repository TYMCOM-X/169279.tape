        FO FCB
        LO MAIN
        LO BSCPTP
        LO IR100
        LO R100
        LO BSCDEF

PATCH(891219,1730,WARNERD,IXNOBR,,6)
        J       PA1PTR,,

CONPATCH(PA1PTR,,112)

        RBT     R8,FORABR,,
        JE      IXNOBR+6,,
OPCHK   XOPCHK(COMP,DUMP,BOOT,BOOT)
BOOT    JAL     R5,CDEQUE,,
        J       OPCHK,,
DUMP    XOPDQU
        J       OPCHK,,
COMP    LIS     R0,0
        STB     R0,RETRY,RL,
        J       IRESET,,
ENDPATCH(IF FORWARD ABORT DEQUEUE DATA AND SEND EOT)
