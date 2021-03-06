:***************************************************************
: Patchname: hsdxi.tst                SDLC 2.04
:   Author:  James Wang                STS
: Customer: Frank Russel
: Task:     XID was retransmited by host to HIF so quickly that
:           all the responses XID from TIF were discarded by HIF.
:           Due to no XID response sent back to Host, Host did not
:           start to poll via 'SNRM' frame.
:           This patch will keep all the responses and sed them to Host.
:************************************************************************

  IF  (\(SHDPTS))!(\(SHDMPS))
PATCH(891221,1000,JWANG,HSDXI0,,4)
        NOP     0,0,0
ENDPATCH(FIX THE PROBLEM THAT XID RESPONSE FROM TIF WAS DISCARDED BY HIF)
   EI
  