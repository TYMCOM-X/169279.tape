
Jim:

	Here are some of the issues to deal with this week while you
babysit for me and the resources available to address them:

  I.	Bruce Shepherd

	Dupont has a problem dumping a node with high-speed interrupts
	on a 9.6 V.24 line even though they can always load on the same
	line.  Please have Bruce simulate the test in the lab to see if
	it's a boot problem like we see with version 6 when trying to
	load with high-speed interrupts and the 7.2 V.24 on-board clocks
	or if the problem is unique to some hardware bug in their machine.
	If it is the boot code have him try with version 9 boot to verify
	it is fixed.

	LBOOT 9 for the micro still blows up on relocation but if they do
	get something running Bruce will need to perform the 3270 controller
	testing with the boot to see if it meets NIS' needs.  John Schmidt
	can help him here.

	PICO firmware testing and field support.  Bruce has 3 sets of proms
	to test with this week.  We need to verify standalone diags again with
	these and then sweep through load testing again.  If you could help him
	here that would be most helpful to you with your Beta response for
	HKSBC (who by the way is hot to see a fix for their no-poll problem).

  II.	August Cattaneo

	Auggie is still the front line for async and sync modem problems.
	Stan Eckel will be in training 3 days so Auggie will have little
	support keeping up with the tickets.  If you could scan the tickets
	occassionally to see where he stands that would probably be most
	helpful to him.  Feel free to put Phil on some tickets if it gets
	too busy!

 III.	Stan E. and Stan R.

	Both will be in training for 3 days and back on Thursday.  Stan R.
	will drop off the pager Monday for Susie to carry this week.  Richards
	has been helping Doris with her Netfusion machines and she is also
	taking off 3 days this week so that should work out fine.  She does
	have a problem logging onto a 5 digit host in our net but Sandra
	should be looking at that as she genned up the current 2007 Sup
	code.

  IV.	Alain Dazzi

	Alain will be looking at a 19.2 clocking problem for Telerate this
	week and continuing his slot programming in C.  He also is available
	to work with Ralph Stastney in Product Support should he require
	more assistance coding the Comapct XL this week.

	Alain will be taking off Friday which should be fine as both Stans
	will be back in by then.

   V.	John Schmidt

	John needs to pursue the Mercury config for the Turbo this week
	as it seems it will go to England.  He is also tracking the ECOs
	and FCOs now.  If you do have any more FCOs to release as we
	discussed please utilize John to document and propagate them.

	John can also start running the MAC IIIB with diags as it is up
	and running again.  Someone had robbed tha DMA PAL off of the board
	and Greg robbed another board to get it back up again.  As he does
	not know the diags yet someone will have to hold his hand to insure
	he makes a thorough pass.  This board should be exposed to disk and
	tape devices.

  VI.	Scott McKinsey

	Scott is working on a power supply test bed.  You may like to look
	at his logics and direct him to Mario to build it for him as he gets
	his parts.

	I also want Scott to work with Carl Baltronas and Harry Matthews to
	get diags set up on the Fremont SUN systems.  I want to have an ENGDIAG
	and BETADIAG directory setup like we have on the PDP-10s.  Perhps to
	test the diags (as they have to be reassembled on the SUNs) Scott might
	assist John with the MAC IIIB testing.  After running tests off of the
	10s they could reload and verify from the SUNs.

 VII.	Phil Nelson

	Phil needs to smooth out his ATC script file and run it on the ATCs
	from CSC.  Nils Clausen will be looking for direction from Phil for
	ATC+ testing this week.

	He also needs to work with Susie with the script and make sure she
	has a usable tool for PAD testing by the end of the week.

VIII.	B.S.Bunyan

	Susie is putting together a PICO for Tom Beckly to do 3270 BSC
	Q.A. on which lends itself nicely to the firmware Q.A. we need
	to perform.

	She also needs to send out a PSM bucket to Tom Brosnan in the field
	by the end of the week and we need her to keep her sio-async
	test results alive as best we can.  When we get a break between
	fire-storms her test results need to be turned over to product
	support with an EAR for the PSM bucket.

	Her heaviest task is the MICOM PAD testing thsi week part of which
	she will do with Phil.  You might be able to turn her onto some
	of the IDACOM scripts we had during the LTD.

	
Don will be out of the office from Tuesday through Friday.  There will be a
meeting that Ron is attending on Thursday this week that Bruce or yourself
should also attend.  Please see Ron and coordinate it as you like.  I'll be
at Grizzly Creek near Carlotta all week and I do check the message board
when I go by the ranger station.  Should you need to discuss anything leave
a message at 7777-3683.  