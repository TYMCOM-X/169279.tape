:print AT PROMPT (>) ENTER 1 FOR RFI  OR  2 FOR ESCALATION
:PRINT "                    _              _
:PROMPT > 
:MATCH '1' GOTO 62
:MATCH '2' GOTO 8 
:PRINT INVALID INPUT
:SKIP 1
:print take "                           ESCALATION TO HQTECH
:print take
:PRINT TAKE
:PRO TAKE CAPTURE PRIORITY LEVEL (1 THRU 5): 
:MATCH "1" GOTO 19
:MATCH "2" GOTO 19
:MATCH "3" GOTO 19
:MATCH "4" GOTO 19
:MATCH "5" GOTO 19
:PRINT MUST INPUT APPROPRIATE PRIORITY CODE (1 THRU 5)
:SKIP 11
:pro take capture BASELINE PRODUCT CODE:
:MATCH 'CONSAT' GOTO 23
:MATCH 'ISCS' GOTO 23
:SKIP 24
:EXEC *** FORMS.CONSATINFO
:print take
:pro take capture VERSION: 
:print take
:pro take capture IS THIS VERSION IN BETATEST (Y/N)? 
:print take
:pro take capture CUSTOMER NAME and CID#:
:PRINT TAKE
:pro take capture NODES: 
:print take
:pro take capture HOST: 
:print take
:pro take capture SLOT: 
:print take
:pro take capture KERNAL HOST: 
:print take
:print take LIST FILES/DUMP FILES (NOTE - BE SURE SYMBOL TABLE IS APPENDED): 
:pro take capture 1.
:pro take capture 2.
:pro take capture 3.
:print take
:print FOR THE NEXT TWO ITEMS, TYPE 'STOP' ON A NEW LINE TO INDICATE YOU
:print HAVE FINISHED INPUTTING
:PRINT TAKE
:PRINT TAKE PROBLEM DESCRIPTION:
:pro take capture "
:match 'STOP' goto 51
:skip 48
:rep *****
:print take
:PRO TAKE CAPTURE IF APPLICABLE, PROVIDE RELATED NSR AND/OR NSSC TKT. NUMBER: # 
:print take
:print take STEPS TAKEN TO RESOLVE PROBLEM:
:print take
:pro take capture "
:match 'STOP' goto 60
:skip 57
:rep *****
:SKIP 82    
:print take
:PRINT TAKE "                        REQUEST FOR INFORMATION
:PRINT TAKE
:PRINT TAKE
:PRINT TAKE PRIORITY LEVEL 5
:PRINT TAKE
:pro take capture BASELINE PRODUCT CODE:
:print take
:pro take capture VERSION: 
:print take
:pro take capture CUSTOMER NAME and CID#:
:PRINT TAKE
:print FOR THE NEXT ITEM, TYPE 'STOP' ON A NEW LINE TO INDICATE YOU
:print HAVE FINISHED INPUTTING
:PRINT
:PRINT TAKE QUESTION
:pro take capture "
:match 'STOP' goto 81
:skip 78
:rep *****
:print take
:PRO TAKE CAPTURE HAVE YOU DISCUSSED THE QUESTION/PROBLEM WITH YOUR RTM (Y/N):
:print take
:print take
:pro take capture CC RESPONSIBLE and EMPLOYEE #:
:pro take capture CC PHONE #:
:print take
:pro take capture REGION  (EASTERN, MID-ATL, CENTRAL, WESTERN, EXNET, INTL, TNSC):
:pro take capture REGIONAL TECHNICAL MANAGER: 
:pro take capture REGIONAL TECHNICAL MANAGER's ONTYME ID: 
:pro DO YOU WISH TO REVIEW YOUR ENTRIES (Y/N)?: 
:match 'N' goto 106
:type line
:pro DO YOU WISH TO MAKE ANY CHANGES (Y/N)?: 
:match 'N' goto 106 
:pro SIMPLY ENTER LINE NUMBER HERE > 
:perform goto 
:print AT PROMPT (>) ENTER STANDARD /old text/new text/
:prompt >
:PERFORM CHANGE 
:print
:prompt ADDITIONAL CHANGES (Y/N)?: 
:match 'N' goto 92
:skip 97
:print take
:form msg
:print AT PROMPT (>) INPUT APPROPRIATE ONTYME ID(S) OR DISTRIBUTION FILE NAME
:print       (:SEND CC) COMMAND WILL ISSUE AUTOMATICALLY.
:pro > 
:PERFORM SEND CC 
:print THANK YOU.







 