        IF      \STOPLG                 :OPTION TO CONTROL PVC REBUILD ATTMPT

        LO      UTSLOG
        LO      UTSBLK
PATCH(900314,1200,WARNERD,VCTO1,,6)
        J       PA1PTR,,

CONPATCH(PA1PTR,,44)

        LR      RDEV,RDEV               :GET DEVICE NUMBER
        JN      RSTOR,,                 :IF NOT DEVICE ZERO GO TO NORMAL
        LHL     R5,LOGCNT,RDEV,RDEV     :GET LOGON ATTEMPT COUNTER FOR ZERO
        CHI     R5,06                   :IS IT AT SIX ATTEMPTS YET?
        JG      LGSZ,,                  :OVER SIX, STOP STOP OTHER DEVICES 
                                        :FROM BUILDING, ONLY ALLOW ZERO
        AIS     RDEV,1                  :OTHERWISE, LOOK AT NEXT DEVICE
        CLHI    RDEV,NSIDS              :ARE WE AT TOTAL NUMBER OF SIDS?
        JL      VCTO0,,                 :NOT YET GO BACK AND CHECK MORE SIDS
        J       TORET,,                 :YES, STOP LOOKING FOR REBUILD CAN.

LGSZ    J       TORET,,                 :COUNT EXCEED, DON'T CHECK OTHER SIDS
                                        :FOR REBUILD
RSTOR   AIS     RDEV,1                  :KEEP CHECKING OTHE SIDS FOR REBUILD
        CLHI    RDEV,NSIDS              :AS USUAL
        JL      VCTO0,,
        J       TORET,,


ENDPATCH(Patch to allow only one logon per username after count exceeded)

        ELSE
        EI

  