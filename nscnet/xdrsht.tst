:============================================================
:(nscnet)XDRSHT.TST
:CODE for: XCOM v4.03/5.10
:note:  This patch display only a line for each RING
:       in order to get short RING trace quickly.
:       if XDRSW NE zero, display only a line for each data
:       message
:wrote: 19 APR 1991     auth: Yuki Furuta (NIS) 
:===========================================================

        lo      fpd
PATCH(910419,2030,NIS.FURUTA,XDRISD,,6)
        J       XDRSP0,,

CONPATCH(PA1PTR,,26)

XDRSP0  LB      R0,XDRSW
        JNFS    XDRSP1          :OPTION ENABLE 
        SVC     0B,XDRASC,,     :NO
        J       XDRISD+6,,

XDRSP1  AIS     R1,1            :INCREMENT RING INDEX
        CR      R1,RS           :BOTTOM OF RING
        JLFS    XDRSP2          :NO
        LIS     R1,0            :YES
XDRSP2  SIS     R6,1            :DECREMENT MSG LENGTH
        JLE     XDRISK,,        :FINISHED RETURN TO MAIN
        J       XDRSP1          :INCREMENT R1

CONPATCH(PA0PTR,,2)
XDRSW   HC      100
ENDPATCH(SHORT ISIS RING TRACER)
   