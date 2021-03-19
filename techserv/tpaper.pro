    
                    STEPS FOR SETTING TPAPER PROGRAM ON THE IBM

     ON THE IBM PC:
     The TPAPER program is designed to run at 7:00 am and 12:47pm everyday.
     If the program is interrupted for any reason it needs t be set up 
     again. If you need to stop the program to use the p.c:

   1. HIT THE ESC KEY TWICE THEN AT THE COMMAND TYPE:
      COMMAND?  QUIT                  <issue a carriage return>

      QUICKLY HIT THE CONTROL KEY AND BREAK KEY TOGETHER. YOU WILL GET THIS
      RESPONSE:
      TERMINATE BATCH JOB (Y/N)? Y

      c:\XTALK>                       <you will get this prompt back>

   2. AT THE XTALK PROMPT YOU CAN JUST START THE BAT FILE RUNNING.
      IF YOU WANT TO RUN THE PROGRAM ONLY ONCE AFTER 7:00 OR AFTER
      12:47. USE THE FOLLOWING STEP:

      c:\XTALK>TPAPER.BAT             <you would use the tpaper.bat file>
      IF YOU HAVE THE DOS PROMPT:

      c:\>CD XTALK                    <you have to change directories before
                                       you start your bat file>

   3. IF IT IS AFTER 1:00 PM AND YOU WANT TO SET THE PROGRAM TO RUN AT
      7:00 AM THE NEXT MORNING, YOU HAVE TO USE THE TPAPER1.BAT

      C:\XTALK> TPAPER1.BAT           <at the xtalk prompt type in the bat 
                                       file>

      AT 7:00 THE PROGRAM WILL RUN. AT THE BOTTON OF THE SCREEN YOU WILL
      SEE WAITING FOR 12:47. THIS MEANS IF THERE ARE NO INTERRUPTIONS
      THE PROGRAM WILL AGAIN AT 12:47. THE CYCLE WILL KEEP REPEATING.

   4. IF IT IS BETWEEN 7:00 AM AND 12:30 PM AND YOU WANT TO SET THE PROGRAM
      TO START RUNNING AT 12:47, USE THE TPAPER2.BAT.

      C:\XTALK> TPAPER2.BAT          
      
      THE IBM SHOULD BE TURNED OFF ON FRIDAYS AFTER 1:00.
      THIS MEANS THAT ON MONDAY MORNING YOU CAN JUST RUN THE PROGRAM
      ONCE (TPAPER.BAT) AND THEN SET IT UP TO RUN AUTOMATICALLY IF
      YOU DONT HAVE TO USE THE P.C. FOR ANYTHING ELSE.
******************************************************************************
   5. TO GET A PLEASE LOG IN ON THE PC YOU HAVE TO USE THE COMMUNICATIONS
      SOFTWARE CALLED TYMCOMM.

      C:\> TYMCOMM                    <at the dos prompt type tymcomm>
           XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
           DO A CONTROL (A)
           please log in:     
(THIS FILE IS LOCATED IN (TECHSERV:56) FILE NAME TPAPER.PRO



      

