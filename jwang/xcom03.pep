:
: PATCH FILENAME: (JWANG:37:33) XCOM03.PEP  (OR X25X75.TBL)
:------------------------------------------------------------------
: CUSTOMER:  SWBT
:
:
: THIS FILE CONATINS ALL THE X25/X75 HOSTS IN SWBT.
: SEVERAL RANGES OF HOST NUMBER ARE RESERVED FOR X.25/X.75 ONLY.
: THIS FILE SHOULD BE ASSEMBLED RIGHT BEFORE ASSEMBLING
: (JWANG:37:33)XCOM03.PEQ (or TARIFF.301)
:
:-----------------------------------------------------------------
: USER CAN MODIFY THIS PATCH FILE. BUT, PLS DONOT MODIFY
: XCOM03.PEQ (OR TARIFF.301) UNLESS HQTECH IS NOTIFIED.
:-----------------------------------------------------------------
: WHEN USER MODIFIES THIS FILE, PLS UPDATE THE FOLLOWINGS CORRECTLY:
:
:  (ALL MUST BE IN HEXIDECIMAL)
:       ----       -----------
:      RANGE
:      X25LOW
:      X25HGH
:------------------------------------------------------------------
: 
: THE INITIAL X25/X75 HOSTS TABLE WILL BE:
:
:     RANGE EQ 4
:     THESE 4 RANGES ARE: (IN DECIMAL) 300-400,950-1250,3000-5000,5025-6000
:     THE CORRESPONDING HEXIDECIMAL: 012C-0190,3B6-4E2,0BB8-1388,13A1-1770
:
:    THE PATCH WILL BE:
:       RANGE  EQ     4
:                   
:       X25LOW WC     012C,03B6,0BB8,13A1
:       X25HGH WC     0190,04E2,1388,1770
:
:------------------------------------------------------------------------

  IF  X.75
PA0PTR  EQ      ((PA0PTR+3)/4)*4
:
RANGE   EQ      4                               :NUMBER OF X25/X75 HOST RANGES
:
PATCH(871026,1900,JWANG,PA0PTR,,RANGE*8)
:
X25LOW  WC      012C,03B6,0BB8,13A1             :THE LOW HOST OF EACH RANGE
:
X25HGH  WC      0190,04E2,1388,1770             :THE HIGH HOST OF EACH RANGE
:
ENDPATCH(X25X75 HOSTS TABLE, THIS TABLE IS ACCESSED BY PATCH TARIFF.301)
  EI
  