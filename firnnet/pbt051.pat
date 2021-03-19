: **********************************************************************
: *                                                                    *
: *  File     : PBT051.PAT                                             *
: *  Customer : FIRN                                                   *
: *  Comments : Original file - TSAVE8.PAT                             *
: *           : Use in all FIRN PBT 5.05 code                          *
: *                                                                    *
: **********************************************************************

:  filename: TSAVE8.PAT      date: July 30, 1986
:  by: D/TAI
:   This patch replaces SAVE8.PAT which is used for PBT 5.03 to
:   not report the average polling time to the SUP LOG
:   PBT 5.05 does not have CPTO routine anymore, the routines
:   called in IZSET also have different offsets.
:

PATCH(073086,2015,D/TAI,IZSECT+2E,,4)
        J       IZSECT+32
ENDPATCH(PBT051.PAT - SUPRESS SUP LOG FOR AVG POLLING TIME / PBT 5.05)
