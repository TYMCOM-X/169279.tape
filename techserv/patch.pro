                           PATCH FILE PROCEDURES


    PATCH FILE INFORMATION IS A DOCUMENT THAT WILL USUALLY COME FROM
    ONTYME. IF IT ORIGINATES FROM AN STS PERSON, IT DOES NOT NEED
    MANAGEMENT APPROVAL. IF APPROVAL IS NEEDED FORWARD TO THE STS
    MANAGER RESPONSIBLE FOR THE PRODUCT INVOLVED. UPON RECEIVING
    PATCH FILE INFORMATION YOU MUST ENTER IT INTO THE PATCH FILE
    DATABASE:

    1.  Use the IBM P.C. 

        C:\>  CD RBASE                  <you have to be at the DOS prompt
           >  RBASE                      to get into rbase. if you need to
                                         get to DOS just do a CD.. >

    2.  Menu - Patch File Database

              1 (CR) maintain patch file data    
                                      

    3.  Menu - Maintain Patch File Data

              1 (CR) load                        
                                         
    
    ON THE PATCH FILE DOCUMENT THE FOLLOWING FIELDS THAT ARE A LITTLE
    DIFFERENT THAN WHAT YOU WILL SEE IN THE DATABASE. IN THE DATABASE
    THE FIELDS LOOK LIKE THIS:

        A. PATCH FILE NAME   :XOMSUL.403  
                             (input only the file name from the document)

        b. (DIR:SYS)ORIGINAL NAME: (XCOMPAT)XOMSUL.403
                             (the stuff in parenthisis is the directory name)
                
    IF ON THE PATCH FILE DOCUMENT HAS NO ENTRY AFTER (ORIGINAL FILE
    NAME) JUST USE THE (DIR:SYS)FILENAME GIVEN.

        C. REASON NSR/PIR:

                             (if this line is blank on the document
                              look at the discription on the patch. if
                              the patch was not related to a problem
                              enter "special" in the database. if it is 
                              for an nsr or pir the person who wrote the
                              patch should have included the number)


    4.  WHEN YOUR DONE ADDING THE INFORMATION OR EDITING IN THE DATABASE
        HIT THE ESC KEY. IT WILL GIVE YOU A CHOICE TO ADD, REUSE, EDIT OR
        QUIT (YOU WILL SEE THIS IN THE UPPER LEFT CORNER). USE THE TAB KEY
        TO YOUR CHOICE OR TYPE A,R,E,Q, AND A CARRIAGE RETURN, IT DOES THE
        SAME THING. IF YOU ADDED A NEW PATCH CHOOSE ADD IF YOU JUST EDITED
        AN EXISTING ONE CHOOSE EDIT.

    5.  Menu - Maintain Patch File Data
        
               6 (CR) exit

        Menu - Patch File Database

               3 (CR) quit         

        
        C:\RBASE> CD..                      <at the rbase prompt do a cd..
                                             to change dir>

    6.  FILE THE HARDCOPY OF THE PATCH FILE IN THE PATCH FILE INFO.
        FOLDER.


                        RUNNING THE PATCH FILE REPORT (EVERY TWO WEEKS)
                        ______________________________________________ 




    C:\> CD RBASE
    C:\>RBASE> RBASE

    Menu - Patch File Database

           2 (cr) Print Patch File Reports

    Menu - Print Patch File Reports

           3 (cr) Generate Reports On Disk

    THE PC WILL TELL YOU

     create disk file report.p01
     create disk file report.p02
     wait...............................

     WHEN THE PATCH FILE MENU APPEARS AGAIN THE PC IS DONE

     Menu - Print Patch File Reports
    
            4 (cr) exit

     Menu - Patch File Database
 
            3 (cr) quit

     C:\RBASE> TYMCOMM
     XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

     control "A", then control "RDX"

     Please Log In: TECHREF:38; PASSWORD
       
     - DIR REPORT.*                       <do a dir at the prompt to look at
                                           the files>

      THERE SHOULD BE 4 REPORTS: REPORT.B01, REPORT.B02, REPORT.P01 AND
      REPORT.P02. THE BO'S ARE THE BACK UPS THAT WERE GENERATED THE LAST
      TIME THE REPORTS WERE UPLOADED.

     - PCOM PATCH.CMD                     <this runs a command file
                                           to delete the bo's and rename
                                           the current po's to bo's>

     - TTY CLASS VT100

     - PEAK REPORT.P01                    <this creates a file>

     - ALT "U"                            

     THE PC WILL ASK YOU TO ENTER THE PC FILE ID TO SEND:

     REPORT.PO1                           <this is the first report you want 
                                           to send>

     THE PC WILL SCROLL OVER THE REPORT THIS ONE TAKES ABOUT +/- 30 MIN.
     IT WILL SAY TRANSFER COMPLETE WHEN DONE.

     CONTROL "XF"                         <type a control xf to save the file
                                           you just sent>
  
     DO THE SAME FOR THE REPORT.P02
     -PEAK REPORT.P02
     -ALT "U"

     THE FILE TO SEND IS: REPORT.P02

     THIS REPORT WILL TAKE ABOUT 2 HOURS.

     A NEW COPY OF THESE REPORTS CAN BE PULLED OUT OF TECHREF 38

     -TYPE REPORT.P01                     <set paper to the top of the page>

     -TYPE REPORT.P02                       ""         """

     NO NEED TO SEPERATE THEM
       
    
     

           

      