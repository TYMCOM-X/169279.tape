PATCH(900314,1200,WARNERD,PA0PTR,,NSIDS)
LOGCNT  HS      NSIDS                   :CREATE AREA FOR NUMBER OF PVC
                                        :REBUILD ATTEMPTS
        lo      utsblk
        lo      utslog
CONPATCH(LZAP+6,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,34)
        LHL     RDEV,DDEV,RDCB,         :GET DEVICE NUMBER
        SDLOAD  R6,DCBSID,RDCB,         :GET SID DCB
        LB      R5,SIDTAB+LNPVC,R6,     :TEST IF PVC
        JE      LZAP+0C,,               :NOT IT, GO BACK

        LB      R5,DLFLD,RDCB,          :TEST IF CIRCUIT STATE NATIVE
        CLHI    R5,L.NAT
        JE      LZAP+0C,,               :NOT IT, GO BACK

        LHL     R5,SIDTAB+SIDABS,R6,    :TEST CIRCUIT DISABLE BY UOM
        TBT     R5,NOBILD,,
        JN      LZAP+0C,,               :SKIP IF DISABLED

        LIS     R5,1                    :ADD ONE EACH TIME THROUGH
        AHM     R5,LOGCNT,RDEV,RDEV     :AND STORE IN COUNTER AREA
        J       LZAP+0C,,


CONPATCH(VCTO1-0C,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,3e)
        LHL     R5,LOGCNT,RDEV,RDEV     :GET REBUILD COUNT
        CHI     R5,05                   :SEE IF TRIES ARE AT 5 YET
        JG      PHASE1,,                :YES, SLOW DOWN ATTEMPTS
        AI      R1,LGINTV*RATE          :NO, KEEP TIMER SAME
        J       VCTO1-6,,               :GO BACK
PHASE1  CHI     R5,07                   :SEE IF TRIES ARE AT 7 YET
        JG      PHASE2,,                :YES, SLOW DOWN ATTEMPTS EVEN MORE
        AI      R1,LGINTV*RATE*5        :DOUBLE REBUILD (5 MINS.)
        J       VCTO1-6,,               :GO BACK
PHASE2  AI      R1,LGINTV*RATE*8        :TRIPLE REBUILD (8MINS.)
        J       VCTO1-6,,               :GO BACK

CONPATCH(PVCB6+18,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,14)
        LHL     RDEV,DDEV,RDCB,         :GET DEVICE NUMBER
        LIS     R5,0                    :SET COUNTER BACK TO ZERO
        STH     R5,LOGCNT,RDEV,RDEV
        J       PVCB6+1E,,              :GO BACK


ENDPATCH(Three phase timer for PVC rebuild attempts)
    