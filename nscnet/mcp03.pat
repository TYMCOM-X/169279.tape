:***********************************************************
:  (NSCNET)MCP03.PAT
:  ADDITIONAL PATCH FILE FOR SOURCE V3.01 PATCH FILE
:  CREATED BY NIS JAPAN
:***********************************************************

:==== (1) ====
:  BUG FOR INCORRECT JUMP REGISTER FOR OCT
:  FROM R5 TO R6
:
        LO      BSUB
PATCH(881217,1100,NIS.FURUTA,Z.TX20+10,,4)
        JAL     R6,OCT
ENDPATCH(CORRECT JUMP REG FOR OCT ROUTINE)
        FO      BSUB
        
:==== (2) ====
:  MASK SNA FLAG ON CALL USER DATA
:  DON'T NEED IF WE SET LU.VTI(YES) ON SNA TIF
:
:
:       LO      GBLDEF
:       LO      GIIX
:ATCH(881220,1630,NIS.FURUTA,LD89M6+8,,6)
:       J       PA1PTR,,
:ONPATCH(PA1PTR,,14)
:       NHI     R0,7F           :MASK HIGH ORDER BIT
:       STB     R0,DCBCUD+T.RIF,RDCB,
:       J       LD89M6+0E,,
:NDPATCH(MASK SNA BIT IN CALL USER DATA)
:       FO      GIIX
:       FO      GBLDEF

 