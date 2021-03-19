OPEN (tnt)base4.
find dup bet int("02/01/92") int("02/29/92") and sver 1 and hn lt 5 and ne 2.
report start.
section initial.
  define real    hrs.
  define integer hr1 hr2 hr3 hr4 hr5 hr6 hr7 hr8 hr9 hr10 hr11 hr12.
  define integer hr12_15 hr15_20 hr20_24 hr24.
  let hr1  eq 0.
  let hr2  eq 0.
  let hr3  eq 0.
  let hr4  eq 0.
  let hr5  eq 0.
  let hr6  eq 0.
  let hr7  eq 0.
  let hr8  eq 0.
  let hr9  eq 0.
  let hr10 eq 0.
  let hr11 eq 0.
  let hr12 eq 0.
  let hr12_15 eq 0.
  let hr15_20 eq 0.
  let hr20_24 eq 0.
  let hr24 eq 0.
section getrec.
  let hrs eq elm / 60.
  if hrs le 0 then skipit.
  if hrs gt 1 then try2.
     let hr1 eq hr1 + 1.
     goto skipit.
try2:
  if hrs gt 2 then try3.
     let hr2 eq hr2 + 1.
     goto skipit.
try3:
  if hrs gt 3 then try4.
     let hr3 eq hr3 + 1.
     goto skipit.
try4:
  if hrs gt 4 then try5.
     let hr4 eq hr4 + 1.
     goto skipit.
try5:
  if hrs gt 5 then try6.
     let hr5 eq hr5 + 1.
     goto skipit.
try6:
  if hrs gt 6 then try7.
     let hr6 eq hr6 + 1.
     goto skipit.
try7:
  if hrs gt 7 then try8.
     let hr7 eq hr7 + 1.
     goto skipit.
try8:
  if hrs gt 8 then try9.
     let hr8 eq hr8 + 1.
     goto skipit.
try9:
  if hrs gt 9 then try10.
     let hr9 eq hr9 + 1.
     goto skipit.
try10:
  if hrs gt 10 then try11.
     let hr10 eq hr10 + 1.
     goto skipit.
try11:
  if hrs gt 11 then try12.
     let hr11 eq hr11 + 1.
     goto skipit.
try12:
  if hrs gt 12 then try15.
     let hr12 eq hr12 + 1.
     goto skipit.
try15:
  if hrs gt 15 then try20.
     let hr12_15 eq hr12_15 + 1.
     goto skipit.
try20:
  if hrs gt 20 then try24.
     let hr15_20 eq hr15_20 + 1.
     goto skipit.
try24:
  if hrs gt 24 then days.
     let hr20_24 eq hr20_24 + 1.
     goto skipit.
Days:
  let hr24 eq hr24 + 1.
skipit:
section heading.
section print.
section totals.
section final.
 print hr1 hr2 hr3 hr4 hr5 hr6 hr7 hr8 hr9 hr10 hr11 hr12 -
       hr12_15 hr15_20 hr20_24 hr24 FORMAT
         /' 0 -  1 hour  ' I5
         /' 1 -  2 hour  ' I5
         /' 2 -  3 hour  ' I5
         /' 3 -  4 hour  ' I5
         /' 4 -  5 hour  ' I5
         /' 5 -  6 hour  ' I5
         /' 6 -  7 hour  ' I5
         /' 7 -  8 hour  ' I5
         /' 8 -  9 hour  ' I5
         /' 9 - 10 hour  ' I5
         /'10 - 11 hour  ' I5
         /'11 - 12 hour  ' I5
         /'12 - 15 hour  ' I5
         /'15 - 20 hour  ' I5
         /'20 - 24 hour  ' I5
         /'   > 24 hours ' I5  /
 END.
report end.
