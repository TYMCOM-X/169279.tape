:******************************************************************
: PATCHNAME: BPSHUT.204 (BPSHUT.TST)          PRODUCT VERSION: SDLC 2.04
:   AUTHOR : JAMES WANG                          ORGANIZATION: STS
:  CUSTOMER: EPA                                 DATE WRITTEN: JUNE 15, 1989
: PROBLEM:
:   IRLST ROUTINE SENDS 'A2' MSG FOR ALL SHUT STATIONS. SLOT CRASHED WHEN
:   THE CODE SENDS 'A2' FOR THE INACTIVE BUT SHUT STATION.
:   PART OF THE PATCH 'PATCH(890313,1900,R/KISHMIRIAN.....' NEEDS TO BE
:   REMOVED FROM SDLC02.P04.
:*****************************************************************************

  lo gbldef
  lo trace
  lo ring
  lo crash
  lo timout
  lo bid
  lo bbufer
  lo convrt
  lo datime
  lo ctldef
  lo frntnd
  lo sdlcdf
  lo siodef
  lo sdlcfx
  lo sfgrcv
  lo sfgxmt
  lo cmdlst
  lo main
  lo sfgptp
  lo stctlm
  lo bufrtn
  lo input
  lo output
  lo dcbrtn
  lo misc
  lo tabini
  lo monitr
  lo status
  lo bgtest

PATCH(890615,1500,JWANG,ILRST3+0C,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,12)
        LHL     RDCB,LSDTAB+LSDDCB,R11,         :GET DCB
        JE      ILRST2,,                        :DCB NOT ASSIGNED, SKIP
        J       ILRST3+12,,
ENDPATCH(DO NOT SEND A2 MSG IF THAT STATION IS SHUT BUT NOT ACTIVE)
 