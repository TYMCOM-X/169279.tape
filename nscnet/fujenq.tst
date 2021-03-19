:==============================================================================
: Product	PBH v10.04
: Patch Name	FUJENQ.TST
: Author	Toshi Aoki (NIS.AOKI)
: Date		27-SEP-1990
: Description	Fujitsu model K series host is designed to respond to a
:		Forward Abort from the PBH not only with an EOT but also
:		with an ENQ rather than with a NAK. IBM responds with a NAK.
:		NSR #1645 already fixes the case of EOT. This patch will deal
:		the case of ENQ with the same manner as NSR #1645.
:==============================================================================
 
	LO	BSCPTP
PATCH(270990,1900,NIS.AOKI,SENQ+4,,2)
	HC	FUJEOT-PSEG
ENDPATCH(also allow ENQ response to Forward Abort for Fujitsu model K host)
	FO	BSCPTP
