:---------------------------------------------------------------------
: Patch name:  QLLCDM                Product and Version:  SNA 5.03
:     Author:  PHIL SNEDDON                 Organization:  STS
:   Customer:  AIR FRANCE                   Date Written:  06/01/90
: Description of Problem:  WHEN CIRCUIT TO QLLC HIF IS ZAPPED AND THE HIF WAS 
: IN Normal Response Mode NO DM IS SENT TO THE HOST
:---------------------------------------------------------------------

	 IF (DLCSHD)
         LO DLCPRO
         LO SFGPTP
	 LO GBLDEF
PATCH(900601,1610,STIG,PA0PTR,,44)
DMSAVE   WS 10
CONPATCH(HSCLR1+8,,6)
         J     HSCLR4,,
CONPATCH(PA1PTR,,2C)
HSCLR4   LIS   R1,0B                  :RESTORE ORIGINAL INSTRUCTION
         JAL   R5,QUECMD,,            :RESTORE ORIGINAL INSTRUCTION
         STM   R0,DMSAVE,,
         LIS   R1,5                   :DM COMMAND
         LIS   R3,0                   :NO BUFFER NEEDED
         LIS   R2,0                   :NOT A DATA COMMAND
         LHL   R11,LSCLKS+LSCPUC,R12, :GET PUCTAB POINTER FOR NEXT ROUTINE
         JAL   R9,PTXMT,,             :SEND DM
         LM    R0,DMSAVE,,
         J     HSCLR1+10,,
ENDPATCH(Send DM when circuit is zapped to QLLC HIF in NRM)
	 EI 
   