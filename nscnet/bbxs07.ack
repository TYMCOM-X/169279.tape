:    1. This patch apply bbxs version 7.01
:       
:    2. This patch allows to adjust ACK0/1 response to host.
:       Apply on only HIF, not on TIF.
:
:    3. TACK.n (n = line no.) is necessary on applied line.
:       If this is not defined, it works same as normal.
:       TACK.n is defined in 100 milseconds.
:
:

        PATCH(881117,1120,NIS.TSUJI,PA0PTR,,6*NBILIN)


        KILL    BSCLOP
BSCLOP	MACRO(OPT,DFAULT,MODS)[
OPT`LN	HS	0			:START OF TABLE FOR THIS OPTION
Q	EQ	0
	RE	NBILIN
	IF	$A`\OPT|Q|
	HC	$A`OPT|Q|`MODS		:USER SPECIFIED VALUE
	ELSE
	HC	$A`DFAULT`MODS		:DEFAULT
	EI
Q	EQ	Q+1
	ER
	]

     BSCLOP(TACK.,0,*$A60)              : Time interval area for line basis
                                        : Default = 0 and unit is 100 milsec.

        KILL    BSCLOP

WT.ACK  HS      2*NBILIN                : Time in fastc to send ACK0/1.

:
:       CHECK TIME INTERVAL AND WAIT
:
        LO      BSCPTP
        LO      BSCDEF
        LO      BSCHDX
RL2     EQ      R9      

        CONPATCH(XMT050,,6)
        J       PA1PTR,,

        CONPATCH(PA1PTR,,52)
        LHL     R0,TACK.LN,RL2          : LOAD TIME INTERVAL
        JE      XMT05C                  : IF ZERO, SKIP WAITING
        CLHI    R1,XCACK0               : ACK0 ?
        JEFS    XMT05A                  : IF YES, GOTO CHECK
        CLHI    R1,XCACK1               : ACK1 ?
        JN      XMT05C                  : IF NO, SKIP
XMT05A  A       R0,FASTC,,
        ST      R0,WT.ACK,RL2,RL2       : SET DEAD LINE
XMT05B  LO      BSCEXC
        JAL     R5,PDMISS,,             : DISMISS
        FO      BSCEXC
        L       R0,WT.ACK,RL2,RL2       : GET TIME.
        S       R0,FASTC,,              : 
        JGBS    XMT05B                  : AGAIN
        LB      R1,XMTOPC,RL            : GET OP CODE AGAIN
        LHL     R2,XMTCNT,RL2           : GET CNT AGAIN
        LHL     R3,XMTDAT,RL2           : GET DATA ADDR AGAIN
XMT05C  LHL     R0,THX.LN,RL2,          : GET XMT OP WAIT TIME
        SLLS    R0,TSCALE               : SCALE
        J       XMT050+6,,              : RETURN

        ENDPATCH(ADJUST TIME INTERVAL OF ACK0/1 FOR DIAMOND COMPUTER)

        FO      BSCPTP
        FO      BSCDEF
        FO      BSCHDX
    