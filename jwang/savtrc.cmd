 
:
:
: FILENAME: SAVTRC.204
: VERSION : SDLC 2.04
: WRITTEN BY: JAMES WANG
: DATE: AUG, 1991
:
: PURPOSE OF THE PATCH:
:   1. CUSTOMER IS NOT WILLING TO CRASH THE SLOT. BUT CUSTOMER IS STILL ASKING
:       US TO ANALYZE THE PROBLEM. WE NEED SOME WAY TO CAPTURE SOME VALUABLE
:       INFORMATIONS WITHOUT KILLING ANY USER CIRCUIT.
:   2. FOR SOME PROBLEM, WE ONLY NEED SOME VALUABLE INFORMATION. IT IS NOT
:      NECESSARY TO CRASH THE SLOT.
:***************************************************************************
:  TO USE THIS PATCH:
:     ADD FOLLOWING IN THE COMMAND FILE--
:          4000[P0SIZE:
:           NOTE: THIS NUMBER 4000 IS BASED ON TWO LINKS SLOT.
:           (APPROXIMATELY, 2000(HEX) OF P0SIZE PER LINK)
:          ASSEMBLE TRACE.204
:          ASSEMBLE <TRAP PATCHES>
:***************************************************************************
: VERSION 2.04
:  FORMAT OF SAVING TABLES:
:
:  IRING AND ORING --- SAME AS IN THE CODE.
:
:
:  FRAME TRACE TABLE ---  FFTRTB: STARTS AT FFTRTB+10, LENGTH ID FTRLEN.
:        THE FIRST 10 (HEX) BYTES ARE:
:        /4 BYTES OF CASE NUMBER/2 BYTES OF FTRLEN/2 BYTES OF FTRINP/...
:       ......../2 BYTES OF TRAP OCCURRENCE COUNTER/
:
: OUTPUT SECTOR ---  OSTBL
:     OSTBL CONTAINS ALL THE OUTPUT SECTORS FOR EACH LINK.
:     OSTBK IS THE STARTING ADDRESS OF OUTPUT-SECTOR SAVE AREA FOR LINK K.
:     OSTBL POINTS TO OSTB0. USE SECADR AND CCURSE AND SECBIA TO INTERPRET
:     THE TABLES OSTBK.
:
: RECEIVE BUFFER --- RCVTBL
:     RCVTBL CONTAINS ALL THE RECEIVE BUFFERS FOR EACH LINK.
:     RCVTK IS THE STARTING ADDRESS OF RBUF SAVE AREA FOR EACH LINK K.
:     RCVTBL POINTS TO RCVT0. USE RRINDE,TCVPTR TO INTERPRE RCVTBL.
:
: ROTOR LIST (INCLUDING NON-IFRAME OUTPUT AREA) --- TTCCL
:     TTCCK SI THE STARING ADDRESS OF ROTOR LIST SAVE AREA FOR LINK K.
:     TTCCL POINTS TO TTCC0.
:     LENGTH OF ROTOR LIST IS (TCCWK - TCCLK) FOR EACH LINK K.
:
: CURRENT REGISTERS --
:     REGSTK POINTS TO THE BEGINNING OF 16-REGISTERS TABLE FOR LINK K.
:
: CURRENT PORTS AND INTERNAL BLOCKS:
:     DPORTK, DCBK,SCBK,STNK.
:
:
:***************************************************************************
:
: STRUCTURE OF THIS PATCH:
:
: PART 1. DEFINE SAVING TABLES.
:
: PART 2. TRCSAV SUBROUTINE -- SAVE ALL THE ABOVE INFORMATIONS INTO PATCH0.
:
: PART 3. DISPLAY 'TRAP WAS CAUGHT ON LINK ??' BY DDT COMMAND 'HELP'.
:
: +++++++++++++++++++++++++++++++++
:  (NOTE: PART 4,5,6 WILL BE IN ANOTHER 3 PATCH FILE.)
: PART 4. REMOVE TRAPS WHICH WAS DESIGNED IN THE SOURCE CODE TO CRASH THE SLOT.
:         (NOTE: THIS WILL BE DONE BY REMOVING TRAP MICRO AND CALL TRCSAV
:                ROUTINE. THIS PART WILL BE PUT INTO ANOTHER PATCH FILE.
:                TRCSAV ROUTINE IS NOT CALLED UNLESS THE PATCH FOR PART 4 AND PART 5. USER OPTIONAL TRAP --NEW INTRODUCED TRAP.
:         (NOTE: THIS PART WILL BE PUT INTO ANOTHER PATCH FILE. TO CAPTURE
:                SOME PARTICULAR MPTON, WE USED TO WRITE A TRAP PATCH TO
:                CRASH THE SLOT. IF YOU DON'T WANT TO CRASH THE SLOT, YOU
:                CAN JUST CALL THE SUBROUTINE TRCSAV.
:
: PART 6. PRINT OUT THE SAVED TABLES AND SAVE THEM INTO A PDP FILE.
:         (MANUALLY READ ALL THE SAVING ATBLES AS STATED BELOW)
:          OR
:         (SIMPLY, USE THE COMMAND FILE --- TRCOUT.CMD. )
:
:
:*****************************************************************************
:
:**************************************************************
:
: WHEN THE PROBLEM HAPPENS, SAVE THE FOLLOWING SAVE AREAS INTO A FILE.
:
: FOLLOWINGS ARE THE ORING,IRING,FRAME TRACE,LSDTAB,PORT TABLE SAVE AREAS
:  (K IS THE LINK NUMBER)
:   :R ORINGK,ORSIZE+4
:   :R IRINGK,IRSIZE+4
:   :R PTPTBK,PTPSIZ+20
:   :R LSDTBK,LSDLEN*MAXSTN
:   :R PORTBK,10+MAXSTN
:
:........................................................
: FOLLOWINGS ARE NOT DONE YET.
:..... DCBLKS, SCBLKS, CMDBLK..... NEEDS TO BE SAVED TOO.
:
: FOLLOWINGS ARE THE OUTPUT SECTOR SAVE AREAS
:   :R SECADR,NSCTRS*4
:   :R SECBIA,NLINES*2
:   :R CCURSE+K,1 (THIS VALUE PLUS SECBIA POINTS TO A CELL INSIDE SECADR)
:   :R OSTBK,RBUFK-TCCWK
:
: FOLLOWINGS ARE THE RECEIVE BUFFER SAVE AREAS.
:   :R RRINDE+2K,2
:   :R RCVK,RBUFHS*2
:
: FOLLOWINGS ARE THE ROTOR LIST (INCLUDING NON-I-FRAME OUTPUT AREA)
:   FOR EACK LINK K.
:   :R TTCCLK,(TCCWK-TCCLK)  WHERE K IS THE LINK NUMBER
:
: CRASH REGISTERS.
:   :R REGSTK,10
:
:
:**************************************************************
:**************************************************************
:
:************************************************************************
:************************************************************************
:  PART 1 --- SAVE AREAS DEFINITIONS
:
:
PA0PTR  EQ      ((PA0PTR+3)/4)*4
TRCLEN  EQ      (IRSIZE+ORSIZE+PTPSIZ+LSDLEN*MAXSTN+48)*NLINES
PATCH(860519,1000,JWANG,PA0PTR,,TRCLEN+6C)
SAV0    WS      1
SAV1    WS      1
SAV2    WS      1
SAV3    WS      1
SAV4    WS      1
SAV5    WS      1
SAV6    WS      1
SAV7    WS      1
SAV8    WS      1
SAV9    WS      1
SAV10   WS      1
SAVREG  WS      10
:
:-----------------------------------------------------------------------
: SAVE AREAS FOR IRING,ORING,FTRTBL,PTRTBL. EACH BLINK HAS ITS
: OWN SAVE AREAS.
:-----------------------------------------------------------------------
:
IIRING   WS
    .DOB.(Q,0,NLINES)
IRING|Q| BS     IRSIZE+14
    .DOE.0
IRADR    WS
    .DOB.(Q,0,NLINES)
         WC     IRING|Q|
    .DOE.0
:
OORING   WS
    .DOB.(Q,0,NLINES)
ORING|Q| BS     ORSIZE+14
    .DOE.0
ORADR     WS
    .DOB.(Q,0,NLINES)
         WC     ORING|Q|
    .DOE.0
:
PPTPTB   WS
    .DOB.(Q,0,NLINES)
PTPTB|Q| BS     PTPSIZ+20
    .DOE.0
PTBADR   WS
    .DOB.(Q,0,NLINES)
         WC     PTPTB|Q|
    .DOE.0
:
LLSDTB   WS
    .DOB.(Q,0,NLINES)
LSDTB|Q| BS     LSDLEN*MAXSTN
    .DOE.0
LSDADR   WS
    .DOB.(Q,0,NLINES)
         WC     LSDTB|Q|
    .DOE.0
:
:---------------------------------------------------------------------
: SAVE AREAS FOR CRASH REGISTERS, PORT MAPPING TABLES, DPORT,IPORT,
: EPORT,ELCI. EACH LINK HAS ITS OWN SAVING AREAS.
: THESE LOCATIONS ARE DUMPED FROM THE CORRESPONDING LOCATIONS AT THE TIME
: THE TRCSAV ROUTINE IS CALLED. DPORTK/IPORTK/EPORTK/ELCHK MAY NOT
: CONTAINS THE RIGHT INFORMATION!!!! YOU MAY NEED CHECK THE PORTS MAPPING
: TABLES.
:------------------------------------------------------------------------
PA0PTR  EQ      ((PA0PTR+3)/4)*4
TRCLEN  EQ      4C
CONPATCH(PA0PTR,,TRCLEN)
    .DOB.(Q,0,NLINES)
TABLE|Q| WS
REGST|Q| WS     10
RPORT|Q| HS     1
DCB|Q|   HS     1
SCB|Q|   HS     1
ADDR|Q|  HS     1
MADR|Q|  HS     1
         HS     1
    .DOE.0
:
PA0PTR  EQ      ((PA0PTR+3)/4)*4
CONPATCH(PA0PTR,,4*NLINES)
TABLES   WS
    .DOB.(Q,0,NLINES)
         WC     TABLE|Q|
    .DOE.0
:
:
CONPATCH(PA0PTR,,10+MAXSTN)
PPORTB   WS
    .DOB. (Q,0,NLINES)
PORTB|Q| BS     10+MAXSTN
    .DOE. 0
PA0PTR    EQ    ((PA0PTR+3)/4)*4
CONPATCH(PA0PTR,4*NLINES)
PRTADR   WS
    .DOB. (Q,0,NLINES)
         WC     PORTB|Q|
    .DOE. 0
 
:
:
SIOXL   EQ      0
    .DOB.(Q,0,NLINES)
SIOXL   EQ      SIOXL+(RBUF|Q|-TCCW|Q|)
    .DOE.0
:
:=====================================================================
:
: FOLLOWINGS ARE THE THREE SAVE AREAS FOR
:    TCCLK------ OSECK----- TCCWK ------ RBUFK ------- SIOXK
:    |------------------------|------------|------------|
:       (1)                       (2)        (3)
:
:-----------------------------------------------------------
: ROTOR LIST (1)
:
:  SAVE AREA FOR  THE ROTOR LIST OF (TCCLK--TCCWK) FOR EACH LINK K.
PA0PTR  EQ      ((PA0PTR+3)/4)*4
TRCLEN  EQ      0
   .DOB.(Q,0,NLINES)
TRCLEN  EQ      TRCLEN+(TCCW|Q|-TCCL|Q|)
    .DOE.0
CONPATCH(PA0PTR,,0C*NLINES+TRCLEN)
TCCLL   WS
   .DOB.(Q,0,NLINES)
        WC      TCCL|Q|
   .DOE.0
TCCLEN  WS
   .DOB.(Q,0,NLINES)
        WC      TCCW|Q|-TCCL|Q|
   .DOE.0
TTCCL   WS
   .DOB.(Q,0,NLINES)
TTCL|Q| BS      TCCW|Q|-TCCL|Q|
   .DOE.0
TCLADR  WS
   .DOB.(Q,0,NLINES)
        WC      TTCL|Q|
   .DOE.0
:---------------------------------------------------------
: OUTPUT SECTOR (2)
:
:
CONPATCH(PA0PTR,,0C*NLINES+SIOXL)
TTCCW   WS
   .DOB.(Q,0,NLINES)
        WC      TCCW|Q|
   .DOE.0
SSIOX   WS
   .DOB.(Q,0,NLINES)
        WC      RBUF|Q|-TCCW|Q|
   .DOE.0
OSTBL   WS
   .DOB.(Q,0,NLINES)
OSTB|Q| BS      RBUF|Q|-TCCW|Q|
   .DOE.0
OSADR    WS
   .DOB.(Q,0,NLINES)
        WC      OSTB|Q|
   .DOE.0
OSLEN   EQ      OSADR-OSTBL
:
:----------------------------------------------------
:
CONPATCH(PA0PTR,,NLINES)
CCURSE  BS      NLINES
:
:-----------------------------------------------------
: RECEIVE BUFFER (3)
:
PA0PTR  EQ      ((PA0PTR+3)/4)*4
CONPATCH(PA0PTR,,4*NLINES+RBUFHS*2*NLINES)
RRBUF   WS
   .DOB.(Q,0,NLINES)
        WC      RBUF|Q|
   .DOE.0
RCVTBL  WS
   .DOB.(Q,0,NLINES)
RCVT|Q| HS      RBUFHS
   .DOE.0
PA0PTR  EQ      ((PA0PTR+3)/4)*4
CONPATCH(PA0PTR,,4*NLINES)
RCVADR  WS
   .DOB.(Q,0,NLINES)
        WC      RCVT|Q|
   .DOE.0
:
:---------------------------------------------------------
:
CONPATCH(PA0PTR,,NLINES*2)
RRINDE  HS      NLINES
:
:**********************************************************************
: PART 2 --- SAVE TABLES LOGIC
:
: TO JUMP TO THIS ROUTINE, R10 SHOULD HAVE THE RETURN ASDDRESS, R8 CONTAINS
: LINK NUMBER, R7 SHOULD CONTAIN CASE NUMBER OR TRAP TYPE.
: SAV1 THRU SAV10 CAN BE USED BEFORE JUMP TO THIS TRCSAV ROUTINE.
:
:***********************************************************************
:
 
CONPATCH(PA1PTR,,1F4)
TRCSAV  STM     R0,SAVREG,,
:
        CLHI    R8,NLINES
        JG      TRCRTN          :INVALID LINK NUMBER,SKIP TRCSAV ROUTINE
        LR      R6,R8
        SLLS    R6,2            :MAKE OFFSET TO THE TABLES FOR THIS LINK
        L       R9,TABLES,R6,   :GET THE CORRESPONDING REGISTERS TABLE ADDRES
:
: SAVE TRAP REGISTERS
:
        LIS     R5,0
REGCPY  L       R0,SAVREG,R5,   :GET BACK THE REGISTERS
        ST      R0,,R9,R5       :STORE TO THE CORRESPONDING REGISTERS
        AIS     R5,4
        CLHI    R5,40           :END?
        JL      REGCPY
:
: HERE IS TO RESTORE THE ORIGINAL CONTENTS OF REGISTER 7,8,10
:
        L       R0,SAV1,,
        ST      R0,1C,R9,       :RESTORE BACK REGISTER 7
        L       R0,SAV2,,
        ST      R0,20,R9,       :RESTORE BACK REGISTER 8
        L       R0,SAV3,,
        ST      R0,28,R9,       :RESTORE BACK REGISTER 10
:
: SAVE DPORT,IPORT,EPORT,ELCI
:
        LHL     R0,DPORT,,
        STH     R0,40,R9,       :SAVE DPORT
        LHL     R0,IPORT,,
        STH     R0,42,R9,       :SAVE IPORT
        LHL     R0,EPORT,,
        STH     R0,44,R9,       :SAVE EPORT
        LHL     R0,ELCI,,
        STH     R0,46,R9,       :SAVE ELCI
:
: SAVE DI.MT,ID.MT,IE.MT,EI.MT,IL.MT
:
        LIS     R5,0
MTCPY   LHL     R0,DI.MT,R5,    :POINT TO DI.MT, COPY ALL THE MAPPING TABLES
        STH     R0,48,R9,R5
        AIS     R5,2
        CLHI    R5,2*NDPORT+2*NEPORT+5*NIPORT
        JL      MTCPY
:
        LR      R5,R8
        SLLS    R5,2
:
:
: SAVE PACKET TRACE TABLE
:  
:
PSAVE   L       R6,PTRADR,R5,   :WHERE TO SAVE FOR THIS LINK
        LIS     R9,0
PSAV1   LB      R0,PTRTBL,R9,   :FETCH A BYTE
        STB     R0,10,R6,R9     :START TO SAVE AT 10TH BYTE OF SAVING AREA
        AIS     R9,1
        CLHI    R9,PTRLEN+10    :END OF TABLE?
        JL      PSAV1
        ST      R7,,R6,         :SAVE THE CASE/TRAP TYPE
        LHI     R0,PTRLEN
        STH     R0,4,R6,        :SAVE THE PT TRACE TABLE LENGTH
        LHL     R0,PTRINP,,
        STH     R0,6,R6,        :SAVE THE TRACE POINTER VALUE
:
: SAVE FRAME TRACE, RETURN ADDRESS IS IN R8, CASE NUMBER IS IN R7
:
FSAVE   L       R6,FTRADR,R5,   :WHERE TO SAVE
        LIS     R9,0
FSAV1   LB      R0,FTRTBL,R9,   :GET A BYTE FROM FT TABLE
        STB     R0,10,R6,R9     :START TO SAVE AT THE 10TH BYTES
        AIS     R9,1
        CLHI    R9,FTRLEN+10    :END OF TABLE?
        JL      FSAV1
        ST      R7,,R6,         :SAVE CASE/TRAP TYPE
        LHI     R0,FTRLEN
        STH     R0,4,R6,        :SAVE THE FT LENGTH
        LHL     R0,FTRINP,,
        STH     R0,6,R6,        :SAVE THE TRACE POINTER VALUE
        LH      R0,0E,R6,       :GET PREVIOUS OCCURENCE COUNTER
        AIS     R0,1
        STH     R0,0E,R6,       :INCREMENTED BY ONE
:
: IRING AND ORING SAVING ROUTINE
:
IOSAVE  L       R6,ORADR,R5,    :WHERE TO SAVE
        LIS     R9,0
IOSAV1  LB      R0,ORING,R9,    :GET A BYTE
        STB     R0,,R6,R9       :SAVE THIS BYTE
        AIS     R9,1
        CLHI    R9,ORSIZE+4     :END OF TABLE?
        JL      IOSAV1
:
:
        L       R6,IRADR,R5,    :WHERE TO SAVE IRING
        LIS     R9,0
IOSAV2  LB      R0,IRING,R9,    :GET A BYTE
        STB     R0,,R6,R9       :SAVE IT
        AIS     R9,1
        CLHI    R9,IRSIZE+4     :END OF TABLE
        JL      IOSAV2
:
:
: HERE IS TO SAVE THE AREAS FROM TCCLK TO TCCWK FOR EACH LINK K
:
ROTSAV  L       R7,TCCLL,R5,    :ADDR OF ROTOR LIST OF THIS LINK
        L       R8,TCCLEN,R5,   :LENGTH OF ROTOR LIST
        L       R6,TCLADR,R5,   :WHERE TO SAVE
ROTSV1  LIS     R9,0
ROTSV2  LB      R0,,R7,R9
        STB     R0,,R6,R9
        AIS     R9,1
        CR      R9,R8           :END OF COPING?
        JL      ROTSV2          :NOT YET, BACK TO LOOP
:
:
:
: SAVE OUTPUT SECTOR INTO OSTBK FOR LINK K WITH THE LENGTH SIOXK-TCCWK.
:
OSSAV   L       R7,TTCCW,R5,    :ADDR OF OUTPUT SECTOR OF THIS LINK
        L       R8,SSIOX,R5,    :LENGTH OF THE O.SECTOR OF THIS LINK.
        L       R6,OSADR,R5,     :WHERE TO COPY
OSSAV1  LIS     R9,0
OSSAV2  LB      R0,,R7,R9
        STB     R0,,R6,R9
        AIS     R9,1
        CR      R9,R8
        JL      OSSAV2
:
:
: SAVE CURSEC TO CCURSE
:
CURSAV  LB      R0,CURSEC,R8,  :SAVE THE OUTPUT SECTOR POINTER
        STB     R0,CCURSE,R8,
:
:
: SAVE RECEIVE BUFFER INTO TCVTK FOR LINK K WITH THE LENGTH RBUFHS*2
:
:
PBSAV   L       R7,RRBUF,R5,    :ADDR OF RECEIVE BUFFER OF THIS LINK
        LHI     R8,RBUFHS*2     :LENGTH OF THE RECEIVE BUFFER OF THIS LINK
        L       R6,RCVADR,R5,    :WHERE TO COPY
PBSAV1  LIS     R9,0
PBSAV2  LB      R0,,R7,R9
        STB     R0,,R6,R9
        AIS     R9,1
        CR      R9,R8
        JL      PBSAV2
:
:
: SAVE RINDEX TO RRINDE
:
RINSAV  LHL     R0,RINDEX,R8,R8   :SAVE RECEIVE BUFFER POINTER VALUE
        STH     R0,RRINDE,R8,R8
:
: RETURN TO THE CALLER
:
TRCRTN  LM      R0,SAVREG,,
        JR      R10
ENDPATCH(SAVE IRING ORING PT FT TRACES)
:
:
:****************************************************************
:
: PART 3. DISPALY MESSAGE 'TRAP WAS CAUGHT ON LINK ??' BY
:         DDT 'HELP' COMMAND.
:         TO REMOVE THIS DDT MESSAGE, NEED TO ZERO OUT THE FIRST 4 BYTES
:         AT FFTRTB.
:
:*************************************************************************
:
:
: XCOM VERSION 4.03
:
:
:
: TASK: DDT 'HELP' COMMAND WILL DISPALY LINK TRAPPED
:       MESSAGES IF SOME LINK IS TRAPPED.
 
   IF   DDTDIA
PA0PTR  EQ      ((PA0PTR+3)/4)*4
PATCH(871022,1900,JWANG,PA0PTR,,50)
MSG     BC      27
        AC      /"0D"0A*** TRAP /
        AC      / WAS CAUGHT ON LINK /
TRCLNK  HC      0
        AC      / ***/
        HC      0D0A
LNKNUM  AC      /"30"30"30"31"30"32"30"33"30"34"30"35"30"36"30"37"30"38"30"39/
        AC      /"31"30"31"31"31"32"31"33"31"34"31"35"31"36"31"37"31"38"31"39/
CONPATCH(DDMMY1-0A,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,3A)
        SVC     R11,M.15,,
        LIS     R8,0
DDTLP   L       R6,FTRADR,R8,R8 :GET ADDRESS OF FRAME TRACE SAVE AREA
        L       R0,,R6,         :THE FIRST 4 BYTES ARE EMPTY?
        JE      DDTLP1          :EMPTY, THEN NO NEED TO OUTPUT MESSAGE
        LH      R9,LNKNUM,R8,
        STH     R9,TRCLNK,,      :SAVE LINK NUMBER
        SVC     0B,MSG,,
DDTLP1  AIS     R8,2
        CLHI    R8,NLINES*2
        JL      DDTLP
        J       DDMMY1-04,,
ENDPATCH(DDT HELP COMMAND WILL DISPLAY TRAP MESSAGE IF ANY LINK IS TRAPPED)
   EI
 