
:************************************************************
: Patchname: HSOP1.TST            Product version: SDLC 2.04
:   AUthor : James Wang
:      Date: Nov 9, 1989
:    Task:
:         Customer is VA. The files are VA3000.D04
:            The first two stations of line 0 were not active.
:            But the forground (protocol) still queues up the 
:            incoming SNRM in the command link list. The slot
:            crashed due to the empty command link list. 
:            (Because the command link list was filled with
:            SNRMs which were not be sent to network due to
:            inactive station--circuit did not exist in the network)
:
:        This patch will discard all incoming SNRM frames in NDM mode
:        when the network circuit does not exist.
:******************************************************************


    IF  (\(SHDPTS))!(\(SHDMPS))
PA0PTR  EQ      ((PA0PTR+3)/4)*4
PATCH(890919,1500,JWANG,PA0PTR,,8)
SAVE1  WC      0
SAVE5  WC      0
CONPATCH(HSOP1,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,4A)
        ST      R1,SAVE1,,
        ST      R5,SAVE5,,
        LB      R5,SCBLKS+SCBREL,RSCB,
        LHL     R1,LSDPTR,RL2,
HSOPLP  SIS     R5,1
        JL      HSOP
        AHI     R1,LSDLEN
        J       HSOPLP
HSOP    LHL     R5,LSDTAB+LSDDCB,R1,
        JE      HSNDM4,,        :DISCARD INCOMING FRAMES
        L       R1,SAVE1,,
        L       R5,SAVE5,,
        ST      R3,R3SAVE,,
        J       HSOP1+6,,
ENDPATCH(discard snrm for non-active stations)
  EI 
