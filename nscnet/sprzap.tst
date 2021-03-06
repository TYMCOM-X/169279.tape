:---------------------------------------------------------------------
: Patch name:  SPRZAP                Product and Version:  BBXS 7.01
:     Author:  PHIL SNEDDON                 Organization:  STS
:   Customer:  NIS                          Date Written:  JUNE 27 1990
: Description of Problem:  ESC #308256  Pseudo Needle arrives as login 
: timer expires.  The slot discards the PSN but doesn't zap the port.
: ISIS then sends a SHG to hang the port but ISIS doesn't zap it either
: so the port stays hung.  This patch returns a zap when any data or
: control message is received on an unassigned port.
:---------------------------------------------------------------------

PATCH(900627,1401,STIG,IDT125+6,,4)
         J     IDT150+4               :RETURN ZAP ON UNASSIGNED PORT
ENDPATCH(send ZAP when data or control message received on unassigned port)
  