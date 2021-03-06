:---------------------------------------------------------------------
: Patch name:  DONTZ0                Product and Version:  CMH 1.07
:     Author:  PHIL SNEDDON                 Organization:  QSATS/STS
:   Customer:  UKNET                        Date Written:  07/19/89
: Description of Problem:  ESC# 235091   1) USE CORRECT HOST NUMBER IN P-N-R.
: 2) DON'T SEND ZAP ON PORT ZERO IF PSEUDONEEDLE REJECT RECEIVED
:---------------------------------------------------------------------

         LO ISISC
PATCH(890719,1357,P/SNEDDON,SNDM07,,4)
         LHI   R0,HOST0               :USE CMH HOST AS ORIGINATION HOST NUMBER
CONPATCH(DSCPRT+0CC,,6)
         J     DSCPR3,,
CONPATCH(PA1PTR,,1A)
DSCPR3   LR    R2,R2                  :REAL PORT OR PORT ZERO?
         JE    DSCPRT+0DE,,           :ZERO SO DON'T SEND DETACH
         RBT   R2,ACP,,               :RESTORE ORIGINAL INSTRUCTION
         LA    R3,DETACH,,            :RESTORE ORIGINAL INSTRUCTION
         J     DSCPRT+0D4,,
ENDPATCH(use correct origin host and don't zap port zero)
    