10 :REMARK \t\tWORD.BAS\t\tVersion 04.23.81
20 CLEAR 4000:ON ERROR GOTO 390
30 E$=CHR$(27):P$=E$+"p":Q$=E$+"q":Y$=E$+"Y"
40 X1$=E$+"x1":Y1$=E$+"y1":Y5$=E$+"y5"+Q$:X5$=E$+"x5":J$=E$+"J":
50 CS$=E$+"H"+E$+"E"+P$+Y$+" 0 Letter Guessing Game "+Q$+Y$+"# "
60 DIM N$(4):V=0:GOSUB 150
70 A=INT(78*RND(12))
80 FOR C=1 TO 4:N$(C)="?":NEXT C
90 FOR X=1 TO A:READ B$:NEXT X
100 PRINT "\tGuess a letter?  ";:GOSUB 360:C$=A$
110 IF C$="0" GOTO 230
120 FOR Z=1 TO 4:IF C$=MID$(B$,Z,1) GOTO 170
130 NEXT Z
140 V=V+1:PRINT "\tNo, there is no "C$" in my word, so":GOTO 100
150 PRINT CS$Y$"#)I am thinking of a 4 letter word... Can you guess it?"
160 PRINT "When you think you know it, tyoe a zero (0), OK?":RETURN
170 PRINT "\tYES... There is a ";C$;" in my word!!!"
180 V=V+1
190 N$(Z)=C$
200 N$="":FOR T=1 TO 4:N$=N$+N$(T):PRINT N$(T);:NEXT T
210 IF N$=B$ THEN 260
220 GOTO 100
230 PRINT"OK, Smarty what is your guess? ";
240 D$="":FOR I=1 TO 4:GOSUB 360:PRINT A$;:D$=D$+A$:NEXT I:PRINT
250 IF D$<>B$ THEN PRINT "\tNice try, but you are wrong\a\a\a\a!":GOTO 100
260 PRINT "\tGood work!  You guessed my word in only"V"tries!!!"
270 PRINT "\tDo you want to play again? (Y or N) <Y> ";:GOSUB 360
280 IF A$<>"N" THEN 20
290 PRINT CS$:RUN"MENU"
300 DATA GAME,FISH,HAND,MAKE,BIRD,LIST,DICE,KITE,MICE,WORK,HOPE,PLOT,TICK
310 DATA FLIP,WILD,BORE,LICK,BUGS,LIKE,WISH,DIGS,BATS,MASK,ANTS,GOES,TIME
320 DATA GUNS,DAYS,DAZE,LAZY,DISK,HUNT,TRAP,RIPS,RIPE,MUSH,FLEA,ONLY,TOPS
330 DATA DIAL,LIDS,CANS,HITS,HUTS,TIES,TIME,OVAL,GIVE,GETS,ARMY,NAVY,TAPS
340 DATA WARP,LIME,LAME,TAME,RAIN,TUNE,BOLT,TUBS,STUB,PUCK,LUCK,DUCK,MUCK
350 DATA DROP,MOPS,SPOT,STOP,DUSK,DIME,WITH,WHIP,TRIP,HIPS,ROUT,QUIT,NICK
360 PRINT Y5$;:A$=INPUT$(1):PRINT X5$;
370 IF ASC(A$)>96 AND ASC(A$)<123 THEN A$=CHR$(ASC(A$)-32)
380 RETURN
390 PRINT "ERROR!!!!\a\a\a\a   #"ERR" in \a\aline #"ERL:STOP
