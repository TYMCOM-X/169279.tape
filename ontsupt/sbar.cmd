find dup bet int("03/01/92") int("03/31/92") and sver 1 and hn lt 5 and ne 2 AND ELM GE 0 and hn eq 1 or 3 or 4 or 14 or 18 and net ne 'VIDEONET'.
print "finshed find, now doing sort".
sort dup.
print "finished sort, now doing report".
report start.
section initial.
section getrec.
section heading.
 on start print "   Date      Count     Mean  ELM  StdDev ELM  Hi ELM    Lo ELM".
section print.
section totals.
 on change Dup  print Dup  tot 1  mean ELM  stdev ELM  Max ELM  min ELM FORMAT
                      D2   I6       F9.2       F9.2      I11      I11   END.
section final.
report end.
    