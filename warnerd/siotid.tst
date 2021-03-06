
:********************************************************************
: PATCH NAME: SIOTID.603             PRODUCT AND VERSION: ISCS 6.03
:     AUTHOR: JCR                           ORGANIZATION: STS
:   CUSTOMER: EPA (AND PUBLIC)              DATE WRITTEN: 4/3/88
: DESCRIPTION OF PROBLEM:  
:
:       PATCH TO SEND TID MESSAGE ON SIO PORTS. AID OPTION SHOULD NOT BE
:       SET FOR SIO PORTS REQUIRING 'PLEASE TYPE...' MESSAGE. ASSEMBLY
:       WARNING 'MISSING SIO PVC-ALO!!' SHOULD BE IGNORED.

        IF      NSPORT
        LO      DATA
        LO      CONSAT

:       THIS PART IS THE TID TIMER WHICH GETS SET WHEN THE 'PLEASE TYPE...
:       MESSAGE IS SENT AND SETS HANGWT IF 'A' OR CR IS NOT RECEIVED (IN
:       40-60 SECONDS, DEPENDING ON WHEN IN THE 20 SECOND CYCLE THE TIMER
:       IS SET). RUNS OFF OF EXISTING 20 SECOND LOGIC SINCE 16 SECOND STUFF
:       IS NOT ASSEMBLED FOR SIO-ONLY.

PATCH(880403,1730,JREILLY,PA0PTR,,NGRP*6)

TI.TO   HS      NGRP                    : HANG PORT IN 0-20 SECS
TI.TO1  HS      NGRP                    : HANG PORT IN 20-40 SECS
TI.TO2  HS      NGRP                    : HANG PORT IN 40-60 SECS

CONPATCH(SEC20+4,,4)
        JE      PA1PTR

CONPATCH(SEC20+1C,,4)
        J       PA1PTR

CONPATCH(PA1PTR,,40)
        LHI     RPOL,(NGRP-2)*2         : FOR EACH PAIR OF GROUPS
        LIS     R0,0
TIDTO   LIS     R1,0
        O       R1,TI.TO,RPOL,,         : TIME'S UP FOR THESE GUYS,
        O       R1,HANGWT,RPOL          : AND THESE ARE ALREADY SET,
        ST      R1,HANGWT,RPOL          : SO HANG 'EM
        L       R1,TI.TO1,RPOL,,
        ST      R1,TI.TO,RPOL,,         : UPDATE
        L       R1,TI.TO2,RPOL,,
        ST      R1,TI.TO1,RPOL,,        : UPDATE
        ST      R0,TI.TO2,RPOL,,        : AND RESET
        SIS     RPOL,4                  : ANYMORE GROUPS TO DO?
        JGE     TIDTO                   : YES, GO TO IT
        J       EXDISM,,                : NO, END OF TIME-OUT ROUTINE

:       THIS IS WHERE SIO HANG-ANSWER DETECTS DSR + CP. WE ARE GOING TO 
:       SEND THE TID MESSAGE, SET THE TIMER, AND LOAD THE TID RECEIVER
:       INSTEAD OF SENDING 'PLEASE LOG IN:'.

CONPATCH(QHAN15-1E,,6)
        J       PA1PTR,,

CONPATCH(PA1PTR,,0DE)
XSTIDM  L       RBP,.TTBUF,RPI          : GET TO-TERMINAL POINTER
        LA      R6,LSMS0,,              : TID MESSAGE
        JAL     R9,MSG,,                : GO SEND IT
        RBT     RP,TI.TO,,              : SET 40-60 SEC TIME-OUT
        RBT     RP,TI.TO1,,             :       "
        SBT     RP,TI.TO2,,             :       "
        SBT     RP,C.ACP,,              : SET PORT ACTIVE
        LA      R0,VSIOTI               : GET SIO TID RECEIVER
        ST      R0,.VSTAT,RPI           : AND STORE IT

:       THIS IS THE RECEIVER SIO WILL USE WHILE WAITING FOR A RESPONSE TO
:       'PLEASE TYP...'. IF WE GET AN 'A', RESTORE NORMAL RECEIVER AND GO
:       ON TO 'PLEASE LOG IN:'. IF AN 'O', SET SEVBIT TO FORCE SPACE PAR-
:       ITY AND CONTINUE AS WITH 'A'. IF A 'CR', RESEND MESSAGE. IGNORE
:       ANYTHING ELSE.

