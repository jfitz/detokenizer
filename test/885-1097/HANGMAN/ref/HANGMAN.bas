10 :REMARK \t\tHANGMAN.BAS\tDEMO VERSION\t Dale Grundon
20 CLEAR 1000:WIDTH 255:DIM A$(20),A1$(20)
30 E$=CHR$(27):E1$=E$+"E":F$=E$+"F":G$=E$+"G":P$=E$+"p":Q$=E$+"q":Y$=E$+"Y"
40 J$=E$+"J":K$=E$+"K":X1$=E$+"x1":X5$=E$+"x5":Y5$=E$+"y5":Q1$=CHR$(34)
50 Q1$=CHR$(34):T$=CHR$(64):U$=CHR$(95)
60 PRINT E1$X5$"   This is the familiar game of `HANGMAN' that you used to play"
70 PRINT Y$Q1$" when you were in Grade School. Your opponent will choose a word"
80 PRINT Y$"$ and draw spaces representing the letters that make up the word."
90 PRINT Y$"& You must guess the letters, but each incorrect one will add a"
100 PRINT Y$"( new part of body to the HANGMAN's scaffold. So you have to be"
110 PRINT Y$"* sharp; otherwise . . . . . it's been good to know you!"
120 PRINT Y$"-#There are three skill levels of play, with `1' being easiest."
130 PRINT Y$"/ You may change the level after each game. <Hit RETURN>";:N$=INPUT$(1)
140 PRINT X1$E1$Y$"8(\aWhat skill level do you want? (1,2, or 3) "Y5$;
150 S$=INPUT$(1):IF VAL(S$)<1 OR VAL(S$)>3 THEN 140
160 PRINT X1$E1$X5$;:GOSUB 450:C=2:T=0:W=0:D=0:L$=""
170 RESTORE:FOR X=1 TO INT(50*RND(1))+1:READ O1$,O2$,O3$:IF O1$="000" THEN 170
180 NEXT X:IF S$="1" THEN B$=O1$
190 IF S$="2" THEN B$=O2$
200 IF S$="3" THEN B$=O3$
210 S=LEN(B$):FOR X=1 TO S:A1$(X)="i":A$(X)=MID$(B$,X,1):NEXT X
220 PRINT E$"k"F$;:FOR X=1 TO S:PRINT A1$(X)" ";:NEXT X:PRINT
230 IF C=0 THEN PRINT Y$"0"CHR$(96+W)L$;
240 PRINT G$;:C=0:IF T=S THEN 410
250 IF D=1 THEN RETURN 
260 PRINT Y$"84"P$" Guess a letter\a - "Q$" "Y5$;:L$=INPUT$(1):PRINT X5$L$
270 IF (ASC(L$)<65 OR ASC(L$)>90) AND (ASC(L$)<97 OR ASC(L$)>122) THEN 260
280 IF ASC(L$)>90 THEN L$=CHR$(ASC(L$)-32)
290 PRINT E$"l";:FOR X=1 TO S:IF L$=A1$(X) THEN PRINT "\a ":GOTO 260
300 IF L$=A$(X) THEN A1$(X)=A$(X):C=1:T=T+1
310 NEXT X:IF C=1 THEN 220
320 W=W+1:ON W GOTO 540,550,560,570,580,590
330 D=1:FOR X=1 TO S:A1$(X)=A$(X):NEXT X:GOSUB 220
340 PRINT F$Y$"%Fww r"Y$"%VTHE GOVERNOR HAS NOT"Y$"&VSENT YOUR PARDON!"
350 FOR X=1 TO 19:PRINT Y$"2"CHR$(60+X)" ";:NEXT X:PRINT " "
360 PRINT G$Y5$Y$"8"Q1$
370 PRINT "To play again choose a skill level\a (1,2 or 3) <END> ";:N$=INPUT$(1)
380 PRINT X5$E$"y1"E$"y3"Y$"  "E1$;
390 IF N$="1" OR N$="2" OR N$="3" THEN S$=N$:GOTO 160
400 PRINT Y$"  "Y5$:RUN"MENU":END
410 PRINT F$Y$Q1$"Fx "Y$"#Gx":IF W=0 THEN 440
420 PRINT Y$"&Fed";:IF W<5 THEN 440
430 PRINT Y$"1<}"STRING$(20,"p")"|"
440 PRINT Y$"%NYOUR\a LAWYER USED THE\a RIGHT"Y$"&OLETTERS AND GOT YOU OFF!":GOTO360
450 X$=Y$+"9%}i|":V$="x x":W$="y y"
460 PRINT E$"x3"Y$"      "F$STRING$(36,"{"):PRINT X$"   "V$Y$"!F"U$"r"
470 PRINT X$"  "V$:PRINT X$" "V$:PRINT X$V$:PRINT X$" x":PRINT X$"x"
480 FOR X=1 TO 6:PRINT X$:NEXT X
490 PRINT X$"y":PRINT X$" y":PRINT X$W$:PRINT X$" "W$:PRINT X$"  "W$
500 PRINT "  "STRING$(27,"p")STRING$(20,"z")STRING$(11,"p")
510 PRINT Y$Q1$"G|"Y$"#G|"Y$"$Exzzy"Y$"%E|  }"Y$"&Ey{{x"
520 PRINT Y$"0RLETTERS USED -"Y$"54WORD h "E$"j"G$;:RETURN
530 PRINT Y$"54WORD h "E$"j"G$;:RETURN
540 PRINT F$Y$"$Eiiii"Y$"%D"U$" ^^ r"Y$"&Eyaax"Y$"'F``"G$:GOTO 220
550 PRINT F$Y$"(Dzizziz"Y$")D|i  i}"Y$"*D|i  i}"Y$"+Dyi{{ix"G$:GOTO 220
560 PRINT F$Y$"(Cx"Y$")Bxx"Y$"*Axx"Y$"+A"U$"*"G$:GOTO 220
570 PRINT F$Y$"(Jy"Y$")Jyy"Y$"*Kyy"Y$"+K*r"G$:GOTO 220
580 PRINT F$Y$",D|"Y$"-Cx  x"Y$".C| }"Y$"/C| }"Y$"0Cuuu"G$:GOTO 220
590 PRINT F$Y$",I}"Y$"-Gy  y"Y$".H| }"Y$"/H| }"Y$"0Huuu"G$:GOTO 330
600 DATA PAPER,CALENDAR,SPONGE
610 DATA DOCTOR,MAGAZINE,SYMPATHETIC
620 DATA BOOK,TELEVISION,UNDERSTAND
630 DATA DOOR,RADIO,INCONVENIENT
640 DATA NURSE,CONDITION,PHOTOGRAPHIC
650 DATA CLOSE,PRINT,SYZYGY
660 DATA ERASE,LIBRARY,QUARTZ
670 DATA TALK,SCHOOL,ANTHROPOLOGY
680 DATA WALK,COLLEGE,MELANCHOLY
690 DATA LOOK,PRINCIPLE,MOSAIC
700 DATA TREE,RECORDER,QUAVER
710 DATA HOUSE,PAUSE,MYSTERY
720 DATA AUTO,LUNCH,ORGANIC
730 DATA TRUCK,HOUSE,QUALIFY
740 DATA SKATE,MIDDLE,MYTHOLOGICAL
750 DATA BALL,FIREPLACE,ORCHESTRATE
760 DATA MOST,ALIGNMENT,PREJUDICE
770 DATA ALWAYS,PORTABLE,PROXY
780 DATA OVER,MODIFY,QUADRANT
790 DATA UNDER,VILLAGE,PYRAMID
800 DATA BACK,CARPET,PHYCHOPATH
810 DATA LETTER,PICTURE,PRONOUNCIATION
820 DATA MAIL,EXPOSURE,ANIMOSITY
830 DATA SHIRT,SURFBOARD,VERSATILITY
840 DATA WATER,TELEPHONE,VITALIZE
850 DATA DRINK,MOUTH,KLEPTOMANIAC
860 DATA NUMBER,MULTIPLY,NYMPHOMANIA
870 DATA TRAY,DRAWER,SYNCRONIZATION
880 DATA STOP,CATIPILLAR,GYNECOLOGIST
890 DATA TALL,BOOKLET,PHILANTHROPIST
900 DATA LONG,KEYBOARD,AMBIDEXTERITY
910 DATA SHORT,MANSION,SUPERCILIOUS
920 DATA SMALL,CHRISTMAS,TRANQUILLITY
930 DATA SAVE,TRESPASS,TYRANNY
940 DATA KEYS,COMMITTEE,PSEUDONYM
950 DATA ENTER,PACIFY,EXTINGUISHER
960 DATA CROSS,PROGRAM,HETEROGENEOUS
970 DATA ACROSS,EDUCATION,SURREPTITIOUS
980 DATA MOUSE,STOVE,EXTRAVAGANT
990 DATA DUCK,MONTH,DISPROPORTIONATELY
1000 DATA MONEY,SATURDAY,ENTHUSIASTIC
1010 DATA COIN,DRUNKARD,ENCYCLOPEDIA
1020 DATA FLOOR,NORMAL,EUPHEMISM
1030 DATA BROWN,ULTIMATE,IONIZATION
1040 DATA HOLD,TEMPERATURE,JEOPARDIZE
1050 DATA STAIRS,COMMISSIONER,JODHPURS
1060 DATA BIKE,FATIGUE,LARYNX
1070 DATA TABLE,JEOPARDY,KNUCKLE
1080 DATA GRADE,LITERATURE,EFFERVERSCENT
1090 DATA TEACHER,ADMIRE,FRAUDULENT
1100 DATA GREY,TERMINAL,PARTISANSHIP
1110 DATA 000,000,000
