patch(900924,1115,warnerd,pa0ptr,,2)

ndlsav  bs      1

        lo      utsptp
        lo      utsfex
        lo      utsblk
        lo      utsrcv
        lo      utssrv
        lo      unativ

conpatch(entna1+0bc,,6)
        j       pa1ptr,,

conpatch(pa1ptr,,1a)

        lb      r2,pgrtab+crxsid,rrid,
        sbt     r2,pgrtab+xmtdat,rrid,
        sth     r6,m.cacp+9,,
        j       entna1+0c2,,

conpatch(rtpol3,,6)
        j       pa1ptr,,

conpatch(pa1ptr,,38)

        lb      r2,pgrtab+crxsid,rrid,
        rbt     r2,pgrtab+xmtdat,rrid,
        jn      snddle6,,
        lb      r2,pgrtab+crxsid,rrid,
        j       rtpol3+6,,
snddle6 lis     r2,0
        stb     r2,ndlsav,,
        lb      r2,pgrtab+crxsid,rrid,
        lis     r2,xhss
        lhi     r3,A6.
        j       xstatu,,

        fo      utsptp
        fo      utsfex
        fo      utsblk
        fo      utsrcv
        fo      utssrv
        fo      unativ

endpatch(send DLE 6 upon receipt of needle)
 