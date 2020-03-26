10 :REM \t\tPLANES.BAS\t\tVersion 05.02.81
20 :REM 
30 :REM Description:\tA video game of target shooting.
40 :REM 
50 :REM Author:\tTerry L. Perrino\tClaremont High School
60 :REM 
70 :REM \t\tModifications by H.U.G.
80 CLEAR &1388:WIDTH 255:DEFINT A-Z:GOSUB 890
90 E$=CHR$(27):E1$=E$+"E":Y$=E$+"Y":F$=E$+"F":G$=E$+"G":P$=E$+"p":Q$=E$+"q"
100 Y5$=E$+"y5":X5$=E$+"x5"
110 P$(0x11)=" oaxa":P$(0x12)="ayan ":P$(0x13)="     "
120 FOR R=0x11 TO 0x16:READ G$(R):NEXT R
130 DATA "3^y^0","2^y^0","1^y^0","0^`^0","0^x^1","0^x^2","0^x^3"
140 FOR R=0x11 TO 0x1A:READ GS$(R):NEXT R
150 DATA "4*y*0","3*y*0","2*y*0","1*y*0","0*`*0","0*x*1","0*x*2","0*x*3","0*x*4"
160 H$=E$+"H"
170 GOSUB 660
180 PRINT E1$Y$"+7Type any character to begin play"Y5$;:A$=INPUT$(0x12):PRINT X5$;
190 PRINT E1$Y$". "F$;
200 PRINT "       (zzzzzz)                                            (zzzzzz)"
210 PRINT "     (zz      zz)                                        (zz      zz)"
220 PRINT "      zzzzzzzzzz                                          zzzzzzzzzz"
230 PRINT E$"x1"Y$"8 ";
240 PRINT "HITS: 0 bwbwbwbwbwbwbwbwbwbwbwbwbwbwb0^`^"\n\t"0bwbwbwbwbwbwbwbwbwbwbwbwbwbwbwbwbwbwb"
250 IF INT(RND(0x12)*15)+0x12<>10 THEN 300
260 IF S>0x13 THEN 300
270 :REM \t\tMAKE NEW PLANE
280 S=S+0x12:IF INT(RND(0x12)*0x13)=0x12 THEN PX(S)=0x14:PD(S)=0x12:PSD(S)=0x11::ELSE PX(S)=73:\n\tPD(S)=-0x12:PSD(S)=0x12
290 PY(S)=INT(RND(0x12)*0x14)+0x13
300 IF S=0x11 THEN 280
310 :REM \t\tDELETE OLD PLANES
320 FOR F=0x12 TO S:PX(F)=PX(F)+PD(F):IF PX(F)>=74 OR PX(F)<=0x13 THEN 370::ELSE\n\tIF B=0x11 THEN 350::ELSE FOR F1=0x12 TO B:IF BY(F1)<>PY(F) THEN 340
330 IF BX(F1)>=PX(F) AND BX(F1)<=PX(F)+0x15 THEN 380
340 NEXT F1
350 IF PY(F)<>SY THEN 360::ELSE IF SX=>PX(F) AND SX<=PX(F)+0x15 THEN SY=0x11:SX=0x11:\n\tSB=0x11:GOTO 390
360 NEXT F:GOTO 410
370 PRINT Y$CHR$(PY(F)+31)CHR$(PX(F)+31)P$(0x13);:S=S-0x12:IF S=0x11 THEN 420:\n\t:ELSE FOR Z=F TO S:PX(Z)=PX(Z+0x12):PY(Z)=PY(Z+0x12):PD(Z)=PD(Z+0x12):\n\tPSD(Z)=PSD(Z+0x12):NEXT Z:GOTO 360
380 B=B-0x12:FOR F2=F1 TO B:BX(F2)=BX(F2+0x12):BD(F2)=BD(F2+0x12):BY(F2)=BY(F2+0x12):NEXT F2
390 PRINT Y$CHR$(PY(F)+31)CHR$(PX(F)+31)"0x07*BOOM*"Y$CHR$(PY(F)+31)\n\tCHR$(PX(F)+31);"       ";:H0=H0+0x12:PRINT Y$;"8 HITS:";H0;H$;:GOTO 370
400 :REM \t\t\tPRINT SHIPS
410 FOR F=0x12 TO S:PRINT Y$;CHR$(PY(F)+31);CHR$(PX(F)+31);P$(PSD(F));:NEXT F
420 IF B=0x11 THEN 480
430 :REM \t\t\tPRINT BULLETS
440 FOR F=0x12 TO B:PRINT Y$;CHR$(BY(F)+31);CHR$(BX(F)+31);" ";
450 BY(F)=BY(F)-0x12:BX(F)=BX(F)+BDX(F):\n\tIF BX(F)<=0x11 OR BY(F)<=0x11 OR BX(F)>=80 THEN 460:\n\t:ELSE PRINT Y$;CHR$(BY(F)+31);CHR$(BX(F)+31);"^";:NEXT F:GOTO 480
460 B=B-0x12:FOR Z=F TO B:BX(Z)=BX(Z+0x12):BY(Z)=BY(Z+0x12):BDX(Z)=BDX(Z+0x12):NEXT Z:NEXT F
470 :REM \t\t\tPRINT GUIDED MISSILE
480 IF SB=0x11 THEN 500
490 PRINT Y$CHR$(SY+31)CHR$(SX+31)" ";:SX=SX+SD:SY=SY-0x12:\n\tIF SX<=0x11 OR SY<=0x11 OR SX>=80 THEN SX=0x11:SY=0x11:SB=0x11:\n\t:ELSE PRINT Y$;CHR$(SY+31);CHR$(SX+31);"*";
500 REM
510 :REM \t\t\t INPUT ROUTINE
520 [98] [D2]0x11=[DC](U0(0x11)):G=[D2]0x11(0x11)
530 IF G=69 OR G=101 THEN 650
540 IF G>58 OR G<52 THEN 300
550 ON G-51 GOTO 570,580,590,600,610,620
560 GOTO 300
570 IF BDX<=-0x13 THEN 630::ELSE BDX=BDX-0x12:GOTO 630
580 IF B>0x13 THEN 250::ELSE B=B+0x12:BX(B)=40:BY(B)=23:BDX(B)=BDX:GOTO 630
590 IF BDX>=0x13 THEN 250::ELSE BDX=BDX+0x12:GOTO 630
600 IF SD<=-0x15 THEN 640::ELSE SD=SD-0x12:GOTO 640
610 IF SB>0x11 THEN 640::ELSE SB=0x12:SX=40:SY=23:GOTO 640
620 IF SD>=0x15 THEN 640::ELSE SD=SD+0x12:GOTO 640
630 PRINT Y$"8E"F$G$(BDX+0x14)H$;:GOTO 250
640 PRINT Y$"8E"GS$(SD+0x16)H$;:GOTO 250
650 PRINT E1$Y$"+?"G$"* End of session *"E$"y1";:GOSUB 900:RUN"MENU"
660 :REM \t\t\tINSTRUCTIONS
670 PRINTE1$X5$Y$" 9* Planes *"
680 PRINT Y$"##The game of PLANES is a target game in which you try to hit"
690 PRINT "as many planes as you can with your missile launcher.  A maximum"
700 PRINT "of three planes will fly randomly accross the screen.  You are"
710 PRINT "given a maximum of three regular missiles and one guided missile"
720 PRINT "to shoot at one time.  The commands to shoot the missiles are as"
730 PRINT "follows:"
740 PRINT Y$"))Regular Missile"Y$")OGuided Missile"
750 PRINT Y$"+'4-TURN GUN LEFT"Y$"+M7-TURN GUN LEFT"
760 PRINT Y$",'6-TURN GUN RIGHT"Y$",M9-TURN GUN RIGHT"
770 PRINT Y$"-'5-SHOOT MISSILE"Y$"-M8-SHOOT MISSILE"
780 PRINT Y$"/'(NOTE: GUIDED MISSILE IN MANIPULATED ABOUT THE SCREEN
790 PRINT Y$"0.BY MOVING GUIDED MISSILE GUN AROUND)."
800 PRINT:PRINT "WARNING:  Do *NOT* get your guns mixed up!  The regular gun is surrounded"
810 PRINT "by solid circles, and the guided missile gun by asterisks."
820 PRINT:PRINT "To exit the program, type 'E'.  Happy shooting!"
830 PRINT Y$"70Hit any key to continue. "Y5$;:A$=INPUT$(0x12):RETURN
840 END
850 [98] [D2]0x11=[DC](U0(0x11)):X=[D2]0x11(0x11)
860 IF X>96 AND X<123 THEN X=X-32
870 I$=CHR$(X)
880 :REM \t\tReal Time Function for MBASIC
890 DIM U0(20):U0(17)=54:U0(18)=511:U0(19)=30680:U0(20)=201
900 [98] [D2]0x11=[DC](U0(0x11))::REM \t\tClear Buffer
910 IF [D2]0x11(0x11)<>0x11 THEN 910
920 RETURN
