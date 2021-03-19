:**********************************************************************
: patchname: lcbtct.tst                            product version: sdlc 2.04
:   author:  ben chen                                organization: sts
:  customer: hong kong bank                          date written: Mar 28, 1991
: description of problem:
:   received a sequence 0024 BF
:                       0024 0780 8080 8480 8380
:                       0024 0181
:  caused crash with cc=26 due to node code split global iix msg
:****************************************************************************


PATCH(910328,1200,bpc,lg80m1-8,,6)
        j       pa1ptr,,
conpatch(pa1ptr,,24)
        sth     r0,dcblks+activd,rdcb,
        clhi    rlen,2
        je      lg80m7
        clhi    rlen,6
        je      lg80m7
        ar      r14,rlen      :flush remaining data
        jal     r6,dscusr,,
        lis     r0,0
lg80m7  j       4,r5
ENDPATCH(slot crashed with cc=26 due to node code split global iix msg)

