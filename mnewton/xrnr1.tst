
        IF      \MINRQA
        ELSE
MINRQA  EQ      0E
        EI
patch(891115,1200,bpc,xmrr,,6)
        j      pa1ptr,,
conpatch(pa1ptr,,28)
        clhi   4,1
        je     xm0
xm1     lb     1,cfxctb,4,
        j      xcmd00,,
xm0     lhl     1,scblks+scbrqa,rscb,
        clhi    1,MINRQA
        jge    xm1
        lis    4,3
        j      xm1
endpatch(doulbe check before we send RR)
:
