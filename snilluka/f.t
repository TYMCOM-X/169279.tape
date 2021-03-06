: CUSTOMER:  FORD PARTS AND SERVICE DIV.
: NODE:    3735
: KERNEL:  3559
: SLOT:  6
: HOST:  3927
: TECH SUPPORT: JOE BEDOUN  313/855-0790
:-------------------------------------------------------------------------
: THIS MENU SERVICES THE FORD TEST ENVIRONMENT (IMS TEST REGION).
: THE HOST, 3927, TESTS THE PRE-BUILT HOST-SIDE CIRCUITS FEATURE,
: WITH TTY EMULATION.
:-------------------------------------------------------------------------------

   SUBTTL FORD TYMFILE

:............................-----FOR SLOT

CRASH.STOP(YES)
TIMEZONE(-5)
BIGGERUBUFFER(164)
USER.PORTS(32)
TO.VALUE(60)
PROJ.CODE

:............................-----FOR THE FIRST HOST

HOST.NUMBER(3927)
:PORT.QUOTA(4)
PRE.BUILD
H.AGE(15*60,30*60)
H.CIRC(2,4,1)
H.CCT(12)
H.TPC(2)
:H.UEND(BREAK)
:H.UEND(HOST,#ZAP"0D"0A"80)
:H.UEND(USER,BYE"8D)
AUTO.SELECT
AUTO.LOGOFF

CHZAPPEDTXT
   ZAP.STRING("8D"8A    ZAPPED  "BAHOST 3927 "8A"8D"8A)

LOGOFF
   L.STRING("8D"8A    THANK YOU FOR USING TYMNET....GOODBYE   "BAHOST3927"8D"8A"8A)

COMMAND(1)
   C.LVL	:Network login - host-side
      C.STRING(MORSTEST"BBTEST ME"8D)  :COMPLETES THE CMT LOGON STRING
   C.LVL	:Build host-side circuit to the front-end
:      C.SEEINCLUDINGTHEN("0D"0A"80)
      C.TOSINCLUDINGTHEN("0D"0A"80)
      C.TOSINCLUDINGTHEN("33"0D"0A"80)
      C.STRING(/TEST MFS"8D)
      C.TOSINCLUDINGTHEN(COMPLETED"0D"0A"80)
   C.LVL	:Connect consat user to host-side circuit
      C.STRING(/FOR FPSDTTY"8D)
      C.TOSINCLUDINGTHEN(/FOR FPSDTTY)
   C.LVL	:Use session until end detected
:      C.SEEUPTOTHEN(#ZAP"0D"0A"80)
      C.SEEINCLUDINGTHEN(#ZAP"0D"0A"80)
   C.LVL	:Disconnect consat user from host-side citcuit
:      C.STRING(BYE"8D)
:      C.SEEUPTOTHEN(#ZAP"0D"0A"80)
      C.STRING("03)
      C.TOSINCLUDINGTHEN(CLEARED"0D"0A"80)
      C.TOSINCLUDINGTHEN("0D"0A"80)
  