:***************************************************************************
: Patchname: DRTDTR.TST                   PRODUCT VERSION: sdlc 1.12
:    AUTHOR: JAMES WANG                   STS
:  CUSTOMER: UKNET                        DATE: OCT 31, 1989
: TASK: WHEN MONITOR USER SHUT/RSHUT THE TIF, LTIME IS INCREMENTED BY
:       7FFF AND THEN DTR STAYS IN OFF STATE UNTILL SLOWC INCREASES
:       VALUE BY 7FFF. THIS PATCH WILL INCREMENT LTIME BY 'DTROFF' VALUE.
:       IF 'DTROFF' NOT DEFINED ANYWHERE BEFORE GENNING THIS PATCH, THE DEFAULT
:       VALUE FOR 'DTROFF' WILL BE '3C' SECONDS. THAT MEANS THE DTR WILL
:       REMAIN OFF FOR ABOUT 60 SECONDS (decimal).
:
: IF OTHER VALUE FOR DTROFF TO BE USED, YOU NEED ADD 'value[DTROFF:' IN
:  THE COMMAND FILE (BEFORE '(SNAPAT)DRTDTR.TST' OR ADD 'OPTION(DTROFF,
:  value)' IN THE SLOT TYMFILE (tif only).
:
:  for example: to leave DTR OFF for 2 minutes, use '78[DTROFF:' in command
:               file or use 'LOPTION(DTROFF,78)
:
:******************************************************************************

   IF  \DTROFF
   ELSE
DTROFF  EQ      3C
   EI

PATCH(891031,1400,JWANG,DRTDTR+14,,4)
        AHI     R0,DTROFF
ENDPATCH(DEFINE A TIMER TO LEAVE DTR OFF WHEN SHUT/RSHUT LINE IN TIF)

