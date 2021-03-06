:****************************************************************
: PATCHNAME: NODATA.TST                   SDLC VERSION 1.12, 2.04
:    AUTHOR: JAMES WANG                   STS
:  CUSTOMER: HSBCNET                      NOV 9, 1989
: TASK:  THE SDLC INTERFACE HAS A BUG ON PROCESSING THE INFORMATION FRAME
:        WITH NO DATA. THE LENGTH OF '00' IS STORED IN THE COMMAND TYPE OF
:        COMMAND LINK ENTYR.
:        THIS PATCH WILL NOT TRY TO GET A BUFFERLET AND GET A COMMAND LINK
:        IF THIS INFO FRAME HAS NO DATA.
:***************************************************************************

PATCH(891109,1000,JWANG,NEEDBF,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,20)
        LR      R0,R0
        JE      RCVEND,,        :JUMP IF THIS INFO FRAME HAS NO DATA
        AIS     R2,2
        JAL     R4,GBB,,
        J       .+0A
        J       NEEDBF+0A,,
        J       SRGBB4,,
ENDPATCH(BUG FIX FOR INFO FRAME WITH NO DATA RECEIVED FROM THE LINE)
   