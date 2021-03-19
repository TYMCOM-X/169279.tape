


			HAYES MODEM COMMANDS

FUNCTION		ACTION			300	1200	2400
----------------------------------------------------------------------
COMMAND PREFIX					AT	AT	AT
ESCAPE CODE	 MODEM COMMAND MODE		+++	+++	+++
REPEAT COMMAND	 PREVIOUS COMMAND LINE		A/	A/	A/
DIAL NUMBER	 MODEM DIALS NUMBER		D	D	D
........................................................................
DIAL MODIFIERS	 PULSE				P	P	P
		 TONE				T	T	T
		 PAUSE				,	,	,
RETURN TO COMMAND STATE AFTER DIALING		;	;	;
ORIGINATE CALL IN ANSWER MODE			R	R	R
INITIATE HOOKFLASH					!	!
WAIT FOR SILENCE					@	@
WAIT FOR SECOND DIAL TONE				W	W
DIAL NUMBER "N"							S=n
.........................................................................
ANSWER MODE,GOES OFF HOOK IMMEDIATELY		A	A	A      *
.........................................................................
HANG UP	,TERMITATES CONNECTION			H	H	H
MODEM GOES OFF HOOK				H0	H0	H0
SPECIAL OFF HOOK AUXILIARY RELAY		H2	H2	
.........................................................................
WAIT FOR CARRIER,MODEM WAITS FOR CARRIER	O0	O0	O0
MODEM INITIATES EQUALIZER RETRAIN				O1
.........................................................................
STORE NUMBER							&Zn=x
.........................................................................
CARRIER TYPE	CCITT V.22 @1200 bps			B0	B0     *
		BELL 212A @1200 bps	      preset	B1	B1     *
.........................................................................
TRANSMIT CARRIER   CARRIER ON			C1	C1	PRESET
		   CARRIER OFF			C0	C0              
.........................................................................
CARRIER DECTECT	  ALLWAYS TRUE			DIP SWITCH   	&C0    *
		  FOLLOW CD SIGNAL				&C1    *
.........................................................................
GUARD TONE     NO GUARD TONE	            PRESET   PRESET	&G0    *
SELECTION	550HZ TONE					&G1
	       1800HZ TONE					&G2
.........................................................................
LONG SPACE DISCONNECT ENABLE				Y1	Y1
		DISABLE					Y0	Y0
.........................................................................
JACK SELECTION	RJ-11,RJ-45,RJ45S		DIP SWITCH	&J0
		RJ-12 RJ-13					&J1     *
.........................................................................
PULSE DIAL RATIO 39%MAKE/61%BREAK	    PRESET    PRESET	&P0
	         33%MAKE/67%BREAK				&P1
.........................................................................
COMMAND RECOGNITION   ENABLED				DUMB STRAP
	              DISABLE				
.........................................................................
COMMAND ECHO,NOT ECHO TO TERMIMAL		E0	E0	E0
	ECHO TO TEMINAL				E1	E1	E1
.........................................................................
ON-LINE ECHO   CHARACTER ECHOED TO TERMINAL	F0	F0	F0
	       CHARECTER NOT ECHOED		F1	F1	F1
.........................................................................
RESULTS CODES	CODES RETURNED TO TERMINAL	Q0	Q0	Q0
		NOT RETURNED TO TERMINAL	Q1	Q1	Q1
.........................................................................
SELECT RESULT CODES
SMARTMODEM 300 RESULT CODE SET			PRESET	X0	X0
ENABLE CONNECT XXXXX (DOSE NOT WAIT FOR RING)		X1	X1     *
ENABLE NOT DIALTONE					X2	X2
ENABLE BUSY						X3	X3
ENABLE NO DIALTONE AND BUSY				X4	X4
........................................................................
DISPLAY OF RESULTS CODES
DISPLAY AS DIGITS				V0	V0	V0
DISPLAY AS WORDS				V1	V1	V1
........................................................................
SPEAKER CONTROL  ALLWAYS OFF			M0	M0	M0
	         ON UNTIL CARIER		M1	M1	M1
		 ALWAYS ON			M2	M2	M2
		 ON UNTIL CARRIER				M3
........................................................................
VOLUME CONTROL    LOW SPEAKER				L0,L1	L0,L1
		MEDIUM SPEAKER				L2	L2
	        HIGH SPEAKER				L3	L3
........................................................................
CHARACTER TRANSMISSION MODE SELECTION
	ASYNC MODE				PRE	PRE	&M0or&Q0
