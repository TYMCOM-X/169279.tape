patch(900924,1115,warnerd,pa0ptr,,2)

ndlsav  bs      1

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

        jal     r4,gbb,,
        lis     r3,0
        lis     r4,01
        stb     r4,bbufer,r3,
        ais     r3,1
        lb      r4,m.cacp+6,,
        stb     r4,bbufer,r3,
        ais     r3,1
        lb      r4,m.cacp+7,,
        stb     r4,bbufer,r3,
        ais     r3,1
        lhi     r4,gdidad
        stb     r4,bbufer,r3,
        ais     r3,1
        lhi     r4,0010
        stb     r4,bbufer,r3,
        ais     r3,1
        lhi     r4,36
        stb     r4,bbufer,r3,
        ais     r3,1
        lis     r4,etx
        stb     r4,bbufer,r3,
        lis     r2,07
        putcmd(xmt,rsid)
        rlcmd(xmt,rsid,rrid)
        j       entna1+0c2,,

        fo      utsptp
        fo      utsfex
        fo      utsblk
        fo      utsrcv
        fo      utssrv
        fo      unativ
        fo      cmdlst

endpatch( send DLE 6 at logon)
  