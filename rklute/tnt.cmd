OPEN (tnt)base4.
find dup bet 70004 70034 and sver 1 and hn lt 5 and ne 2.
search elm ge 0.
sort dup.
report start.
section initial.
section getrec.
section heading.
 on start print "    Date      Count     Mean  ELM  StdDev ELM  Lo ELM    Hi ELM".
section print.
section totals.
 on change Dup  print Dup  tot 1  mean ELM  stdev ELM  Max ELM  min ELM FORMAT
                      D2   I4       F9.2       F9.2      I11      I11   END.
section final.
report end.
  