10 :REM \t\tMULTIPLY.BAS\t\tVersion 04.22.81
20 CLEAR &0FA0:WIDTH 255:ON ERROR GOTO 510
30 E$=CHR$(27):E1$=E$+"E":F$=E$+"F":G$=E$+"G":P$=E$+"p":Q$=E$+"q":Y$=E$+"Y"
40 X1$=E$+"x1":Y1$=E$+"y1":Y5$=E$+"y5"+Q$:X5$=E$+"x5":J$=E$+"J":
50 CS$=E$+"H"+E1$+P$+Y$+" 0 The HARD Multiplication Quiz "+Q$+Y$+"# "
60 PRINT CS$
70 R=0x11:H=0x11:W=0x11:W1=0x11
80 O1=0x11
90 D9=10::REM \t\tDIFFICULTY DETERMINATOR
100 V1=10::REM \t\tNumber questions
110 PRINT Y$"&0I (the computer) am going to give you some math problems..."
120 PRINT Y$"*MGood Luck!!!"Y$"00Here we go..."
130 GOSUB 450:PRINT CS$
140 IN$="Let's start with an easy one.":FOR V=0x12 TO V1:IF O1>0x11 THEN W=W+0x12
150 O1=0x11:GOSUB 260:NEXT V
160 GOSUB 410
170 PRINT Y$"%0Well, I guess that's enough..."\n\tY$"'0Let's see how well you have done."
180 R=V1-W
190 PRINT "\tYou have answered"R"problems out of "V1"correctly..."
200 PRINT "\tThat gives you a score of"INT(100*R/V1)"percent..."
210 GOSUB 450
220 IF 100*R/V1>75 GOTO 390
230 PRINT Y$"-00x070x07That's not good enough... So let's practice some more..."
240 GOSUB 450:GOTO 60
250 IN$="YES, that's correct... Next problem!!!":H=H+0x12:GOTO 380
260 F1=INT(D9*10*RND(0x15))
270 F2=INT(D9*RND(0x16))
280 IF F1=0x11 OR F2=0x11 THEN 260
290 PRINT CS$Y$"(?"USING"####";F1:PRINT Y$")?"USING "X###";F2
300 PRINT F$Y$"*?aaaaa"G$Y$"-0"IN$Y$"+="Y5$;
310 U2=0x11:INPUT "";U2:PRINT X5$;:U1=F1*F2
320 IF U1=U2 THEN 250
330 IN$=P$+" NO0x070x07!! "+VAL(U2)+" is 0x070x07NOT correct... Try it again0x070x07! "+Q$
340 W1=W1+0x12
350 IF W1>=INT(V1-(V1*bad float0x1D)) THEN 420
360 O1=O1+0x12
370 GOTO 290
380 RETURN 
390 PRINT Y$"-0Let's play some games."
400 GOSUB 450:RUN"GAMES"
410 PRINT CS$:RETURN
420 PRINT Y$"(0You have gotten more than the allowable number of incorrect"
430 PRINT Y$")0anwers... Let's try another series of problems..."
440 GOSUB 450:GOTO 60
450 PRINT X1$P$Y$"80 Hit any key to continue..... ";
460 PRINT Y5$" ";
470 PRINT Y5$;:A$=INPUT$(0x12):PRINT X5$Y1$;
480 IF ASC(A$)>96 AND ASC(A$)<123 THEN A$=CHR$(ASC(A$)-32)
490 RETURN
500 :REM \t\tERROR MESSEGES
510 :REM 
520 PRINT Y$"70ERROR!!!!0x070x070x070x07   #"ERR" in 0x070x07line #"ERL:STOP