VSIOTI  LHL     R9,OCMSOF-2*.SPORT,RP2  : GET CMD OFFSET
        LH      R0,OCMSIO,R9            : GET CMD/STATUS
        OH      R0,OCMSIO+IO,R9         : GET ALTERNATE CMD/STATUS
        NHI     R0,200                  : CHECK FOR COMPLETED STATUS
        JEFS    VSIOT1
        JAL     RCH,SIOBSY              : CHECK FOR POSSIBLE HUNG OUTPUT
        NOP                             : PLACEHOLDER FOR ERROR RETURN
VSIOT1  LHL     R9,XINSIO,RP2           : GET POINTER TO CURRENT BUFFER
        LH      RBC,0,R9                : LOOK AT FIRST CHARACTER
        JGE     VSIOT3                  : SIO'S BEEN HERE, LEFT A CHARACTER?
        LR      R8,R9                   : NOTHING HERE, PERHAPS IN NEXT BUFFER
        AHI     R9,SIBFSZ
        NHI     R9,-SIBFSZ              : WRAP TO NEXT BUFFER?
        THI     R9,(NSIOBF-1)*SIBFSZ    : IF ON, NOT YET TIME TO WRAP
        JNFS    VSIOT2                  : TO FIRST BUFFER FOR THIS PORT
        SHI     R9,NSIOBF*SIBFSZ        : TIME TO WRAP
VSIOT2  LH      RBC,0,R9                : ANYTHING IN NEXT BUFFER?
        JL      VDEF                    : NO, TRY NEXT FOREGROUND TIME
        LH      R0,0,R8                 : YES, CHECK ORIGIONAL POINTER
        JLFS    VSIOT3                  : STILL NOTHING, USE CURRENT RBC
        LR      R9,R8                   : YES, USE ORIGIONAL POINTER
        LR      RBC,R0                  : AND GET CORRECT CHARACTER IN RBC
VSIOT3  TS      0,R9                    : RESET CELL TO -1
         IF     SHIST;  JAL     R0,SHISTY       : TRACE;        EI
        AIS     R9,2                    : BUMP POINTER TO NEXT CHARACTER
        STH     R9,XINSIO,RP2           : AND STORE INDEX
        RBT     RP,D.PAS2               : CANCEL ANY BREAK IN PROGRESS
        RBT     RP,D.PAS1
        STB     RBC,CHRSIO              : SAVE THE DATA CHARACTER
        LHI     R5,7F                   : MASK
        NR      R5,RBC                  : LOW-ORDER 7 BITS
        CLHI    R5,0D                   : CR?
        JE      XSTIDM                  : YES, RESEND 'PLEASE TYPE...'
        NHI     R5,1F                   : MASK IT SOME MORE (LIKE ASYNC)
        CLHI    R5,1                    : A?
        JE      VSIOT4                  : YES, GO CANCEL TIME-OUT AND CONTINUE
        CLHI    R5,0F                   : O?
        JN      VSIOT2                  : NO, CHECK NEXT CHARACTER
        SBT     RP,SEVBIT               : YES, LETS DO SPACE PARITY
VSIOT4  RBT     RP,TI.TO,,              : CANCEL TIME-OUT
        RBT     RP,TI.TO1,,             :       "
        RBT     RP,TI.TO2,,             :       "
        LA      R0,VSIO,,               : YES, GET NORMAL RECEIVE FILTER
        ST      R0,.VSTAT,RPI           : RESTORE IT
        LHI     R4,TID.S                : SET AS SIO-TYPE TERMINAL
        J       QHAN15-16,,             : AND CONTINUE...

:       LASTLY, HERE'S WHERE WE MODIFY THE SIO TRANSMITTER (XSIO) TO
:       OUTPUT SPACE PARITY IF SEVBIT IS SET (I.E. IF TID IS 'O')

CONPATCH(XSIO3B+10,,6)
        J       PA1PTR,,

CONPATCH(PA1PTR,,20)
        TBT     RP,SEVBIT               : DO WE WANT SPACE PARITY?
        JEFS    XSIO3C                  : NO, GO SEE IF WE WANT EVEN
        LR      RBC,R0                  : YES, ITS ALREADY SPACE IN R0
        J       XSIO4,,                 : JUMP BACK AND SEND IT
XSIO3C  TBT     RP,PARITY               : DO WE WANT EVEN PARITY?
        JE      XSIO4,,                 : NO, GO SEND WHAT WE GOT
        J       XSIO3B+16,,             : YES, JUMP BACK AND MAKE IT EVEN

ENDPATCH(PATCH TO SEND TID MESSAGE ON SIO PORTS.)

        FO      CONSAT
        FO      DATA
        EI      :NSPORT

:************************************************************************


    