10 :REMARK \t\tRATIO.BAS\t\tVersion 04.23.81
20 CLEAR 4000:E$=CHR$(27):P$=E$+"p":Q$=E$+"q":Y$=E$+"Y"
30 X1$=E$+"x1":Y1$=E$+"y1":Y5$=E$+"y5"+Q$:X5$=E$+"x5":J$=E$+"J":
40 CS$=E$+"H"+E$+"E"+P$+Y$+" 9 Ratio Quiz "+Q$+Y$+"# "
50 R=0:W=0:V1=10
60 FOR H=1 TO V1:PRINT CS$:READ A1$
70 J=INT(10*RND(2))
80 K=INT(100*RND(3))
90 L=INT(20*RND(4))
100 IF J=0 GOTO 70
110 IF INT(L/J)<>(L/J) GOTO 70
120 IF J=1 GOTO 70
130 IF (L/J)=1 GOTO 70
140 IF L=0 GOTO 70
150 IF K=0 GOTO 70
160 PRINT Y$"%0If "J" "A1$" cost "K" dollars, how much will "L
170 PRINT Y$"-0"I1$Y$"/("I2$Y$"0("I3$Y$"'0"A1$;
180 INPUT " COST ";G
190 IF G=(L/J)*K THEN GOTO 330:REM CORRECT ANSWER
200 GOTO 340
210 NEXT H
220 PRINT "\tYOU ANSWERED"R"PROBLEMS CORRECTLY OUT OF A TOTAL OF"
230 PRINT "\tTEN.  THAT GIVES YOU A SCORE OF"100*(R/V1)"PERCENT."
240 IF 100*(R/V1)>70 GOTO 290
250 PRINT 
260 PRINT "\tLET'S DO SOME MORE WORK ON OUR MATH... AND PLEASE BE"
270 PRINT "\tSURE TO HAVE YOUR MOM OR DAD SHOW YOU HOW TO WORK THIS"
280 PRINT "\tKIND OF PROBLEM, OK?":RUN"MENU"
290 PRINT CS$Y$"#(LET'S PLAY SOME GAMES !!!":RUN"GAMES"
300 DATA "BOWLING BALLS","RUBBER BANDS","BASEBALLS","WAGONS","BOX KITES"
310 DATA "RUBBER DUCKIES","CHOCOLATE MICE","HOCKEY PUCKS","MONKIES"
320 DATA "CANTALOPES"
330 R=R+1:I1$="That is correct.":I2$="":I3$="":GOTO 210
340 W=W+1:I1$=P$+" \a\aThat is NOT \a\acorrect. "+Q$
350 I2$="IF "+STR$(J)+" "+A1$+" COST "+STR$(K)+" DOLLARS, THEN "\n\t+STR$(L)+" "+A1$
360 I3$="WILL COST "+STR$((L/J)*K)+" DOLLARS.":GOTO 210
370 PRINT X1$P$Y$"80 Hit any key to continue..... ";
380 PRINT Y5$;:A$=INPUT$(1):PRINT X5$Y1$;:RETURN
