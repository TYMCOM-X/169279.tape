:***********************************************************************
:       <<<<< This patch apply to Consat version 6.03 >>>>>
:

        LO      OUTDIAL
        LO      DATA
        LO      PVC

      REMARK  %%     Patch to check Tel No. according to Japanese conversion %%

:====================================================================
:       (1) 001xxxx...x (International)   ...   only OKINTER defined
:       (2) 00xxxxx...x (Special purpose) ...   always illegal
:       (3) 0xxxxxx...x (Outside city)    ...   check defined area code
:       (4) 1xx.......x (Special purpose) ...   Always illegal
:       (5) Xxxxxxx...x (Within city)     ...   Always legal

PATCH(880616,1500,T/TSUJI,O.DI01+1C,,6)
        J       PA1PTR,,
   IF   .OKJINT
CONPATCH(PA1PTR,,38)
   ELSE
CONPATCH(PA1PTR,,24)
   EI
        AIS     R9,1            :bump char counter
        JNFS    O.JP01          :first character
        CLHI    RBC,0B1         :first character =1 ?
        JG      O.JP03,,        :first char >= 2
        JE      O.DI15,,        :first char = 1 ... error
                                :first char = 0
        AIS     R9,1            :bump R9 from 0 to 1
O.JP01  CHI     R9,4            :possible area code digits
        JL      O.DI03+6,,      :save area code
        JG      O.DI05,,        :proceed to next char
        L       R5,O.TMP        :get first 3 byte
  IF    .OKJINT                 :international
        CI      R5,0B0B0B1      :'001' ?
        JNFS    O.JP02          :not equal to 001. Goto next check.
        LCS     R5,1            :set -1
        ST      R5,O.TMP        :set area code to -1 (international)
        J       O.DI05,,        :proceed to next char
  EI
O.JP02  CI      R5,0B0B0B9      :Compare '009'
        JG      O.DI03+0A,,     :Save area code, if greater
        J       O.DI15,,        :Error
O.JP03  LIS     R9,4            :Set 4
        J       O.DI05,,        :proceed to next char
CONPATCH(O.DI11,,6)
        J       PA1PTR,,
CONPATCH(PA0PTR,,4)
J.TMP   WS      1               :storage for area code

   IF   .OKJINT
CONPATCH(PA1PTR,,5C)
   ELSE
CONPATCH(PA1PTR,,54)
   EI
        CHI     R9,$A9          :Compare '9'
        JL      O.DI15,,        :error
        L       R5,O.TMP        :get area code
  IF    .OKJINT                 :international
        JE      O.DI19,,        :go dial, if within city
        AIS     R5,1            :
        JE      O.DI19,,        :go dial, if international
  ELSE
        JE      O.DI19,,        :go dial, if within city
  EI
  IF    .OB0                    :list of bad
        LHI     R6,.OBNUM*4+4   :number and displacement (list of bad)
O.JP11  SIS     R6,4            :R6 minus 4
        JL      O.DI19,,        :dial exit if bad list finished
        L       R5,O.TMP        :get area code
        ST      R5,J.TMP        :save area code
        LIS     R5,4            :Set 4
O.JP12  SIS     R5,1            :R5 minus 1
        JEFS    O.JP13          :R5=0 so process to next check
        LB      R9,AREACD,R6,R5 :get 1 byte from area code table
        CHI     R9,0BA          :wild card ?
        JNBS    O.JP12          :repeat if no match
        STB     R9,J.TMP,R5     :save 1 byte to storage area
        JBS     O.JP12          :Back to O.JP12 for check next code
O.JP13  L       R5,J.TMP        :get area code
        C       R5,AREACD,R6,   :compare to area code
        JN      O.JP11          :repeat if no match
        J       O.DI15,,        :error exit if a match
  ELSE
        LHI     R6,.OGNUM*4+4   :number and displacement (list of good)
O.JP11  SIS     R6,4            :R6 minus 1
        JL      O.DI15,,        :error exit if good list finished
        L       R5,O.TMP        :get area code
        ST      R5,J.TMP        :save area code
        LIS     R5,4            :Set 4
