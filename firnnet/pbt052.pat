: **********************************************************************
: *                                                                    *
: *  File     : PBT052.PAT                                             *
: *  Customer : FIRN                                                   *
: *  Comments : Original file - FNSENQ.PAT                             *
: *           : Use in all FIRN PBT 5.05 code                          *
: *                                                                    *
: **********************************************************************

::
::  Patch for Unidentifiable Message from Remote
::  For FIRN crash 10/09/84   PC
::
        LO      BSCPTP
PATCH(122184,1100,P/CHU,SENQ+26,,2)
        HC      PA1PTR-PSEG
CONPATCH(PA1PTR,,10)
        LHI     R3,XMTINV
        JAL     R5,GOTERR,,
        J       IRESET,,
        FO      BSCPTP
ENDPATCH(PBT052.PAT - DON'T CRASH IF RECEIVE UNIDENTIFIABLE MSG)
::
::  End Patch  10/09/84  PC
::
::  Make sure n-one else uses the ssame patch area
::
P0END   EQ      PA0PTR
P1END   EQ      PA1PTR
    