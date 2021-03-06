:****************************************************************
: Patchname: QUTOFG.TST             Product version: SDLC 2.04
:   AUthor : JAmes Wang                Organization: STS
:  Customer: Chase                     Date written: Aug 8, 1990
: Description of problem:
:            For pu4 to pu4 , tif converts the address of 'ff' to the
:            pu address anf then sends the command to CU.
:            CU wants to see the address of FF. 
:********************************************************************


PATCH(900809,1000,JWANG,QUTOF3,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,12)
        STB     R4,CMDBLK+CLADD,RWORK,
        STH     RARG,CMDBLK+CLPTR,RWORK,
        J       QUTOF3+6,,
ENDPATCH(FORCE TIF NOT TO CONVERT THE ADDRESS 'FF' TO PU ADDR)

   