O.JP12  SIS     R5,1            :R5 minus 1
        JEFS    O.JP13          :R5=0 so process to next check
        LB      R9,AREACD,R6,R5 :get 1 byte from area code table
        CHI     R9,0BA          :wild card ?
        JNBS    O.JP12          :repeat if no match
        STB     R9,J.TMP,R5     :save 1 byte to storage area
        JBS     O.JP12          :To check repeat, goto O.JP12
O.JP13  L       R5,J.TMP        :get area code
        C       R5,AREACD,R6,   :compare to area code
        JN      O.JP11          :repeat if no match
        J       O.DI19,,        :dial exit if a match
  EI
CONPATCH(ILLARA,,25)
        AC      /Illegal telephone number - ignored"0D"0A"00/


        REMARK %%      Patch for heyes compatible modem (Tymix modem) %%

:================================================
:(1)    Patch to change modem message

CONPATCH(MODMSG,,24)
        WC      33      : CALL FAILED     'NO CARRIER
        WC      32      : INCOMING CALL   'RING
        WC      38      : NO ANSWER TONE  'NO ANSWER
        WC      36      : NO DIAL TONE    'NO DAIAL TONE
        WC      3130    : 2400 BPS        'CONNECT 2400
        WC      35      : 1200 BPS        'CONNECT 1200
        WC      31      :  300 BPS        'CONNECT  300
        WC      37      : BUSY TONE       'BUSY
        WC      0       : ZERO TERMINATER

:================================================
:(2) Patch to support tone sub command

CONPATCH(D.LGC7+6,,4)
        LHI     RBC,0D4         : GET 'T'

:==============================================
:(3)    Patch to change dial command and ignore escape command

CONPATCH(D.LGC8+0A,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,9C)
        LHI     RBC,0C1         : 'A'
        JAL     RCH,PUTCHR,,    : SEND A
        LHI     RBC,0D4         : 'T'
        JAL     RCH,PUTCHR,,    : SEND T
        LHI     RBC,0D3         : 'S'
        JAL     RCH,PUTCHR,,    : SEND S
        LHI     RBC,0B2         : '2'
        JAL     RCH,PUTCHR,,    : SEND 2
        LHI     RBC,0BD         : '='
        JAL     RCH,PUTCHR,,    : SEND =
        LHI     RBC,0B1         : '1'
        JAL     RCH,PUTCHR,,    : SEND 1
        LHI     RBC,0B2         : '2'
        JAL     RCH,PUTCHR,,    : SEND 2
        LHI     RBC,0B7         : '7'
        JAL     RCH,PUTCHR,,    : SEND 7
        LHI     RBC,0D3         : 'S'
        JAL     RCH,PUTCHR,,    : SEND S
        LHI     RBC,0B1         : '1'
        JAL     RCH,PUTCHR,,    : SEND 1
        LHI     RBC,0B2         : '2'
        JAL     RCH,PUTCHR,,    : SEND 2
        LHI     RBC,0BD         : '='
        JAL     RCH,PUTCHR,,    : SEND =
        LHI     RBC,0B2         : '2'
        JAL     RCH,PUTCHR,,    : SEND 2
        LHI     RBC,0B5         : '5'
        JAL     RCH,PUTCHR,,    : SEND 5
        LHI     RBC,0C4         : 'D'
        JAL     RCH,PUTCHR,,    : SEND D
        J       D.LGC8+14,,     : RETURN

:================================================
:(4) Patch to support pause sub command

CONPATCH(D.LG10+6,,4)
        LHI     RBC,0AC         : GET ','

:================================================
:(5)    Patch to change initialize command

CONPATCH(MODIZ+58,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,58)
        LHI     RBC,0C1         : 'A'
        JAL     RCH,PUTCHR,,    : SEND A
        LHI     RBC,0D4         : 'T'
        JAL     RCH,PUTCHR,,    : SEND T
        LHI     RBC,0C5         : 'E'
        JAL     RCH,PUTCHR,,    : SEND E
        LIS     RBC,0D          : CR
        J       MODIZ+6E,,      : JUMP RETURN

