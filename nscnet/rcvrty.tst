:=======================================================================
:RCVRTY.TST
:  PRODUCT: BBXS            VERSION: 7.01
:  DATE:    17 OCT 1990     AUTH:    NIS.FURUTA
:PROBLEM:
:  The case of 'lost sync' under 'SRCV' state, code jumps to RCVRTY and
:  check whether RCVTIM is over or not. But original code does not reset
:  R0 to original RCVTIM value, just subtract FASTC, the remaining R0 is
:  the diference of the timeout.
:=======================================================================

        LO      BSCPTP
	LO	BSCDEF

        IF      PTPTSW
PATCH(901017,1600,NIS.FURUTA,RCVRTY+34,,6)
        ELSE
PATCH(901017,1600,NIS.FURUTA,RCVRTY+2E,,6)
        EI
RCVRT2  J       PA1PTR,,

CONPATCH(PA1PTR,,18)
        S       R0,FASTC,,              :CHECK TIME OVER
        JLE     RCVRT2+0A,,             :BACK TO SOURCE
        L       R0,RCVTIM,RL2,RL2       :GET ORIGINAL END TIME AGAIN
        J       RCV100,,                :CONTINUE TO READ
ENDPATCH(RESET RTIME AT RCVRTY)

	FO	BSCPTP
	FO	BSCDEF
