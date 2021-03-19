        LO BSCDEF
        LO BSCPTP
        LO MAIN
        LO FCB
        LO R100
        LO IR100
:  Patch to send FORWARD ABORT control message when EOT received from
:  terminal after terminal gave up awaiting ACK from remote end.  This
:  is during SRWACK state.  If EOT is encountered during data transfer
:  (i.e. after ETB) it will be sent to remote end rather than leaving
:  HIF in TTD-NAK loop.  This is during SRCV state.       DEW    01/10/90

PATCH(891218,1730,WARNERD,IRABRT,,6)
        J       PA1PTR,,

CONPATCH(PA1PTR,,46)

        CLHI    R0,RCDATB       : SEE IF THIS IS EOT IN SRCV STATE
        JE      EABRT,,         : IF SO, SHIP EOT OUT

        ROPQND(FFFORW)          : NEW CONTROL MESSAGE 091D FOR EOT RECEIVED
        LIS     R0,0            :RESET COUNTER
        STB     R0,RETRY,RL,    :OLD INSTRUCT
        J       IRABRT+6,,      :AFTER GIVING UP WHEN NO ACK IS RECEIVED FOR
                                :DATA PREVIOUSLY TRANSMITTED
EABRT   ROPQND(FFEOT)           :CONTROL MESSAGE FOR EOT
        LIS     R0,0            :RESET COUNTER
        STB     R0,RETRY,RL,    :OLD INSTRUCT
        J       IRABRT+6,,      :GO BACK

ENDPATCH(send 091d instead of 0911 for FORWARD ABORT and 0911 for EOT)
