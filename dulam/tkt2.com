R (UPL)X22
OPEN (TNT)BASE1 (TNT)BASE2.
F HN EQ 21 OR 22.
SEA STAT NE CLSD.
SORT BY TNUM.
INIT 1 TKT.LST
USE PRTFB3
MAP TO (TNT)BASE2 VIA TNUM.
SORT BY TNUM ORDER.
INIT 2 STU.LST
USE PRTFB2
CLOSE.
OPEN (TNT)BASE1 (TNT)BASE2.
F HN NE 21  AND 22.
SEA STAT NE CLSD AND MAINT EQ ECSC OR ENMC OR BTFR OR BTSP OR BTGER OR BTSWE OR BTBNL OR BTITA.
SORT BY TNUM.
USE PRTFB3
RELEASE 1
MAP TO (TNT)BASE2 VIA TNUM.
SORT BY TNUM ORDER.
USE PRTFB2
RELEASE 2
CLOSE.
QUIT
