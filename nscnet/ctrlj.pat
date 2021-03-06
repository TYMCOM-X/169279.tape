:************************************************************
:       <<<<< This patch apply to Consat version 6.03 >>>>>
:
:       (1). This patch enable to set RBP option off on login mode
:            when user type ^J before username.
:
        LO      SIGNAL
        LO      DATA
        LO      LOGGER
PATCH(880624,1500,T/TSUJI,LOG12,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,2C)
        SIS     RBC,1A-15               : ^Z *500.sdw
        JNFS    LOG13                   :
        SBT     RP,HANGWT               : Hang the user
        J       RELOG,,                 : Skip to log to check if more
                                        : character present
LOG13   AHI     RBC,1A-0A               : ^J = RBP off (Only in Japan)
        JN      RELOG,,                 :
        LHI     R4,SRXSIG               : (Set Reverse X-enabe =42) get
        L       RBP,.TTBUF,RPI          : set to-terminal buffer pointer
        LIS     RBC,0                   :
        JAL     RCH,PUTSIG              : Put a (data) character
        J       RELOG,,                 : return
ENDPATCH(Add RBP off function by ^J)
        FO      LOGGER
        FO      DATA
        FO      SIGNAL
 