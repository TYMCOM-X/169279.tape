find dup bet int("01/01/92") int("01/31/92") and elm gt 0 and net ne 'VIDEONET' and hn eq 1 or 3 or 4 or 14 or 18.
report start.
section initial.
section getrec.
section heading.
 on start print "tnum  sver coc          prod    srgn    hrgn     elm         esc hqcc dup".
section print.
section totals.
 on change tnum print tnum sver " " coc " " prod " " srgn " " hrgn " "  elm " "  esc " "  hqcc " " dup.
section final.
report end.
