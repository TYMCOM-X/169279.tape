                          SEVERITY ONE PROCEDURE

    This file is located on (TECHSERV:56)SEVERI.PRO

1.  Late in the day:
    The managers will leave you the severity one updates. 

2.  Early in the morning:
    Take the updates from the managers (if no updates were left for you send       the list out with the same status. Update the file (TECHSERV:56)SEVERI.ONE     with the most recent status, dont forget to change the date.

    -peak severi.one

Notes on updating:  1.  Be brief but when in doubt use the 'word for word'
    from the manager (be brief but be safe).  2.  If a ticket is closed or
    the severity is lowered, this should be mentioned on one report and then
    the ticket is removed from the report the next day.  

3.  After the file SEVERI.ONE is updated, transfer it into Ontyme using:

    -o all
    ckalson

    - password
    Did not set WC RC GD TD ST JL XC

    -r (mpl)auxio
    version 56
    *c emsnss
    [connected]
    
    ONTYME II   04 JAN 90 19:32:08  GMT

    ID? nsc.techserv

    KEY? 
  
    ^p
    *input severi.one
    45 46 47 88 129 130 205 206 275 276 325 326 368 369 440 488 489 489 

    *re
    (This part won't echo so you can't see what your typing, trust the
    force.)
    
    <cr>            (Hit an extra cr just in case)
    :ty             (Make sure the file made it across OK)
    :s cc * ones    (*ones is the distribution list)
    SUBJ:  Severity One Update
    :log
    
    *q

4.  Your done for today.  A copy of the report was sent to NSC.TECHSERV.
    after you pull it you can file it in the severity 1's folder.
