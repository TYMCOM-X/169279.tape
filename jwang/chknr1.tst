:+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
: new patchname: CHKNR1.TST
: modified from chknr.tst on Feb 14, 1991
: a counter 'frmrct' is added to record the number of out of sequence (RR with
: incorrect sequence) occurrence.
:
:************************************************************************
:  PATCHNAME: CHKNR.TST                       PRODUCT VERSION: SDLC 2.04
:    AUTHOR : JAMES WANG                        ORGANIZATION:  STS
:   CUSTOMER: RREEF FUNDS                       DATE WRITTEN:  JAN 24, 1990
:  DESCRIPTION OF THE PROBLEM:
:      CUSTOMER SENDS SEVERAL INFORMATIONS. THEN TYMNET SENDS RR WITH CORRECT
:      R(N) TO ACKNOWLEDGE INCOMING FRAMES. WHENEVER CUSTOMER HAS NO DATA
:      TO SEND , CUSTOMER SENDS BACK RR FRAME WITH INCORRECT R(k). TWO TRACES
:      SHOW THAT k = N.
:      WHEN INCORRECT RR RECEIVED BY TYMNET INTERFACE, TYMNET WILL THEN SENDS
:      FRMR BACK. CUSTOMER DOES NOT LIKE FRMR AND WANTS TYMNET MASK OFF THE
:      PROBLEM.
:  TASK: WHEN INCORRECT RR RECEIVED, INSTEAD OF SENDING FRMR, PATCH THE CODE
:      TO UPDATE THE V(S) TO MATCH THE INCOMING 'RR R(N)'.
:***************************************************************************


:::PA0PTR  EQ      ((PA0PTR+3)/4)*4
PATCH(910124,1000,JWANG,PA0PTR,,104)
FRMRCT  HC      0       :counter of out of sequence occurrence
FRMRPT  HC      0       :INDEX TO THE CONTROL CODE TRACE TABLE
FRMRCC  BS      100     :CONTROL CODE OF INCORRECT INCOMING rr FRAME
CONPATCH(CHKNR+2E,,6)
        J       PA1PTR,,
CONPATCH(PA1PTR,,3A)
        JGE     4,R5
        LIS     R6,1            :SET 1
        AHM     R6,FRMRCT,,     :INCREMENT COUNTER BY 1
        LB      R6,SCBLKS+SXNR,RSCB,
        STB     R6,SCBLKS+SXVS,RSCB,
        LHL     R7,FRMRPT,,     :GET THE INDEX
        STB     R6,FRMRCC,R7,   :SAVE THE SXNR
        AIS     R7,1            :INCREMENT BY 1
        CLHI    R7,100          :END OF TABLE?
        JL      .+6             :NO,JUMP
        LIS     R7,0            :YES, WRAP TO THE BEGINNING OF TABLE
        STH     R7,FRMRPT,,     :SAVE INDEX
        J       4,R5
ENDPATCH(INSTEAD OF SENDING FRMR TO REJECT INCOMING RR WITH INCORRECT NR)
ENDPATCH(PATCH THE CODE TO MASK OFF THE CUSTOMER'S PROBLEM BY UPDATING)
ENDPATCH(OUR VS)
   