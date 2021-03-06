PATCH(900629,1500,WARNERD,UTSEXC+4,,2)

        LIS     R10,02                  :INCREASE NO. OF TIMES THORUGH RUN
                                        :LIST LOOP FROM 1 TO 3

        LO      UTSFEX
        IF      NBILIN-1                :IF MORE THAN ONE LINE
CONPATCH(RDMISS,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,16)
        ST      R5,RRUNL,RL2,RL2        :REPLACE INSTRUCT
        SIS     RL,1                    :GO TO NEXT LINE
        SIS     RL2,2
        JGE     RRUN10,,                :FINISH RCV
        J       XRUNOF+6,,              :REALLY PROTOCOL RUN LIST BEGINN

CONPATCH(PDMISS,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,16)
        ST      R5,PRUNL,RL2,RL2        :REPLACE
        SIS     RL,1
        SIS     RL2,2                   :NEXT LINE
        JGE     PRUN10,,                :FINISH PROTOCOL
        J       RRUNOF+6,,              :REALLY TRANSMIT RUN LIST START

CONPATCH(XDMISS,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,16)
        ST      R5,XRUNL,RL2,RL2        :REPLACE
        SIS     RL,1
        SIS     RL2,2                   :NEXT LINE
        JGE     XRUN10                  :FINISH TRANSMIT
        J       PRUNOF+6                :REALLY END OF LIST

        ELSE


CONPATCH(RDMISS,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,0C)
        ST      R5,RRUNL,RL2,RL2        :REPLACE OLD INSTRUCTION
        J       XRUNOF,,                :GO TO PROTOCOL RUN LIST RATHER 
                                        :THAN TRANSMIT RUN LIST FROM
                                        :RECEIVE

CONPATCH(PDMISS,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,0C)
        ST      R5,PRUNL,RL2,RL2        :REPLACE OLD INSTRUCTION
        J       RRUNOF,,                :GO TO TRANSMIT RUN LIST AFTER
                                        :PROTOCOL RUN LIST

CONPATCH(XDMISS,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,0C)
        ST      R5,XRUNL,RL2,RL2        :REPLACE OLD INSTRUCTION
        J       PRUNOF,,                :GO BACK TO F.G.

        EI


        FO      UTSFEX

CONPATCH(EXEC,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,18)
        LIS     R0,1                    :SET UP FOR SVC
        SVC     SYS,0D                  :SVC TO SAVE F.G. RETURN ADDR. TO
                                        :SEE IF FORCE DISMISS DUE TO F.G.
                                        :LOOPS
        ST      R0,PA0PTR,,             :STORE ADDRESS
        LH      R0,BDEBUG,,             :REPLACE OLD INSTRUCTION
        J       EXEC+6,,                :GO BACK

ENDPATCH(Re-arrange run list order, increase f.g. loops)
 