MODE 1  SYNC/ASYNC MODE				PRE	PRE	&M1or&Q1%
MODE 2  SYNC,DIAL STORED NUMBER MODE				&M2or&Q2%
MODE 3  SYCN,DTR CONTROL OF DATA/TALK				&M3or&Q3%
MODE 4  SYNC,HAYES INTERFACE					&Q4
.........................................................................
TRANSMIT CLOCK SOURCE
 MODEM SOURCES CLOCK FOR SYNC MODE				&X0
 TERMINAL SOURCES CLOCK FOR SYNC MODE				&X1%
 MODEM DERIVES CLOCK FOR SYNC MODE(SLAVE OPERATION)		&X2
.........................................................................
DTR STATUS   MODEM EGNORES DTR		SWITCH	SWITCH		&D0
ON TO OFF DECTECT ON DTR					&D1
HANGS UP ON TO OFF ON DTR		SWITCH  SWITCH		&D2
MODEM INIT ON TO OFF ON DTR			SWITCH		&D3
.........................................................................
CTS &RTS STATUS  CTS FOLLOWS RTS				&R0
MODEM IGNORES RTS:CTS ALWAYS ON		PRE	PRE		&R1
.........................................................................
DSR STATUS  DSR REMAINS ON WHILE MODEM IS ON	PRE		&S0
MODEM OPERATES ACCORDING TO EIA RS232C SPECIFICATION		&S1
........................................................................
ADDRESS S-REGISTER				Sr	Sr	Sr
.........................................................................
SET S-REGISTER					Sr=n	Sr=n	Sr=n
........................................................................
READ S-REGISTER					Sr?	Sr?	Sr?
........................................................................
SOFTWARE RESET					Z	Z	Zn
........................................................................
LOAD FACTOR PROFILE						&F
........................................................................
STORE ACTICE CONFIGURATION					&Wn
........................................................................
CHOOSE ACTIVE CONFIGURATION					&Yn
........................................................................
VIEW CONFIGURATION PROFILES					&V
........................................................................
MODEM CHECK						I0	I0
........................................................................



			SWITCH SETTING
			--------------
FUNCTION	300	1200	1200B1	1200B2	1200A	1200C	
--------	---	----	------	------	-----	-----	
DTR STATUS	#1	#1	#4	#4	#4	#2
IGNORE DTR	DOWN	DOWN	DOWN	RIGHT	DOWN	UP
FOLLOW DTR	UP	UP	UP	LEFT	UP    	DOWN
---------------------------------------------------------------
RESULT CODES	#2	#2	COMMAND	COMMAND	COMMAND	COMMAND 
NUMERIC		DOWN	DOWN	
VERBOSE		UP	UP
---------------------------------------------------------------
RESULTS CODES	#3	#3	COMMAND COMMAND COMMAND COMMAND
DISALBE		DOWN	DOWN
ENABLE		UP	UP
---------------------------------------------------------------
COMMAND ECHO	#4	#4	COMMAND COMMAND COMMAND COMMAND
DISABLE		DOWN	DOWN
ENABLE		UP	UP
---------------------------------------------------------------
AUTO ANSWER	#5	#5	COMMAND COMMAND COMMAND COMMAND
DISABLE		DOWN	DOWN
ENABLE		UP	UP
---------------------------------------------------------------
CARRIER DETECT	#6	#6	#3	#3	#3	#1
ALWAYS TRUE	DOWN	DOWN	DOWN	RIGHT	DOWN	DOWN
FOLLOW CD	UP	UP	UP	LEFT	UP	UP
---------------------------------------------------------------
JACK TYPE	#7	#7	#2	#2	#2	
RJ-12/RJ-13	DOWN*	DOWN*	DOWN*	RIGHT*	DOWN*
RJ-11,41S,45S	UP	UP	UP	LEFT	UP	PRESET
---------------------------------------------------------------
COMMAND RECOG'N		#8
ENABLE	     PRESET	DOWN	PRE	PRE	PRE	PRE
DISABLE	     		UP
---------------------------------------------------------------
1200bps CARRIER		#9	#5	COMMAND COMMAND COMMAND
CCITT       SUPPORTS	DOWN	DOWN	



		
BELL 212A   BELL 103	UP	UP
---------------------------------------------------------------
RESPONSE TO
DTR ON/OFF		#10
MODEM RESET		DOWN
HANG UP			UP
----------------------------------------------------------------
PORT SELECTION
(FOR INTERNAL MODEMS)		#1	#1	
COM 1				DOWN	RIGHT
COM 2				UP	LEFT
----------------------------------------------------------------
PULSE DIAL RATIO			#6
39/61 BREAK				UP
33/67 BREAK				DOWN
----------------------------------------------------------------
FOR MORE HELP CALL HAYES TECH SUPPORT @800-241-6492..............
******************************************************************

    