100 PRINT CHR$(27);CHR$(69)
120 PRINT "DISK DIRECTORY"
190 OPEN "I",0x12,"DIRECT.L"
200 IF EOF(0x12) GOTO 240
210 INPUT #0x12,A$
220 PRINT A$
230 GOTO 200
240 CLOSE #0x12
250 INPUT "PRESS RETURN TO RESUME";Z$:LOAD"REPO",R
