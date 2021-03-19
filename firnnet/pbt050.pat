: **********************************************************************
: *                                                                    *
: *  File     : PBT050.PAT                                             *
: *  Customer : FIRN                                                   *
: *  Comments : Original file - TELEX.PAT                              *
: *           : Use in all FIRN PBT 5.05 code                          *
: *                                                                    *
: **********************************************************************

:When PBT receives CLR key in NSS screen, he will send a screen buffer
:to Controller to refresh the screen, which is  stored in SAVEQ.
:This screen data will be around 1920 bytes, since PBT uses RD BUFFER
:command to retrieve the screen back when user issues request of NSS
:screen. During the XMT of this 1920 bytes of data, PBT should insert
:SYNC every second to keep synchronization, but PBT does not.
:Real 3274 CU can tolerate this, but not 3270 compatible devices.
:This patch will insert 2 SYNCs every 640 data bytes. To XMT 640 bytes
:on 4800 baud line needs approximately 1 second.
:
PATCH(022386,1130,D/TSAO,RDN82+12,,4)
          J    PA1PTR
CONPATCH(PA0PTR,,1)
ADDCNT    HS   1
CONPATCH(PA1PTR,,5A)
          STH  2,RDNSR2            :from source
          STH  3,RDNSR3            :from SOURCE
          LHL  6,ADDCNT,,          :
          AHI  6,1
          STH  6,ADDCNT,,          :
          CHI  6,280               :is 640d bytes ?
          JE   ADDSYN              :yes, go ADD SYNC
          J    RDN82+1A            :return to source
ADDSYN    LHI  R0,4C               :store reversed SYNC
          JAL  R5,PBCXMT,,         :insert 1st SYNC
          LHI  R0,4C               :
          JAL  R5,PBCXMT,,         :insert 2nd SYNC
          STH  2,RDNSR2
          STH  3,RDNSR3
          LHI  6,0
          STH  6,ADDCNT,,          :reset byte count
          J    RDN82+1A            :return to source
ENDPATCH(PBT050.PAT - INSERT SYNC EVERY SECOND DURING RECOVERY FROM NSS)
