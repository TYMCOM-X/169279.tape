
inter-link established from TYMNET-MAXTED to UKNET-MAXTED
please log in: 
>>> MULTIPLEXER <<<
VERSION 3.02, HOST 191
BOSS

&char ^
&m

please log in: probe:*;
NAME: leewake
  PASSWORD: 
122
:host 328
328 ANSWERED 0 2314 7 IIX-Y ACOM SLOT# 1
328 ANSWERED 0 2323 6 IIX-Y ACOM SLOT# 1
328 SHUT 0 2316 6 IIX-Y ACOM SLOT# 1
:
&m

please log in: ukops:328;
NO PORTS AVAILABLE Zapped  49 
&m

please log in: ukops:323;
P 16
TOM  IS ON LINE

>st
HOST  STATUS
  323  UP    

  SORD    0 UP   TOM  
    PORT STATUS  TIME  CAND/SIG SORDS : TYPES>SPEED

HOST  STATUS
  358  UP    
  HOST KEY = 102, PORTS ANSWERED =   3, AVERAGE CPS =       0, HOST COST =  5
  SORD    1 UP   MIS6 
    PORT STATUS  TIME  CAND/SIG SORDS : TYPES>SPEED
       0 ACTIVE   6:22 SIG /SIG     1 : 0-31>11
       1 ACTIVE   3:14 SIG /SIG     1 : 0-31>11
       2 ACTIVE   2:49 SIG /SIG     1 : 0-31>11
       3 UP            SIG /SIG     1 : 0-31>11
       4 UP            SIG /SIG     1 : 0-31>11
       5 UP            SIG /SIG     1 : 0-31>11
       6 DOWN          SIG /SIG     1 : 0-31>11
       7 DOWN          SIG /SIG     1 : 0-31>11

HOST  STATUS
  328  UP    
  HOST KEY =  72, PORTS ANSWERED =   1, AVERAGE CPS =    4181, HOST COST =  6
  SORD    2 UP   MIS3 
    PORT STATUS  TIME  CAND/SIG SORDS : TYPES>SPEED
       8 ACTIVE   5:21 SIG /SIG     2 : 0-31>11
       9 DOWN          SIG /SIG     2 : 0-31>11
      10 DOWN          SIG /SIG     2 : 0-31>11
      11 DOWN          SIG /SIG     2 : 0-31>11
      12 DOWN          SIG /SIG     2 : 0-31>11
      13 DOWN          SIG /SIG     2 : 0-31>11
      14 DOWN          SIG /SIG     2 : 0-31>11
      15 DOWN          SIG /SIG     2 : 0-31>11


>tom2323

&m

please log in: ukops:314;
P 16
TOM  IS ON LINE

>st
HOST  STATUS
  314  UP    

  SORD    0 UP   TOM  
    PORT STATUS  TIME  CAND/SIG SORDS : TYPES>SPEED

HOST  STATUS
  308  UP    
  HOST KEY =  52, PORTS ANSWERED =   9, AVERAGE CPS =   10769, HOST COST =  7
  SORD    1 UP   MIS1 
    PORT STATUS  TIME  CAND/SIG SORDS : TYPES>SPEED
       0 ACTIVE   6:24 SIG /SIG     1 : 0-31>11
       1 ACTIVE   5:59 SIG /SIG     1 : 0-31>11
       2 ACTIVE   5:44 SIG /SIG     1 : 0-31>11
       3 ACTIVE   5:40 SIG /SIG     1 : 0-31>11
       4 ACTIVE   3:28 SIG /SIG     1 : 0-31>11
       5 ACTIVE   5:34 SIG /SIG     1 : 0-31>11
       6 ACTIVE   5:27 SIG /SIG     1 : 0-31>11
       7 ACTIVE   4:22 SIG /SIG     1 : 0-31>11
       8 ACTIVE   0:19 SIG /SIG     1 : 0-31>11
       9 UP            SIG /SIG     1 : 0-31>11
      10 UP            SIG /SIG     1 : 0-31>11

HOST  STATUS
  328  UP    
  HOST KEY =  72, PORTS ANSWERED =   2, AVERAGE CPS =       0, HOST COST =  8
  SORD    2 UP   MIS3 
    PORT STATUS  TIME  CAND/SIG SORDS : TYPES>SPEED
      11 UP            SIG /SIG     2 : 0-31>11
      12 UP            SIG /SIG     2 : 0-31>11
      13 ACTIVE   2:31 SIG /SIG     2 : 0-31>11
      14 UP            SIG /SIG     2 : 0-31>11
      15 ACTIVE   0:31 SIG /SIG     2 : 0-31>11


>`ctom 2314
?
>tom2314
`etom2323 *
shut host 328
?
>grab tom2323

>shut host 328

>
&m

please log in: ukops:328;
P 11
MIS3 IS ON LINE

MIS Spirit connected on N 2314 - H 328

&z
 Zapped  45 
&
 11: HOST DID NOT ACKNOWLEDGE USER DISCONNECT