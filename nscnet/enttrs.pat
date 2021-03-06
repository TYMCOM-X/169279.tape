:***********************************************************************
:  <<<<< This patch apply to Consat version 6.03 >>>>>
:
:  (1). This patch enable to set transparent mode in Consat outdial
:       command mode.
:

        LO      OUTDIAL
        LO      SIGNAL
        LO      DATA
        LO      ISIS
PATCH(880619,1800,T/TSUJI,O.SET3,,6)
        J       PA1PTR,,                :
CONPATCH(PA1PTR,,10)
        LA      R5,JSETOP               :the set options
        JAL     R6,OPARSE,,             :Check accepted command mathching or not
        J       O.SET,,                 :Find what option follow for set command
CONPATCH(PA1PTR,,80)
JSETOP  PARCOM(CRDELAY,O.CRDL)
        PARCOM(EVEN,O.PAR)
        PARCOM(HALF,O.HALF)
        PARCOM(RXON,O.RXON)
        PARCOM(SPACE,O.PAR)
        PARCOM(TRANS,O.XPR)
        PARCOM(XON,O.XON)
        AC      /"00"00/
        HS      0

:  enter transparent mode routine

O.XPR   LR      R0,R0                   :comma or CR
        JG      SNDERR,,                :Current error code goes to terminal
        SBT     RP,TRANSP               :set transparent bit on
        L       RBP,.FTBUF,RPI          :next msg goes to TIF
        LHI     R4,ETMSIG               :enter Transparency
        JAL     RCH,PUTSIG,,            :put bufer
        LHI     R4,SXESIG               :set X-enable
        LIS     RBC,0                   :value 'Off'
        JAL     RCH,PUTSIG,,            :put buffer
        LHI     R4,SRXSIG               :set Reverse X-enable
        LIS     RBC,0                   :value 'Off'
        JAL     RCH,PUTSIG,,            :put buffer
        RBT     RP,XONENA               :disable X-on for remote terminal
        RBT     RP,YONENA               :disable RX-off for remote terminal
        J       O.SET1,,                :loop for next option
CONPATCH(STP+28,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,16)
        TBT     RP,TRANSP               :test transparent bit
        JN      INPUT9,,                :skip sending
        JAL     RCH,PUTSIG,,            :send the signal
        J       INPUT9,,                :and close record
ENDPATCH(Enter transparent mode)
        FO      OUTDIAL
        FO      SIGNAL
        FO      DATA
        FO      ISIS
  