
:
:  DISABLE PICO CONSOLE DISPLAY PATCH      CONSOL.PAT	08-NOV-89    
:
:  Turns off the  console port  display of the PICO/TSI emulation
:  of the engine front console.   ISIS  sends the standard engine
:  console display  to the PICO/TSI even though there is no  true
:  front  console on  the PICO/TSI.  This display is picked up by
:  the firmware which displays it in ENGBug on  the console port.
:  If no console port is  in use, this ISIS  display simply  uses
:  engine and  PICO mailbox  resources unnecssarily.   This patch
:  changes the ISIS  FLASH routine  doing  the  Console I/O (CIO)
:  command into a Load Register (LR) command.  The effect of this
:  patch is to do nothing yet retain all condition codes prior to
:  the CIO command.
:

	REMARK	%Disable PICO/TSI Console display%

	IF	TSI!NANO
	
	LO	FLASH
	ORG	FLASH1+3A
	HC	0			: Zero out CIO command
	ORG	FLASH1+3A
	LR	R3,R3			: Replace CIO with a LR
	FO	FLASH
	
	EI	

