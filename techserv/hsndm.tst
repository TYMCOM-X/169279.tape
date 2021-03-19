
    IF  (\(SHDPTS))!(\(SHDMPS))
PATCH(901127,1800,bpc,hsndm0,,6)
        j       pa1ptr,,
CONPATCH(PA1PTR,,1a)
        jal     rlink5,relibb,,
        lis     r1,7
        sth     r1,scblks+scbrqa,rscb,
        la      r1,hsndm1,,
        j       hsdrtx,,
ENDPATCH(restore scbrqa in hsndm state)
  EI 