:================================================
:(6) Patch to change OK to zero


CONPATCH(MPARS2+6,,4)
        CLHI    R1,030          : COMPARE '0'=OK

:==================================================
:(7)    Patch to make delay for 300 bps setup when transmit command


CONPATCH(XMDEL,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,0E)
        LR      R5,RBC          : Get the value in the right place
        JAL RCH,ADELYG,,        : Send it
        J       XRET,,          : Return


        REMARK %%      Patch fix problem of 'set' command %%

:=================================================
:(1)    Patch Fix problem of 'set' command

CONPATCH(O.SET3+4,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,16)
        TBT     RP,TOTRAN       :Data to outdial command translator
        JE      SNDERR,,        :Current error code goes to terminal
        JAL     R6,OPARSE,,     :Check accepted command matching or not
        J       O.SET,,         :Find what options follow for set command

        REMARK %%       Patch fix problem of 'PVC port hang if OUTDIAL specify' %%

:==============================================================
:(1)    Patch fix problem ' If consat outdial specify at tymfile ,
:       at slot load , or at ddt halt and execute command set ,
:       direct connect PVC port hang up'

CONPATCH(PA0PTR,,4+NGRP*4)
BGREG   WS      1       : Resistor temporary save area
OT.PVC  WS      NGRP    : If this flag set , we must not send 'ATE'

CONPATCH(MODIZ,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,3C)
        GETPTP(RPI,RP,RP)       : Set up RPI-port tbl pntr
        ST      R7,BGREG        : Resistor save
        L       R7,.PVCX,RPI    : Get PVC parameters for this port
        THI     R7,POHNG        : Is this port specify PVC HANG option ?
        JN      MODIZ2          : Yes , then goto MODIZ2
        L       R7,BGREG        : Resistor load
        J       MODIZ+6,,       : Return to source
MODIZ2  L       R7,BGREG        : Resistor load
        SBT     RP,OT.PVC       : Set bit OT.PVC flag
        JR      RLINK           : Normal return

CONPATCH(OT.IZ3,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,24)
        TBT     RP,OT.PVC       : Is this port set OT.PVC flag ?
        JN      OT.IZ5          : Yes , then goto OT.IZ5
        RBT     RP,OT.CAP       : From source
        GETPTP(RPI,RP,RP)       :   "     "
        J       OT.IZ3+0A,,     : Return source
OT.IZ5  RBT     RP,OT.CAP,,     : Outdial capable flag reset
        J       OT.IZ2,,

        REMARK  %%      Patch file fix problem for ISCS06.P03 %%
:==================================================
:(1)    Patch fix problem of iscs06.p03

CONPATCH(D.LGC1+4,,6)
	J	PA1PTR,,
CONPATCH(PA1PTR,,26)
	LHL	R0,BUSY.H,R5,		:GET PORTS BUSIED BY "BUSY"
	OH	R0,BUSY.O,R5,		:GET PORTS BUSIED BY "OBUSY"
	OH	R0,RLA,R5,		:NOT ANSWERING INCOMING CALL
					:RLA IS SET WHEN IC! IS RECEIVED
					:OR WHEN THE PORT HAS BEEN ACTIVE
	LHL	R1,OT.CAP,R5,		:GET CAPABLE PORTS
	XR	R1,R0			:GET ONE THAT'S OK TO DIAL
	NH	R1,HDWDSR,R5,		:NOT ANSWERING INCOMING CALL
	J	D.LGC1+14,,

CONPATCH(M.COM+0C,,0A)
        JAL     R15,ZAPMOD              :ZAP MODEM ON INIT
        J       VDEF,,                  :DEFFERED OUTPUT

CONPATCH(O.DCOM,,8)
        WC      00080000
        WC      00008800                :, P T

ENDPATCH(Support for Consat outdial and Tymix modem BBS)

        FO      CONSAT
        FO      OUTDIAL
        FO      DATA
        FO      PVC
    