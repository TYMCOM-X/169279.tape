:*************************************************************************
: PATCHNAME: NOQXID.TST                     PRODUCT VERSION: SDLC 2.04
:   AUTHOR : JAMES WANG                       DATE WRITTEN : JULY 12, 1991
:  CUSTOMER: HSBCNET
: DESCRIPTION OF PROBLEM:
:    HIF KEEPS SENDING XID TO TIF AND SOON FILLS UP THE WHOLE COMMAND LIST
:    BLOCK. THIS CRASHES THE SLOT.
:    THIS PATCH WILL CHECK IF THE XMT QUOTA REACHES ZERO. IF REACHES ZERO,
:    DISCARD INCOMING QXID SENT FROM HIF.
:**************************************************************************

PATCH(910712,1000,JWANG,PA0PTR,,2)
XIDCNT  HC      0
CONPATCH(QUTOFG+0E,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,32)
        CLHI    R8,0FFF9
        JN      QUT5            :NOT QXID, RETURN
        LH      R3,SCBLKS+SCBXQA,R13,
        JG      QUT5
        LHL     R3,XIDCNT,,
        AIS     R3,1
        STH     R3,XIDCNT,,
        J       QUTOF2,,        :DISCARD QXID
QUT5    BBLOAD  R3,DCBLKS+DCBBHP,RDCB,
        J       QUTOFG+14,,
ENDPATCH(DISCARD QXID SENT FROM HIF WHEN XMT QUOTA REACHES ZERO)
