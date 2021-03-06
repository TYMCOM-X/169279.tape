:----------------------------------------------------------------------------
: Patch name:  SXM505.TST               Product and Version:  PBT 5.05
:     Author:  BRUCE BELL                      Organization:  STS
:   Customer:  HONG KONG BANK (HKBGNET)        Date Written:  2/19/91
:
: Description of Problem:
:    DURING POLLING WITH A VAX HOST IF THE INTERFACE SENDS OUT ANY FFFF
:    CHARACTERS BEFORE THE ACK IS SENT, THE VAX WILL LOG OUT AND THE LINK
:    WILL BE DROPPED. (NOTE: AN IBM HOST IS NOT EFFECTED AS IT DISREGARDS
:    THE FFFF CHARACTERS).
:
: Problem Solution:  [ This is modified version of patch (HSBCCODES)SXM.PAT ]
:    This patch changes the PAD character to syn's on a single buffer
:    transmit, until the message has been loaded into the rotor list. Then
:    it is changed back to FFFF.  The rotor list ends up having 7 elements
:    - (1 under the reserved storage).  The patch fixes the problem of 
:    having FFFF appear between syn's and the EOT.  The FFFF appears because 
:    there is a delay and the PAD character is sent out to take up time.
:-----------------------------------------------------------------------------

	LO BSCCHR
	LO CMDLST
	LO BSCRRC
	LO BSCEXC
	LO BSCCRC
	LO BSCRCV
	LO BSCSRV
	LO BSCSXM
	LO BBUFER
	LO BSCPTP
	LO BSCDTR
	LO FRNTND
	LO STATUS

PATCH(021991,1100,B/BELL,BSXW05+0C,,6)
	J	PA1PTR,,
CONPATCH(PA1PTR,,72)
	LI	RCMD,CSPAD^10+RSYN^8+RSYN	:SET PAD CHAR TO SYN SYN
	STM	RCMD,8,RAD			:STORE CMD INTO ROTOR
:   LIS	R4,XCENQ			:XMT POLLING SEQUENCE
:   STB	R4,XMTOPC,RL			:(EDF) 10/30/85 FROM RL2 TO RL
	LHL	RCNT,BSXCNT,RL2			:GET MESSAGE COUNT OF BYTES
	LI	RCMD,CWRITE^10,RCNT		:FETCH WRITE MSG CODE
	LI	RDAT,BBUFER,RDAT		:GET ABS ADR OF MSG BUFFER
	STM	RCMD,10,RAD			:STORE CMD INTO ROTOR
	LI	RCMD,CSPAD^10+0FFFF		:RESET PAD CHAR TO FFFF 
	LIS	RDAT,0				:ADRS FIELD = 0
	STM	RCMD,18,RAD			:STORE CMD INTO ROTOR
	TBT	RL,RTSCTS,,			:FULL OR HALF DUPLEX
	JN	PSXW14,,			
	LM	RCMD,PAD2MOP,,			:FULL DUPLEX
	STM	RCMD,20,RAD			:STORE CMD INTO ROTOR
	J	PSXW15

PSXW14  LM	RCMD,PAD6MOP,,			:HALF DUPLEX
	STM	RCMD,20,RAD			:6 PADS
	AIS	RAD,8				:ADVANCE LIST POINTER
	LIS	RCMD,CRTSOF			:PUT 'TURN RTS OFF' ON LIST
	STH	RCMD,20,RAD			

PSXW15
	LIS	RCMD,CSBT			:GET SET BIT COMMAND
	EXHR	RCMD,RCMD			:POSITION
	OR	RCMD,RL				:INCLUDE BISYNC LINE NUMBER
	LA	RDAT,BSXOCP,,			:GET ADR BIT ARRAY
	STM	RCMD,28,RAD			:STORE CMD INTO ROTOR
	LIS	RCMD,CHALT			:END LIST w/ HALT CMD
	STH	RCMD,30,RAD			:STORE CMD INTO ROTOR
	J	BSXW15+16,,			:RETURN TO SOURCE CODE

ENDPATCH(Temporarily Change Pad Character To SYN SYN)

	FO BSCCHR
	FO CMDLST
	FO BSCRRC
	FO BSCEXC
	FO BSCCRC
	FO BSCRCV
	FO BSCSRV
	FO BSCSXM
	FO BBUFER
	FO BSCPTP
	FO BSCDTR
	FO FRNTND
	FO STATUS
 