::      XCOM Version 4.03
::
::      (1) Call Request Packet : Replace calling address by 440821000010
::
::      (2) Call Accept Packet  : Replace called address by 440821000010
::      
::      (3) Calledmaping function :
::          a) If called address of call request packet have sub address,
::             4406200008XX convention is used.
::          b) If sub address is not given,
::             only 4406 is submit and enable TKSUP option.
::
::

        PATCH(881215,1300,NIS.TSUJI,PA0PTR,,0C)
        WS      0                       :Word boundary
NISADR  XC      0C440821000010          :Length & Address
        WS      0                       :
NIS4406 XC      044406                  :Length & DNIC of NIS
        WS      0                       :

        CONPATCH(CRQ300-42,,6)
        J       PA1PTR,,
        CONPATCH(PA1PTR,,14)
        JAL     R9,VENCLG,,             :Put address
        LB      R0,PFXCLL,              :Get calling address length
        LB      R8,PFXCLD,              :Get called address length
        J       CRQ300-3A,,             :return

        CONPATCH(ESP912-48,,6)
        J       PA1PTR,,
        CONPATCH(PA1PTR,,14)
        JAL     R9,VENCLG,,             :Put address
        LB      R0,PFXCLL,              :Get calling address length
        LB      R8,PFXCLD,              :Get called address length
        J       ESP912-40,,             :return

        CONPATCH(MCA020-1A,,6)
        J       PA1PTR,,
        CONPATCH(PA1PTR,,14)
        JAL     R9,VENCLD,,             :Put address
        LB      R5,PFXCLD,R6,           :Get called address length
        LR      R7,R5                   : From source
        J       MCA020-14,,             :return

        CONPATCH(PA1PTR,,1A)
VENCLG  L       R0,NISADR               :Get NIS's address on Venus-p
        ST      R0,PFXCLL,              :Store into calling address
        LH      R0,NISADR+4             :
        STH     R0,PFXCLL+4,            :
        LB      R0,NISADR+6             :
        STB     R0,PFXCLL+6,            :
        JR      R9                      :

        CONPATCH(PA1PTR,,1A)
VENCLD  L       R5,NISADR               :Get NIS's address on Venus-p
        ST      R5,PFXCLD,              :Store into called address
        LH      R5,NISADR+4             :
        STH     R5,PFXCLD+4,            :
        LB      R5,NISADR+6             :
        STB     R5,PFXCLD+6,            :
        JR      R9                      :

        CONPATCH(FND2ND+1A,,6)
        J       PA1PTR,,
        CONPATCH(PA1PTR,,28)
        LB      R4,REMBUF               :Get length of remaining digits buffer
        JEFS    NOSUBA                  :Skip if no digits remains
        AR      R4,R6                   :Add two length up
        J       FND2ND+20,,             :Return back
NOSUBA  LH      R0,NIS4406              :Get NIS's DNIC number
        STH     R0,DTESAX,R7,           :Store it
        LB      R0,NIS4406+2            :
        STB     R0,DTESAX+2,R7,         :
        J       CLDEXI,,                :

        ENDPATCH(Replace calling/called address by NIS's address on Venus-P)



