S0      EQ      ((S0SIZE+0FF)/100)*100
S1      EQ      ((S1SIZE+0FF)/100)*100
S2      EQ      S2SIZE/10000*10000
S3      EQ      ((S2SIZE+0FF)/100)*100-S3SIZE
SE      EQ      ((SESIZE+0FF)/100)*100
STOT    EQ      S0+S1+S2+S3+SE
DISC    EQ      (STOT+2FFF)/3000

        REMARK %%ELF SEGMENT ALLOCATION FOR USE WITH
        REMARK %SUPERVISORS USING THE 'LOA' FILE%
        REMARK %SEGMENT(0,
        NUMBER $0 S0
        REMARK )
        REMARK %SEGMENT(1,
        NUMBER $0 S1
        REMARK )
        REMARK %SEGMENT(2,
        NUMBER $0 S2
        REMARK )
        REMARK %SEGMENT(3,
        NUMBER $0 S3
        REMARK )
        REMARK %SEGMENT(0E,
        NUMBER $0 SE
        REMARK )%
        REMARK %%TOTAL SEGMENT SIZE:  
        NUMBER $0 STOT %
        REMARK %%MINIMUM NUMBER OF DISC CYLINDERS REQUIRED TO SAVE:  
        NUMBER $0 DISC %
        REMARK %%
