        IF 1-SOLOCS

: THIS GIVES US MORE PATCH AREA AND SHOULD BE THE LAST PATCH FILE
: (ISIS PATCH)
Q       EQ      PATCH1-SEG1
S1SIZE  EQ      Q+100           :SOME EXTRA FOR SPECIALIZED PATCHES
        SEG     0E
        ORG AREAS+4
        WC      0
        ORG     AREAS+4
        WC      S1SIZE
        EI :SOLOCS
PA1PTR  EQ      PATCH1
   