PATCH(900629,1500,WARNERD,UTSEXC+4,,2)

        LIS     R10,02                  :INCREASE NO. OF TIMES THORUGH RUN
                                        :LIST LOOP FROM 1 TO 3

        LO      UTSFEX




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
