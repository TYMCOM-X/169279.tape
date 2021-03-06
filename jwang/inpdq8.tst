:************************************************************
: Patchname: inpdq8.tst           (sdlc 2.04)
:   Author : JAmes Wang           (STS)
:    Date  : APr 10, 1990
:  Customer: NIS
: Problem: XIQ message was cut into two messages in the network. 
:          The sdlc interface does not handle well for the second part
:          of ISIS message --> part of the 2nd message is treated
:          as next new isis message and causes an illegal dispatcher
:          port crash.
:*********************************************************************

PATCH(900410,1000,JWANG,INPDQ8+0C,,6)
        LIS     R8,0
        NOP     0,0,0
ENDPATCH(FIX THE BUG IN INPDQ8 WHICH PROCESS THE SPLITTED xid MESSAGES).
  