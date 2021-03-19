:***********************************************************************
: Patchname: clrlsd.tst                      product version : 2.04
:    Author: James Wang                        Organization  : STS
:  CUstomer: KAL                               Date          : may 2, 1990
: description of the problem: 
:            When wrong requested station number is not found, the circuit
:            will be set in clearing state . this may cause the I/F to reject
:            any new incoming circuit.
:****************************************************************************

PATCH(900502,1700,JWANG,CLRLSD,,4)
        LHI     R0,22
ENDPATCH(USE 22 INSTEAD OF 23 WHEN THE REQUESTED DEST STATION IS NOT FOUND)


