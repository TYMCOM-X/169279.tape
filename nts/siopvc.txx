:          FILE:  CONSAT
:          AUGUST 26, 1987   TCKOCHMANN
:    ********************************************************************

        SHOWME(4)      :SYSGEN DETAIL GENERATION...LEVEL 4(MAX)

:       Declare target node, slot
        LOCATION(2620,3)

:       Declare configuration
        DECLARE(SIO, 2)
        DECLARE(ASYNC,0)
        ISISRING(4096)

:       Origination host
        ACHOST(1260)
 
:       LOG-IN MESSAGE
        LTEXT(ULMSG,PVC FOR 9600 BAUD TESTING...CAUTION!!!)

:       SIO Features

        SPVRNG(0-1)     :SIO PVC PORT RANGE

        SPVCEX(0-1,AID,TID22,PCO,ALO,RBP,NOHNG,NODSC,TRS)
        UTEXT(V"8DNTS"BA55"BBOVER NITE"BB"8D"8DTBA"8DGET HDLC"8DRUN"8D)
        SUTXRG(0-1)       :SIO PVC PORTS USING UTEXT ALO STRING
  