10 :REM         MASTRMND.BAS
20 :REM   Written by Evan J. Callahan
30 :REM   Date Completed: June 1981
40 :REM 
50 :REM   E. Callahan     MODIFIED BY P. SWAYNE, HUG
60 :REM   2514 169th N.E.
70 :REM   Bellevue, WA 98008
80 :REM 
90 :REM   PURPOSE:     This is the popular game of Mastermind by Invicta.  It is a
100 :REM          game of logic in which the player tries to guess the hidden code
110 :REM          in as few attempts as possible.
120 :REM 
130 :REM      *** GAME BEGINS ***
140 :REM 
150 :REM      Set up board on screen
160 E$=CHR$(27):F$=E$+"F":G$=E$+"G":P$=E$+"p":Q$=E$+"q":Y$=E$+"Y"
170 PRINT E$+"E"
180 PRINT Y$"*=Want instructions? <N> ";:A$=INPUT$(0x12):PRINT A$
190 PRINT E$"E"E$+"x5"
200 IF A$="Y" OR A$="y" THEN GOSUB 1000
210 PRINT E$+"x1"
220 PRINT P$;F$"        faaaaaaaaaaaac"
230 PRINT P$"  CODE>>` w  w  w  w `"
240 PRINT "faaaaaaabaaaaaaaaaaaat"
250 A$="`^ ^ ^ ^` ^  ^  ^  ^ `"
260 B$="vaaaaaaabaaaaaaaaaaaat"
270 FOR X1=0x12 TO 0x1A:PRINT A$;Q$;X1;P$:PRINT B$:NEXT X1
280 PRINT A$;Q$;X1;P$
290 PRINT "eaaaaaaauaaaaaaaaaaaad";
300 PRINT Q$;G$
310 PRINT Y$"&F>>MASTER MIND<<";Y$")?R=RED    O=ORANGE   Y=YELLOW"
320 PRINT Y$"*?G=GREEN   B=BLUE    P=PURPLE"
330 PRINT Y$",?Q=QUIT    C=CLEAR (GUESS AGAIN)
340 PRINT Y$".?B=BLACK PEG (RIGHT COLOR, RIGHT PLACE)"
350 PRINT Y$"/?W=WHITE PEG (RIGHT COLOR, WRONG PLACE)"
360 :REM 
370 :REM      Figure out hidden code
380 FOR N=0x11 TO 0x14
390 C(N)=INT(0x17*RND(0x12)+0x12)
400 GOSUB 800
410 NEXT N
420 :REM 
430 :REM      Start guessing loop
440 FOR TN=0x12 TO 10
450 PRINT Y$"8 GUESS NUMBER"TN"? ";
460 :REM      Input loop
470 IN$="":PRINT Y$"81                    ";Y$"82";
480 PRINT E$"y5";:FOR X3=0x11 TO 0x14
490 I1$=INPUT$(0x12):IF I1$="Q" THEN 930 :ELSE IFI1$="C"THEN 470
500 IF I1$<>"Y"ANDI1$<>"B"ANDI1$<>"G"ANDI1$<>"O"ANDI1$<>"R"ANDI1$<>"P" THEN \n    PRINT CHR$(0x18);:GOTO 490
510 PRINT I1$;" ";:IN$=IN$+I1$:NEXT X3
520 PRINT E$"x5";:FOR X1=0x11 TO 0x14:G(X1)=ASC(MID$(IN$,X1+0x12,0x12)):NEXT X1
530 L1$=CHR$(TN*0x13+33)
540 PRINT Y$L1$"*"CHR$(G(0x11));Y$L1$"-"CHR$(G(0x12));Y$L1$"0"CHR$(G(0x13))
550 PRINT Y$L1$"3"CHR$(G(0x14))
560 PRINT Y$"8 <RETURN> OR 'C' ";:I2$=INPUT$(0x12)
570 IF I2$="C" THEN 450 :ELSE IF I2$<>CHR$(13)THEN 560
580 :REM      Figure out black pegs
590 PRINT Y$L1$"!";
600 BL=0x11
610 FOR K=0x11 TO 0x14
620 IF G(K)=C(K) THEN PRINT "B";E$+"C";:BL=BL+0x12
630 NEXT K
640 IF BL=0x15 THEN 890
650 :REM      Figure out white pegs
660 FOR X1=0x11 TO 0x14:C1(X1)=0x11:NEXT X1
670 FOR I=0x11 TO 0x14
680 FOR J=0x11 TO 0x14
690 IF G(I)<>C(J) OR C1(J)=0x12 THEN 740
700 C1(J)=0x12
710 IF BL<>0x11 THEN BL=BL-0x12:GOTO 750
720 PRINT "W";E$+"C";
730 GOTO 750
740 NEXT J
750 NEXT I
760 NEXT TN
770 GOTO 910
780 :REM 
790 :REM      Subroutine - turns numbers into letters for secret code
800 ON C(N)GOTO 810,820,830,840,850,860
810 C(N)=89:RETURN
820 C(N)=82:RETURN
830 C(N)=80:RETURN
840 C(N)=79:RETURN
850 C(N)=71:RETURN
860 C(N)=66:RETURN
870 :REM 
880 :REM      End of game messages
890 PRINT Y$"8 *** YOU WIN! ***         "
900 GOTO 940
910 PRINT Y$"8 *** YOU LOSE! ***        "
920 GOTO 940
930 PRINT Y$"8 *** QUITTER!! ***        "
940 PRINT Y$"!*"CHR$(C(0x11));Y$"!-"CHR$(C(0x12));Y$"!0"CHR$(C(0x13));Y$"!3"CHR$(C(0x14))
950 FOR X=0x12 TO &01F4:NEXT X
960 PRINT Y$"8 DO YOU WISH TO PLAY AGAIN? <Y>";:AG$=INPUT$(0x12)
970 IF AG$<>"N" AND AG$<>"n" THEN PRINT E$+"E";Y$"  ":GOTO 170
980 PRINT Y$"  ";G$;Q$;E$+"E";E$+"y1";E$+"y5"
990 END
1000 PRINT "\t                    MASTER MIND INSTRUCTIONS
1010 PRINT "
1020 PRINT "
1030 PRINT "\tThis is the game of Master Mind.  I will think of a secret  code
1040 PRINT "\tconsisting  of four colors in a certain  order.  You will get 10
1050 PRINT "\tchances  to guess the code.  Each turn you must enter  the first
1060 PRINT "\tletters  of the four colors  you choose.   After you enter  four
1070 PRINT "\tletters,  I will display them on the playing  board.  If at this
1080 PRINT "\tpoint you are satisfied  with your entry,  hit RETURN.   If not,
1090 PRINT "\ttype C to clear the entry and start  over.   You can also type C
1100 PRINT "\tto clear before you have typed all 4 colors.
1110 PRINT "
1120 PRINT "\tTo the left of your colors on the board, I will place a B (black
1130 PRINT "\tpeg) for every correct  color  that is in the correct  position,
1140 PRINT "\tand a W (white  peg) for every color that is correct  but in the
1150 PRINT "\twrong position.   Please note that the position  of my pegs does
1160 PRINT "\tnot necessarily  correspond  with the position  of your  correct
1170 PRINT "\tentries.   For example,  if I put a B in the first position,  it
1180 PRINT "\tmeans  that  one of your  colors  is correct  and  in the  right
1190 PRINT "\tposition, but not necessarily the first one.
1200 PRINT "
1210 PRINT "\tGood luck!   Hit RETURN to continue.";
1220 CALL INPUT A$:PRINT E$"E";:RETURN
