:CTRVT1
:       KEYBOARD FUNCTIONS FOR THE VT100
:
        KILL CTRVT1
CTRVT1  MACRO [
        level1(a.syn,1,statln)          :status line display key (^V)
        level1(a.si,1,nothng)           :reserved for sys/req (^O)
        LEVEL1(A.SUB,1,KILL)            :ZAP CIRCUIT (^Z)
        LEVEL1(A.CR,1,FCNENT)           :CARRIAGE RETURN = ENTER(^M)
        LEVEL1(A.SO,1,NEWLIN)           :NEWLINE (^N)
        LEVEL1(A.LFED,1,FCNCLR)         :CURSOR DOWN (^J)
        LEVEL1(A.ETX,1,FCNCLR)		:CLEAR (^C)
        LEVEL1(A.EOT,1,DELCHA)		:DELETE CHARACTER (^D)
        LEVEL1(A.DC2,1,RESET)		:RESET/LEAVE INSERT MODE(^R)
        LEVEL1(A.DEL,1,DELCHA)          :LET DELETE BE A DELETE
        LEVEL1(A.DC4,1,FLDTAB)          :TAB CHARACTER (^T)
        LEVEL1(A.HT,1,FLDTAB)           :TAB CHARACTER (^I)
        LEVEL1(A.STX,1,BACKTA)          :BACKTAB CHARACTER (^B)
        LEVEL1(A.BS,1,BACKTA)           :BACKTAB CHARACTER (^H)
        level1(a.can,1,CURSEL)          :cursor select (^X)
	LEVEL1(A.ENQ,1,EEOF)		:ERASE TO END OF FIELD (^E)
        LEVEL1(A.ESC,0)			:   <ESCAPE>
        level1(a.soh,1,CURUP)           : ^A - Cursor up
        level1(a.bel,1,CURDON)          : ^G - Cursor down
        level1(a.em,1,CURRT)            : ^Y - Cursor right
        level1(a.FF,1,CURLEF)           : ^L - Cursor left  
         LEVEL2(A.R,1,REDSPY)          :REDISPLAY
          LEVEL2(A.LR,1,REDSPY)
          LEVEL2(A.H,1,HOME)		:HOME CURSOR (1ST UNPROTECTED FIELD)
	  LEVEL2(A.LH,1,HOME)		:HOME CURSOR (1ST UNPROTECTED FIELD)
          LEVEL2(A.I,1,INSMOD)          :INSERT MODE
          LEVEL2(A.LI,1,INSMOD)         :INSERT MODE
	  LEVEL2(A.X,0)			:<F I L E      T R A N S F E R>
	    LEVEL3(A.B,1,BEGXFR)	:ESC-X-B  STOPS    NETWORK ECHO
	    LEVEL3(A.E,1,ENDXFR)	:ESC-X-E  RESTARTS NETWORK ECHO
          LEVEL2(A.1,1,FCNF1)           :PF-1
          LEVEL2(A.2,1,FCNF2)           :PF-2
          LEVEL2(A.3,1,FCNF3)           :PF-3
          LEVEL2(A.4,1,FCNF4)           :PF-4
          LEVEL2(A.5,1,FCNF5)           :PF-5
          LEVEL2(A.6,1,FCNF6)           :PF-6
          LEVEL2(A.7,1,FCNF7)           :PF-7
          LEVEL2(A.8,1,FCNF8)           :PF-8
          LEVEL2(A.9,1,FCNF9)           :PF-9
          LEVEL2(A.0,1,FCNF10)		:PF-10
          LEVEL2(A.EXCL,1,FCNF11)
          LEVEL2(A.AT,1,FCNF12)
          LEVEL2(A.PND,1,FCNF13)
          LEVEL2(A.DOL,1,FCNF14)
          LEVEL2(A.PCT,1,FCNF15)
          LEVEL2(A.CART,1,FCNF16)
          LEVEL2(A.AND,1,FCNF17)
          LEVEL2(A.STAR,1,FCNF18)
          LEVEL2(A.LPAR,1,FCNF19)
          LEVEL2(A.RPAR,1,FCNF20)
          LEVEL2(A.O,0)
            LEVEL3(A.P,1,FCNF1)
            LEVEL3(A.Q,1,FCNF2)
            LEVEL3(A.R,1,FCNF3)
            LEVEL3(A.S,1,FCNF4)
          LEVEL2(A.LBKT,0)
            LEVEL3(A.D,1,CURLEF)          :CURSOR LEFT
            LEVEL3(A.B,1,CURDON)          :CURSOR DOWN
            LEVEL3(A.C,1,CURRT)           :CURSOR RIGHT
            LEVEL3(A.A,1,CURUP)           :CURSOR UP
        LEVEL1(A.ACK,0)                 :   CONTROL F
          LEVEL2(A.1,1,FCNF21)
          LEVEL2(A.2,1,FCNF22)
          LEVEL2(A.3,1,FCNF23)
          LEVEL2(A.4,1,FCNF24)
        LEVEL1(A.DLE,0)                 :   CONTROL P
          LEVEL2(A.1,1,FCNPA1)
          LEVEL2(A.2,1,FCNPA2)
          LEVEL2(A.3,1,FCNPA3)
]
: 
