: **********************************************************************
: *                                                                    *
: *  File     : XCOM51.PAT                                             *
: *  Customer : FIRN                                                   *
: *  Comments : Original file -                                        *
: *           : Use in all FIRN XCOM 3.01 code                         *
: *                                                                    *
: **********************************************************************

PATCH(850913,1600,JL,CHKS10+2,,6)
         J         TORET,,
CONPATCH(T1S520+8,,4)
         J         T1S510
ENDPATCH(XCOM51.PAT - AVOID SENDING SABM FRAMES DURING INFO XFER)
 