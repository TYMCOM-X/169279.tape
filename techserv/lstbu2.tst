        LO      BSCCHR
        LO      BSCRCV
:--------------------------------------------------------------------------
: Patch name:  LSTBU2.171                           Product and version: PBT 17.01
:     Author:  Jeff Morden                             Organization: STS
:   Customer:  AUTOSTRADE                                Date Written: 5/18/91
: Problem/Reason for patch:
:
:  When a log was executed across a gateway to a down host the gateway was
:  returning a canned banner that was not terminated in a carriage return.
:  The PBT had put this banner/message in a buffer with the intention of
:  sending it to the terminal user.  Since no carriage return was received 
:  the PBT never completed the bisync message or put it on the queue for
:  transmission.  This buffer was also not returned to the free pool with the
:  result that the buffer was "lost" to any further use.  This patch watches
:  for any global status messages indicating "host down" and if a bisync
:  has been started will insure that it is properly completed.

        IF      ANY3624
PATCH(051891,1100,J/MORDEN,RLB611+20,,6)
        ELSE
PATCH(051891,1106,J/MORDEN,RLB611+0E,,6)
        EI
        J       PA1PTR,,
CONPATCH(PA1PTR,,106)
        PUSH(R7)
        CI      R7,2C           :IS IT HOST NOT AVAILABLE MESSAGE
        JE      MSBF            :YES - MAKE SURE BUFFER FROM STEXT IS TERMINATED
        CI      R7,34           :IS IT A HOST DOWN MESSAGE
        JE      MSBF            :YES - ALSO MAKE SURE BUFFER NOT LOST
        CI      R7,38           :IS IT HOST SHUT MESSAGE
        JE      MSBF            :DO SAME
        J       NHOSTD          :OTHERWISE NOT A LOGON FAILURE DUE TO HOST PROB
MSBF    LHL     RBA,DIRBA,RDCB, :CHECK IF BISYNC MESSAGE HAS BEEN STARTED
        JE      NHOSTD          :TREAT LIKE NOT A HOST DOWN MESSAGE
        LH      RBX,DIRBX,RDCB, :GET INDEX OF LAST CHARACTER PUT IN BUFFER
        LHI     R0,RETX         :INSERT ETX INTO BUFFER TO TERMINATE MESSAGE
        JAL     R5,PBCIN,,
        JAL     R5,PBEIN,,      :END THE MESSAGE
        LHL     RDEV,DDEV,RDCB, :GET DEVICE NUMBER
        LHL     R0,DIR0,RDCB,   :GET CONTROL BITS
        OHI     R0,ETXBIT       :SHOW END OF MESSAGE
        PUTCMD(IN,RDEV,RDEV)
        RLCMD(IN,RDEV,RDEV)
        LIS     RBA,0
        STH     RBA,DIRBA,RDCB, :RESET TO SHOW NO MESSAGE PENDING
NHOSTD  POPPSH(R7)
        J       RLB611+14,,
CONPATCH(STEXT4+4,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,20)
        JAL     R5,PBCIN,,
        STH     RBX,DIRBX,RDCB,         :SAVE CURRENT BUFFER OFFSET
        J       STEXTZ,,
        IF      ANY3624
CONPATCH(STEXT+20,,6)
        ELSE
CONPATCH(STEXT+12,,6)
        EI
        J       PA1PTR,,
CONPATCH(PA1PTR,,24)
        CI      R0,ACR          :DID WE GET A CARRIAGE RETURN
        JE      STEXT6,,        :GO END MESSAGE
        CI      R0,3B           :IS IT A SEMI-COLON FROM ECHOED USERNAME
        JE      STEXT6,,        :ALSO END BISYNC MESSAGE
        J       STEXT+1A,,      :BACK TO SOURCE
CONPATCH(STEXTZ,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,14)
        SIS     RRC,1           :TEST FOR END OF TEXT MESSAGE
        JE      STEXT6,,          :GO END PARTIAL MESSAGE
        AIS     RRC,1           :RESTORE BEFORE RETURNING TO SOURCE
        JALR    RSL,RSL         :FROM SOURCE
        J       STEXT,,
ENDPATCH(COMPLETE BISYNC MESSAGE WHEN LOGON FAILS ACROSS GATEWAY)
        FO      BSCCHR
        FO      BSCRCV
    