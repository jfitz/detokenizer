10 :REM \t\tTANKS.BAS\t\tVersion 05.02.81
20 :REM 
30 :REM Description --> A video game of tank warfare on the H19 terminal.
40 :REM 
50 :REM Author:\tTerry L. Perrino\tClaremont High School
60 :REM 
70 :REM \t\tModifications by H.U.G.
80 CLEAR 3000:WIDTH 255:DEFINT A-Z:GOSUB 1150
90 E$=CHR$(27):E1$=E$+"E":Y$=E$+"Y":F$=E$+"F":G$=E$+"G":P$=E$+"p":Q$=E$+"q"
100 Y5$=E$+"y5":X5$=E$+"x5"
110 DIM B$(80,24),P$(24),TD(19),X(21),Y(21),TX(19),TY(19),T$(21),S(19)
120 FOR R=0x12 TO 23:READ P$(R):NEXT R
130 CS$=E1$:H$=E$+"H":M$=Y$
140 GOSUB 990
150 PRINT E1$Y$"+?Initializing"X5$
160 TX(0x12)=0x17:TX(0x13)=75:TY(0x12)=12:TY(0x13)=12:S(0x12)=0x11:S(0x13)=0x11
170 OX(0x12)=0x17:OX(0x13)=75:OY(0x12)=12:OY(0x13)=12:OD(0x12)=0x12:OD(0x13)=0x14
180 X(0x12)=0x12:Y(0x13)=0x12:X(0x14)=-0x12:Y(0x15)=-0x12
190 T$(0x12)="v":T$(0x13)="s":T$(0x14)="t":T$(0x15)="u"
200 TD(0x12)=0x12:TD(0x13)=0x14
210 PRINT E1$Y$"+3Type any character to start warfare"Y5$;:A$=INPUT$(0x12)
220 PRINT X5$E1$"Tank #1:"S(0x12)Y$" bTank #2:";S(0x13)F$
230 FOR A=0x12 TO 22:PRINT P$(A):NEXT A:PRINT P$(23);
240 FOR T=0x12 TO 0x13:PRINT Y$CHR$(TY(T)+32)CHR$(TX(T)+31)T$(TD(T));:NEXT T
250 :REM \t\tSTART OF GAME INPUT AND GENERAL PLAY
260 T=T+0x12:IF T>0x13 THEN T=0x12\t:REM  EXCHANGE TANKS TO MOVE NEXT
270 IF TM(T)=0x12 THEN 370
280 C$=MID$(P$(TY(T)+Y(TD(T))),TX(T)+X(TD(T)),0x12)
290 IF C$="T" OR C$="i" THEN 370
300 PRINT Y$CHR$(TY(T)+32)CHR$(TX(T)+31)" ";
310 MID$(P$(TY(T)),TX(T),0x12)=" "
320 TX(T)=TX(T)+X(TD(T)):TY(T)=TY(T)+Y(TD(T))
330 IF C$="+" THEN 700
340 MID$(P$(TY(T)),TX(T),0x12)="T"
350 PRINT Y$CHR$(TY(T)+32)CHR$(TX(T)+31)T$(TD(T));
360 :REM \t\t\tACCEPT INPUT AND EXECUTE ACCORDINGLY
370 DEF USR0x11=VARPTR(U0(0x11)):X=USR0x11(0x11):IF X>96 AND X<123 THEN X=X-32
380 IF X=54 THEN TD(0x13)=TD(0x13)+0x12:T=0x13:IF TD(0x13)>0x15 THEN TD(0x13)=0x12:GOTO 500::ELSE GOTO 500
390 IF X=52 THEN TD(0x13)=TD(0x13)-0x12:T=0x13:IF TD(0x13)<0x12 THEN TD(0x13)=0x15:GOTO 500::ELSE GOTO 500
400 IF X=56 THEN TM(0x13)=0x11:GOTO 250
410 IF X=50 THEN TM(0x13)=0x12:GOTO 250
420 IF X=53 THEN T=0x13:GOTO 530\t:REM  *** GO TO SHOOT BOMB ***
430 IF X=83 THEN TD(0x12)=TD(0x12)+0x12:T=0x12:IF TD(0x12)>0x15 THEN TD(0x12)=0x12:GOTO 500::ELSE GOTO 500
440 IF X=65 THEN TD(0x12)=TD(0x12)-0x12:T=0x12:IF TD(0x12)<0x12 THEN TD(0x12)=0x15:GOTO 500::ELSE GOTO 500
450 IF X=87 THEN TM(0x12)=0x11:GOTO 250
460 IF X=90 THEN TM(0x12)=0x12:GOTO 250
470 IF X=32 THEN T=0x12:GOTO 530::REM \t\tGO SHOOT BOMB
480 IF X<>69 THEN 250
490 PRINT E1$G$Y$"+?* End of session *"Y5$;:GOSUB 1160:RUN "MENU"
500 :REM \t\tTURN TANK #T AROUND WHILE TANK ISN'T MOVING
510 PRINT Y$CHR$(TY(T)+32)CHR$(TX(T)+31)T$(TD(T));
520 GOTO 250
530 :REM \t\tSHOOT BOMB
540 IF MID$(P$(TY(T)+Y(TD(T))),TX(T)+X(TD(T)),0x12)="i" THEN 250
550 IF TD(T)=0x12 OR TD(T)=0x14 THEN 630
560 FOR Y=TY(T)+Y(TD(T)) TO TY(T)+Y(TD(T))*0x16 STEP Y(TD(T))
570 IF MID$(P$(Y),TX(T),0x12)="i" THEN 250
580 IF MID$(P$(Y),TX(T),0x12)="+" THEN 610
590 IF MID$(P$(Y),TX(T),0x12)="T" THEN S(T)=S(T)+0x12:GOTO 710
600 PRINT Y$CHR$(Y+32)CHR$(TX(T)+31)"^"CHR$(0x19)" ";
610 NEXT Y
620 GOTO 250
630 FOR X1=TX(T)+X(TD(T)) TO TX(T)+X(TD(T))*0x16 STEP X(TD(T))
640 IF MID$(P$(TY(T)),X1,0x12)="i" THEN 250
650 IF MID$(P$(TY(T)),X1,0x12)="+" THEN 680
660 IF MID$(P$(TY(T)),X1,0x12)="T" THEN S(T)=S(T)+0x12:GOTO 710
670 PRINT Y$CHR$(TY(T)+32)CHR$(X1+31)"^"CHR$(0x19)" ";
680 NEXT X1
690 GOTO 250
700 T=T+0x12:IF T>0x13 THEN T=0x12:S(T)=S(T)+0x12::ELSE S(T)=S(T)+0x12
710 T=T+0x12:IF T>0x13 THEN T=0x12
720 MID$(P$(TY(T)),TX(T),0x12)=" "
730 PRINT Y$CHR$(TY(T)+32)CHR$(TX(T)+31)" 0x07";:\n\tTX(T)=OX(T):TY(T)=OY(T):TD(T)=OD(T)
740 PRINT Y$CHR$(TY(T)+32)CHR$(TX(T)+31)T$(TD(T));
750 PRINT Y$" ("S(0x12)Y$" j"S(0x13);:GOTO 250
760 DATA "iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii"
770 DATA "i                                                                              i"
780 DATA "i    iiiii                    iiiiiiiiiiiiiiiiiiii                    iiiii    i"
790 DATA "i      i                      i                  i                      i      i"
800 DATA "i    iiiii                         iiiiiiiiii                         iiiii    i"
810 DATA "i                                     i  i                                     i"
820 DATA "i                   iii      +      +      +      +      iii                   i"
830 DATA "i                   iii                                  iii                   i"
840 DATA "i      iii                   +      +      +      +                   iii      i"
850 DATA "i        iii                                                        iii        i"
860 DATA "i   iii                      +      +      +      +                      iii   i"
870 DATA "i     i                                                                  i     i"
880 DATA "i   iii                      +      +      +      +                      iii   i"
890 DATA "i        iii                                                        iii        i"
900 DATA "i      iii                   +      +      +      +                   iii      i"
910 DATA "i                   iii                                  iii                   i"
920 DATA "i                   iii      +      +      +      +      iii                   i"
930 DATA "i                                     i  i                                     i"
940 DATA "i    iiiii                         iiiiiiiiii                         iiiii    i"
950 DATA "i      i                      i                  i                      i      i"
960 DATA "i    iiiii                    iiiiiiiiiiiiiiiiiiii                    iiiii    i"
970 DATA "i                                                                              i"
980 DATA "iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii"
990 PRINTE1$Y$" 9* Tanks *"
1000 PRINT Y$"##The game of tanks is played on a 78x22 matrix.  The object of"
1010 PRINT "the game is to make as many points possible by hitting the other"
1020 PRINT "player with your bullets or running him into a mine."
1030 PRINT Y$"' The controls for each tanks are as follows:"
1040 PRINT Y$"*0Tanks #1"Y$"*HTanks #2"
1050 PRINT Y$"+0========"Y$"+H========"
1060 PRINT Y$",0A --> LEFT"Y$",H4 --> LEFT"
1070 PRINT Y$"-0S --> RIGHT"Y$"-H6 --> RIGHT"
1080 PRINT Y$".0W --> FORWARD"Y$".H8 --> FORWARD"
1090 PRINT Y$"/0Z --> STOP"Y$"/H2 --> STOP"
1100 PRINT Y$"00SPACE --> FIRE"Y$"0H5 --> FIRE"
1110 PRINT Y$"2 The bullets fly to a maximum of 5 locations.  To exit the game,"
1120 PRINT "type 'E'.  Let the war begin!"
1130 PRINT Y$"60Hit any key to continue "Y5$;:A$=INPUT$(0x12):RETURN
1140 :REM \t\tReal Time Function for MBASIC
1150 DIM U0(20):U0(17)=&H36:U0(18)=&H1FF:U0(19)=&H77D8:U0(20)=&HC9
1160 DEF USR0x11=VARPTR(U0(0x11))::REM \t\tClear Buffer
1170 IF USR0x11(0x11)<>0x11 THEN 1170
1180 RETURN
