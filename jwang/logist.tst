:
: used for escalation 43189
: problem: when x121 addr needs password. reported by steve white (ENS)
;
;
patch(861107,1700,jwang,pa0ptr,,0a)
logost  ac      /isistech"3a0/
conpatch(pcr472+20,,6)
        j       pa1ptr,,
conpatch(pa1ptr,,18)
        lis     r12,0
logocp  lb      r0,logost,r12,
        ais     r12,1
        clhi    r12,9
        jl      logocp
        j       pcr482,,
conpatch(pcr466+6,,4)
        rbt     rl,temp2
endpatch(logstring)
  