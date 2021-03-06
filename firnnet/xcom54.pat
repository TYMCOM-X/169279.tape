: **********************************************************************
: *                                                                    *
: *  File     : XCOM54.PAT                                             *
: *  Customer : FIRN                                                   *
: *  Comments : Original file - NOTIIX.PAT                             *
: *           : Use in all FIRN XCOM 3.01 code                         *
: *                                                                    *
: **********************************************************************
:
: XCOM 3.01
: ESC 57429, REPORTED BY COMPUSERVE
:
: PROBLEM: AFTER IIX DIALECT EXCHANGE AND AND START TO XFER DATA
:          VIA IIX, XCOM RECEIVES NONIIX (PURE ISIS) DATA.
:          XCOM WILL JUMP TO ESCMSG,ESC012, ESP14, ESD120.
:          AT ESD120+8, THE INSTRUCTION SHOULD BE 'JG MCRAS1'
:          INSTEAD OF 'JG MCRASH'. OTHERWISE, THE ELIR WILL
:          SET THE IRING POINTER TO THE WRONG LOCATION.
PATCH(870820,1400,JWANG,ESD120+8,,4)
        JG      MCRAS1
ENDPATCH(XCOM054.PAT - FIX EF CRASH FOR NONIIX DATA AFTER IIX DIALECT EXCHANGE)
  