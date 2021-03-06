
:************************************************************************
:       Patch to send TID message on SIO ports.
:       AID option should not be set for SIO ports requiring 'please
:       type...' message.
:       4/3/88  JCR

        IF      NSPORT
        LO      DATA
        LO      CONSAT
PATCH(880403,1730,JREILLY,QHANS5,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,0AE)
XSTIDM  L       RBP,.TTBUF,RPI          : get To-Terminal pointer
        LA      R6,LSMS0,,              : TID message
        JAL     R9,MSG,,                : go send it
        SBT     RP,C.ACP,,              : set port active
        LA      R0,VSIOTI               : get SIO TID receiver
        ST      R0,.VSTAT,RPI           : and store it
VSIOTI  LHL     R9,OCMSOF-2*.SPORT,RP2  : get cmd offset
        LH      R0,OCMSIO,R9            : get cmd/status
        OH      R0,OCMSIO+IO,R9         : get alternate cmd/status
        NHI     R0,200                  : check for completed status
        JEFS    VSIOT1
        JAL     RCH,SIOBSY              : check for possible hung output
        NOP                             : placeholder for error return
VSIOT1  LHL     R9,XINSIO,RP2           : get pointer to current buffer
        LH      RBC,0,R9                : look at first character
        JGE     VSIOT3                  : sio's been here, left a character?
        LR      R8,R9                   : nothing here, perhaps in next buffer
        AHI     R9,SIBFSZ
        NHI     R9,-SIBFSZ              : wrap to next buffer?
        THI     R9,(NSIOBF-1)*SIBFSZ    : if on, not yet time to wrap
        JNFS    VSIOT2                  : to first buffer for this port
        SHI     R9,NSIOBF*SIBFSZ        : time to wrap
VSIOT2  LH      RBC,0,R9                : anything in next buffer?
        JL      VDEF                    : no, try next foreground time
        LH      R0,0,R8                 : yes, check origional pointer
        JLFS    VSIOT3                  : still nothing, use current RBC
        LR      R9,R8                   : yes, use origional pointer
        LR      RBC,R0                  : and get correct character in RBC
VSIOT3  TS      0,R9                    : reset cell to -1
         IF     SHIST;  JAL     R0,SHISTY       : trace;        EI
        AIS     R9,2                    : bump pointer to next character
        STH     R9,XINSIO,RP2           : and store index
        RBT     RP,D.PAS2               : cancel any break in progress
        RBT     RP,D.PAS1
        STB     RBC,CHRSIO              : save the data character
        LHI     R5,7F                   : mask
        NR      R5,RBC                  : low-order 7 bits
        CLHI    R5,0D                   : cr?
        JE      XSTIDM                  : yes, resend 'please type...'
        NHI     R5,1F                   : mask it some more (like async)
        CLHI    R5,1                    : A?
        JN      VSIOT2                  : no, check next character
        LA      R0,VSIO,,               : yes, get normal receive filter
        ST      R0,.VSTAT,RPI           : restore it
        LHI     R4,TID.S                : set as SIO-type terminal
        J       QHANS5+8,,              : and continue...
ENDPATCH(Patch to send TID message on SIO ports.)
        FO      CONSAT
        FO      DATA
        EI      :NSPORT

:************************************************************************

    