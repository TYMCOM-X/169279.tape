--------------------------------------------------------------
 
  PROCEDURE FOR PRINTING LISTINGS FROM SYSTEM 26 VIA AN M8000
 
--------------------------------------------------------------
 

- On FSG M8000 log on to account TYM, password TYM.
  
   This will log you onto the m800 and take you inton its network
  facility. You should be presented with the 'please log in prompt'.
  (Sometimes it loses part of the text but it doesn't matter)
 
- Logon to which ever system you want as normal.
 
- Change the form width at the terminal for printer width - ie. TTY WIDTH 132
 
- Hit 'Control I' which will enable the hard copy facility. You should see
  a reverse video indicator on the bottom line. Everything that is displayed
  on the terminal will now be written to a spool file on the M8000 disc.
 
- Display the desired file to the screen - ie. ' TYP filename'
 
- When the display has finished logoff Dec system and then key 'Control O'.
 
- At the exit menu enter '3'
 
- At the network menu hit function key F3 to exit back to M8000 system
  prompt. (:)
 
- You now need to find out the job number for the spool file you have just
  created. 