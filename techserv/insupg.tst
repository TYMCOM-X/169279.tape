:---------------------------------------------------------------------
: Patch name:  INSUPG.903                     Product and Version:  PBT 9.03
:     Author:  JEFF MORDEN                            Organization:  STS
:   Customer:  INS                            Date Written:  080789
: Description of Problem:  #
:       THIS PATCH IS FOR USE BY INS ONLY.  IT CONTAINS UPGRADS OF
:       THREE PBT 5.03 PATCHS SO THEY WILL BE COMPATABLE WITH V 9.03
:       OF PBT.  
:
:---------------------------------------------------------------------




:FIRST PATCH ALLOWS THE PBT TO SHOW A PRINTER DEVICE IS BEING LOGGED
:ON AT THE NETWORK SERVICES SCREEN.  WITHOUT THIS PATCH THE PRINTER
:STATUS WILL ONLY SHOW STATES OF EITHER IDLE OR BUSY.
:

PATCH(080789,1100,J/MORDEN,XPRT30+26,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,3C)
        TBT     R14,DEVBUSY,,           :IS THE PRINTER BUSY?
        JE      XPRT30+30,,             :NO - SHOW DEVICE IS IDLE
        LHL      R1,DEVTAB,R14,R14       :YES - FIND STATUS OF DEVICE
        LB      R1,DMODE,R1,            :GET MODE OF DEVICE
        CHI     R1,3                    :IS DEVICE IN NATIVE MODE
        JE      XPRT40,,                :YES - SHOW DEVICE BUSY
        LHL     RDEV,DDEV,RDCB,         :ELSE - GET DEVICE NMUMBER
        LA      R1,NETS5A,,             :GET ADDRESS OF LOGON STATE MESSAGE
        LB      RDEV,DEVLN,RDEV,        :GET LINE NUMBER
        SLLS    RDEV,1
        J       XPRT50,,                :SEND LOGON STATE TO NSS
CONPATCH(PA0PTR,,0C)
NETS5A  HC      $A10
        BC      SP.,SP.,SP.,L.,O.,G.,O.,N.,SP.,SP.

:
:NOW CORRECT MESSAGE LENGTH OF PRINTER STATUS MESSAGE
:
CONPATCH(NET50E,,2)
        HC      $A32

:
:NOW MAKE CHANGE IN WCC FOR PHASE IV CONTROLLERS
:
CONPATCH(NETS2+4,,2)
        BC      0C2

ENDPATCH(UPGRADE OF PBT 5.03 PATCHES TO 9.03)
    