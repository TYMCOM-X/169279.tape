R (UPL)X22
O BASE1
FI HN 4
SORT WHO TNUM
REPORT START
ON CHANGE WHO PRI FORMAT 80X 'INITIALS   TICKET #' END
PRI WHO TNUM FORMAT 3X A3 6X I6 END
REPORT END
CLOSE
Q

    