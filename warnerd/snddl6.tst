patch(900924,1115,warnerd,pa0ptr,,2)

ndlsav  bs      1
place   ws      10

        lo      utsptp
        lo      utsfex
        lo      utsblk
        lo      utsrcv
        lo      utssrv
        lo      unativ
        lo      cmdlst

conpatch(entna1+0bc,,6)
        j       pa1ptr,,

conpatch(pa1ptr,,250)

        stm     r0,place,,
        lhi     r2,pakcmd
        lhi     r3,abel
        if      nbilin-10
        lhi     rl,(nbilin-1)
        else
        lis     rl,(nbilin-1)
        ei
        ldrrid(rrid)
        lhl     rsid,pgrtab+lncsid,rrid,
        putcmd(xmt,rsid)
        rlcmd(xmt,rsid,rrid)
        lm      r0,place,,
        j       entna1+0c2,,

nobf    hc      0

        fo      utsptp
        fo      utsfex
        fo      utsblk
        fo      utsrcv
        fo      utssrv
        fo      unativ
        fo      cmdlst

endpatch( send DLE 6 at logon)
   