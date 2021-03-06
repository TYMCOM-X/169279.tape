:---------------------------------------------------------------
:
: INTERFACE : CMTI
: VERSION   : 11.01
:
:       To display cursor on correct position
:
:       1. If CMT receices INSERT CURSOR command from HOST, and the position
:          for the INSERT CURSOR command is a 1st position of KANJI character
:          or position of KANJI SHIFT IN/OUT, then CMT position the cursor 
:          on one column left to the position which is indicated by 
:          the HOST COMPUTER.
:        
:       2. To avoid this, use the cursor position which is indicated
:          by host for actual cursor display, if the position is 1st position
:         of  KANJI character. Also, move the cursor position one culumn right
:          to the position which is indicated by host, if the position indicated
:          by host is KANJI SHIFT IN/OUT.
:
:
:-------------------------------------------------------------------
:
        LO      OPTIM
PATCH(900416,1700,NIS.KOBAYASHI,OPKANCHK,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,054)
        PUSH(R0)                        :FROM SOURCE
        TBT     R7,KANMAP,R8            :ON 1ST HALF OF A KANJI?
        JN      OPKN30,,                :YES, BACK SOURCE
        CHI     R7,0
        JE      OPKN30,,
        SIS     R7,1                    :BACKUP 1 BYTE
        TBT     R7,KANMAP,R8            :ON 1ST HALF OF A KANJI?
        JN      OPKN30,,                :YES, BACK SOURCE
        AIS     R7,1                    
        LHL     R0,THOST,R11            :GET HOST TYPE
        CHI     R0,IBM                  :IS IT IBM?
        JN      OPKN30,,                :NO, BACK SOURCE
        LB      R0,SCN,R8,R7            :GET CURRENT CHARACTER
        CHI     R0,IKSI                 :IS IT KSI?
        JEFS    OPKN40                  :YES, GO COUNTUP 1 BYTE IN SCREEN BUFFER
        CHI     R0,IKSO                 : IS IT KSO?
        JN      OPKN30,,                :NO BACK SOURCE
OPKN40  AIS     R7,1                    :GO COUNTUP 1 BYTE IN SCREEN BUFFER
        J       OPKN30,,                :BACK SOURCE
ENDPATCH(FIXING BUG OF CURSOR IS SITTING ON A POSITION)
        FO      OPTIM
  