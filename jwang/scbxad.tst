:******************************************************************
: PATCHNAME: SCBXAD.TST                     PRODUCT VERSION: SDLC 2.04
:   AUTHOR : JAMES WANG                       ORGANIZATION : STS
:  CUSTOMER: TELERATE                         DATE WRITTEN : FEB 5, 1991
: DESCRIPTION OF PROBLEM:
:    AFTER UI WITH ADDRESS 'FF' IS SENT FROM TIF TO CU, THE SCBXAD IS
:    CHANGED TO HAVE VALUE '0FF'. LATER ON , WHEN TIF SENDS SUPERVISROY FRAME
:    , TIF DOES NOT RESTORE SCBXAD WITH CONFIGRED ADDRESS. SO, TIF SENDS
:    RR FRAME WITH ADDRESS 'FF'.
:******************************************************************************

PATCH(910105,1000,JWANG,XMRR,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,18)
        LB      R1,CFXCTB,R4,
        LB      R6,SCBLKS+SCBSID,RSCB,
        STB     R6,SCBLKS+SCBXAD,RSCB,
        J       XCMD00,,
CONPATCH(INFTRM+0A,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,12)
        LB      R0,SCBLKS+SCBSID,RSCB,
        STB     R0,SCBLKS+SCBXAD,RSCB,
        J       INFTRM+10,,
ENDPATCH(RESTORE SCBXAD BEFORE TIF SENDS RR FRAME)

  