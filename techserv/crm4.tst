:---------------------------------------------------------------------
: Patch name:CRM4.TST                Product and Version: CMT 7:04 
:     Author:ANIL THAKUR                    Organization:  MMGMT
:   Customer: NISAAN                        Date Written:  09/06/91
: Description of Problem:  CMT code was anlysing the wrong field
:			    at routine which handles crm4 prt logon
:			    resulting in  cprtlu flag not beeing set
:			   At extended ddt because cprtlu was not set
:		           we were not dispalying the lu type of the
:			   printer 	 	       
:---------------------------------------------------------------------
	lo	logon
patch(090691,1000,a/thakur,prtlu4,,6)
	j	pa1ptr,,
conpatch(pa1ptr,,20)
	jalr	r1,r1		:from source
	lb	r0,dcua,r12,
	stb	r0,caddi1,r11,	:from source
	jalr	r1,r1		:from source
	j	prtlu4+8,,	:back to source
endpatch(check)

	
   