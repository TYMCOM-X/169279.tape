echo "*******************************************************"
echo "**** If your gateway username is not -g n please   ****"
echo "**** modify this file (modify.cmd) to make it work ****"
echo "*******************************************************"
echo "COPY the .file FROM PDP"
echo "**************************"
/usr/tym/netcopy -g tym 26:sfbnet.fil /usr/cmfsys/user/cmfsys/.file
echo "COPY SYSGEN FILES FROM PDP"
echo "**************************"
/usr/tym/netcopy -g tym 
echo "MODIFYING THE COMMAND FILES..."
echo "******************************"
cc modify.c
ls bs????.c?? > command.lst
mkdir t
a.out
echo "    ALL COMMAND FILES ARE MODIFIED IN DIRECTORY t/     "  
echo "*******************************************************"
echo "NOW copy all modified command files back to test directory"
echo "by issuing cp t/*.c* ."
echo "*******************************************************"
cp t/*.c* .
rm -rf t
echo "*******************************************************"
echo "NOW copy the sysgen files to the partition directories"
echo "by using the partition information provided by customer"
echo "*******************************************************"
partin.net
echo "*******************************************************"
echo "NOW you can login to CMF by issuing cmfsh and start to "
echo "run CONVERSION after ADD release has been excuted"
echo "*******************************************************"
    