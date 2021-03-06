1 REM DUNGEON OF DOOM by Fred Polgardy and Eric Phillips. Started 12/28/1987, final revisions made 1/7/1988
3 DIM S$(20),R$(8),W$(11),A$(10),C$(2),R(7,49),M(7,49),M$(100),MT$(9),T$(180),H$(91),S(5),P(5),CS$(30),TP(2,10)
4 DIM F$(16)
5 OPEN #1,4,0,"K":TRAP 1000
6 S$(1)=" ":S$(20)=" ":S$(2)=S$
9 FOR I=32768 TO 32775:POKE I,0:NEXT I
10 GRAPHICS 0:POKE 709,8:POKE 710,0:POKE 752,1:POKE 756,128
11 DATA 126,126,126,0,231,231,231,0
12 RESTORE 11:FOR I=33280 TO 33287:READ A:POKE I,A:NEXT I
15 ? "                                    ":? "                                    "
16 ? "                                    ":? "                                    "
17 ? "                                    ":? "                                    "
18 ? "                                    ":? :? S$;"  ":? S$(1,19);"    ":? S$(1,19);" ":? S$(1,14);"       "
19 ? S$(1,13);"       ":? S$(1,13);"       ":? S$(1,14);"      ":? :? S$(1,7);"                    "
20 ? S$(1,7);"                    ":? S$(1,7);"                    ":? S$(1,7);"                    "
21 ? S$(1,7);"                    ":? S$(1,7);"                    ":? S$(1,7);"                    ":GOSUB 830
22 DUR=174:SOUND 0,81,10,8:FOR I=1 TO DUR:NEXT I
23 DATA 121,50,53,50,53,121,50,53,50,45,128,53,57,53,57,128,53,53,81,81,121,60,64,60,64,121,60,64,60,53
24 RESTORE 23:FOR I=1 TO 6:READ BS,M:SOUND 0,BS,10,8:SOUND 1,M,10,8:FOR T=1 TO DUR:NEXT T:SOUND 0,162,10,8
25 FOR T=1 TO DUR:NEXT T:SOUND 0,BS,10,8:FOR T=1 TO DUR*2/3:NEXT T:READ M:SOUND 1,M,10,8:FOR T=1 TO DUR/3:NEXT T
26 READ M:SOUND 0,162,10,8:SOUND 1,M,10,8:FOR T=1 TO DUR*2/3:NEXT T:READ M:SOUND 1,M,10,8
27 FOR T=1 TO DUR/3:NEXT T:NEXT I:GOSUB 28:GOTO 39
28 DUR=DUR*0.8
29 DATA 64,128,68,136,72,144,81,162,81,162,0,0,81,162,85,172,81,162,72,182,68,193,64,217
30 RESTORE 29:FOR I=1 TO 12:READ M,BS:SOUND 0,BS,10,8:SOUND 1,M,10,8:FOR T=1 TO DUR/3:NEXT T:NEXT I
31 SOUND 0,243,10,8:SOUND 1,60,10,8:FOR T=1 TO DUR:NEXT T:SOUND 0,162,10,8:FOR T=1 TO DUR:NEXT T
32 SOUND 0,243,10,8:FOR T=1 TO DUR*2/3:NEXT T:SOUND 1,64,10,8:FOR T=1 TO DUR/3:NEXT T:SOUND 0,162,10,8:SOUND 1,60,10,8
33 FOR T=1 TO DUR*2/3:NEXT T:SOUND 1,64,10,8:FOR T=1 TO DUR/3:NEXT T:SOUND 0,121,10,8:SOUND 1,60,10,8
34 FOR T=1 TO DUR:NEXT T:SOUND 0,162,10,8:FOR T=1 TO DUR:NEXT T:SOUND 0,243,10,8:FOR T=1 TO DUR:NEXT T
35 SOUND 1,0,0,0:POKE 53768,80:POKE 53761,160:POKE 53762,53:POKE 53760,107:POKE 53763,168
36 FOR T=1 TO DUR:NEXT T:POKE 53763,160:SOUND 0,0,0,0:SOUND 1,0,0,0:RETURN 
39 GRAPHICS 0:POKE 710,0:POKE 201,7
40 ? "} Now, brave adventurer:  Prepare to   choose thy race.":? 
41 ? "  1> Human":? "  2> Dwarf":? "  3> Elf":? "  4> Halfling":? 
42 ? "Which one";:INPUT R:IF R<1 OR R>4 THEN ? "�":GOTO 42
43 RESTORE 44:FOR I=1 TO R:READ R$:NEXT I:GOSUB 800:GOTO 845
44 DATA Human,Dwarf,Elf,Halfling
45 ? :? " Press any key to arm thyself.";:GET #1,C:? "}";:P(1)=10:P(2)=20:P(3)=30
46 G=50+INT(RND(0)*11):? " Now, ";R$;", you must purchase a":? "weapon.":? :GOSUB 47:GOTO 48
47 GOSUB 805:? "  1> Dagger  ";P(1):? "  2> Short sword  ";P(2):? "  3> Broadsword  ";P(3):? :RETURN 
48 ? "Which one";:INPUT W:IF W<1 OR W>3 THEN ? "�":GOTO 48
49 G=G-W*10:RESTORE 50:FOR I=1 TO W:READ W$:NEXT I
50 DATA Dagger,Short sword,Broadsword
51 ? :? " In the DUNGEON of DOOM, armour is a  useful commodity...":? :GOSUB 52:GOTO 53
52 GOSUB 805:? "  1> Leather  ";P(1):? "  2> Wooden  ";P(2):? "  3> Chain mail  ";P(3):? :RETURN 
53 ? "Which one";:INPUT A:IF A<1 OR A>3 THEN ? "�":GOTO 53
54 G=G-A*10:IF G<0 THEN G=G+A*10:GOSUB 815:GOTO 53
55 RESTORE 56:FOR I=1 TO A:READ A$:NEXT I
56 DATA Leather,Wooden,Chain mail
57 ? :GOSUB 805:? "Flares cost one gold piece each. How  many do you wish to purchase";
58 INPUT F:IF F<0 THEN ? "�":? :GOTO 58
59 IF F>G THEN GOSUB 815:GOTO 58
60 G=G-F
70 ? "}The virtue of patience shall stand    thee in good stead at this point:"
71 ? "I must needs prepare the dungeon.":POKE 752,1:? 
72 FOR I=1 TO 7:? "Constructing floor ";I;:FOR J=1 TO 49:RV=0:IF RND(0)>0.3 THEN RV=INT(RND(0)*10)+1
73 IF RV>8 THEN RV=(INT(RND(0)*10)+1)*100
74 R(I,J)=RV:M(I,J)=0:NEXT J:? "�Floor ";I;" completed.":SOUND 0,50,10,8:GOSUB 811:SOUND 0,0,0,0:NEXT I
75 FOR I=1 TO 10
76 RN=INT(RND(0)*7)+1:RD=INT(RND(0)*49)+1:IF R(RN,RD)>99 THEN R(RN,RD)=R(RN,RD)+I+19:GOTO 78
77 R(RN,RD)=I+19
78 TP(1,I)=RN:TP(2,I)=RD:NEXT I:FOR I=1 TO 5:S(I)=0:NEXT I
79 FOR I=1 TO 6
80 RN=INT(RND(0)*49)+1:IF R(I,RN)>19 OR R(I+1,RN)>19 OR R(I,RN)=11 THEN 80
81 R(I,RN)=10:R(I+1,RN)=11:NEXT I
82 RN=INT(RND(0)*49)+1:IF R(7,RN)>9 THEN 82
83 R(7,RN)=12
84 ? :? "THE DUNGEON AWAITS YOU...":DUR=153:GOSUB 28
85 P=1:P2=25
100 ? "}";:OPEN #2,12,0,"E":POKE 710,0
102 M(P,P2)=1:AR=0:? :? :RC=R(P,P2):IF RC>99 THEN 500
104 IF RC>19 THEN TP=RC-19:GOSUB 545:GOTO 840
105 ON RC+1 GOSUB 400,403,405,410,415,420,425,430,435,0,440,445,450
110 GOSUB 820:? :? "-->";:INPUT #2;C$:IF LEN(C$)=1 THEN C$(2)=" "
111 CN=0:FOR I=1 TO 15:IF C$=CS$(I*2-1,I*2) THEN CN=I:I=15
112 NEXT I:IF CN=0 THEN ? :? "� I don't understand that. For a list  of commands, type � (HELP).":? :GOTO 110
113 ON CN GOTO 150,160,170,190,200,205,210,215,220,225,230,240,250,260,270
150 IF RC<>1 THEN ? " There is no mirror here.":GOTO 110
151 IF INT(RND(0)*50)+1<=IQ THEN 300
152 ON INT(RND(0)*10)+1 GOTO 153,154,155,156,157,158,158,158,158,158
153 ? " The mirror is cloudy and yields no   vision.":GOTO 110
154 ? " You see yourself dead and lying in a black coffin.":GOTO 110
155 ? " You see a dragon beckoning to you.":GOTO 110
156 ? " You see the three heads of a chimaeragrinning at you.":GOTO 110
157 ? " You see the exit on the 7th floor,   big and friendly-looking.":GOTO 110
158 TP=INT(RND(0)*10)+1:GOSUB 546:? " You see the ";H$;" at ";INT(RND(0)*7)+1;",";INT(RND(0)*7)+1;",";
159 ? INT(RND(0)*7)+1;"!":GOTO 110
160 IF RC<>3 THEN ? " There is no chest here.":GOTO 110
161 R(P,P2)=0:ON INT(RND(0)*5)+1 GOTO 162,166,167,167,167
162 ? " The perverse thing explodes as you   open it, ";:A=A-1:IF A=0 THEN ? "destroying your armour!":A$="no"
163 IF A>0 THEN ? "damaging your armour!"
164 IF A<0 THEN ? "wounding you!":HP=HP-INT(RND(0)*5)-3:A=0:IF HP<1 THEN 600
165 GOTO 840
166 ? " It containeth naught.":GOTO 840
167 GF=10+INT(RND(0)*21):? " You find ";GF;" gold pieces!":G=G+GF:GOTO 840
170 IF F<1 THEN ? " Thou hast no flares.":GOTO 110
171 F=F-1:P3=P2-8:IF X=1 OR X=7 OR Y=1 OR Y=7 THEN 175
172 FOR I=1 TO 3:FOR J=P3 TO P3+2:VF=R(P,J):IF VF>19 THEN VF=13:IF R(P,J)>99 THEN VF=14
173 IF J=P2 THEN VF=15
174 ? F$(VF+1,VF+1);:M(P,J)=1:NEXT J:? :P3=P3+7:NEXT I:GOTO 110
175 IF (X=1 OR X=7) AND (Y=1 OR Y=7) THEN 183
176 IF X=1 OR X=7 THEN 180
177 P3=P2-7-(Y=7):FOR I=1 TO 3:FOR J=P3 TO P3+1:VF=R(P,J):IF VF>19 THEN VF=13:IF R(P,J)>99 THEN VF=14
178 IF P2=J THEN VF=15
179 ? F$(VF+1,VF+1);:M(P,J)=1:NEXT J:? :P3=P3+7:NEXT I:GOTO 110
180 P3=P2-1-7*(X=7):FOR I=1 TO 2:FOR J=P3 TO P3+2:VF=R(P,J):IF VF>19 THEN VF=13:IF R(P,J)>99 THEN VF=14
181 IF J=P2 THEN VF=15
182 ? F$(VF+1,VF+1);:M(P,J)=1:NEXT J:? :P3=P3+7:NEXT I:GOTO 110
183 P3=P2:IF X=7 THEN P3=P3-7
184 IF Y=7 THEN P3=P3-1
185 FOR I=1 TO 2:FOR J=P3 TO P3+1:VF=R(P,J):IF VF>19 THEN VF=13:IF R(P,J)>99 THEN VF=14
186 IF J=P2 THEN VF=15
187 ? F$(VF+1,VF+1);:M(P,J)=1:NEXT J:? :P3=P3+7:NEXT I:GOTO 110
190 IF RC<>5 THEN ? " There is no potion here, I fear.":? "(Fine rhyme, thinkest thou not?)":GOTO 110
192 R(P,P2)=0:VP=INT(RND(0)*5)+1:GOTO 474
200 IF RC<>10 THEN ? :? " There are no stairs leading up here, foolish ";R$;".":GOTO 110
201 P=P+1:POP :GOTO 102
205 IF RC<>11 THEN ? :? " There is no downward staircase here, so how do you propose to go down?":GOTO 110
206 P=P-1:GOTO 102
210 IF RC<>12 THEN ? :? " Oh, yes. Just wouldn't you like to   leave now! Unfortunately, there is no exit here!"
211 IF RC<>12 THEN 110
212 GOTO 700
215 IF X>1 THEN P2=P2-7:GOTO 102
216 ? " A wall interposes itself.":GOTO 110
220 IF X<7 THEN P2=P2+7:GOTO 102
221 GOTO 216
225 IF Y<7 THEN P2=P2+1:GOTO 102
226 GOTO 216
230 IF Y>1 THEN P2=P2-1:GOTO 102
231 GOTO 216
240 FOR I=1 TO 49:IF INT((I+6)/7)=(I+6)/7 THEN ? :? "            ";
241 MV=R(P,I):IF MV>19 THEN MV=13:IF R(P,I)>99 THEN MV=14
242 IF I=P2 THEN MV=15
243 IF M(P,I)=0 THEN ? "? ";:GOTO 245
244 ? F$(MV+1,MV+1);" ";
245 NEXT I:GOTO 102
250 ? :? "--------------------------------------";:? "GOLD - ";G;"       TREASURES - ";TF:? "FLARES - ";F;
252 ? "       PROTECTIONS - ";S(1):? "FIREBALLS - ";S(2);"      LIGHTNINGS - ";S(3)
254 ? "WEAKENINGS - ";S(4);"       TELEPORTS - ";S(5):? "You have ";A$;" armour and your":? "weapon is a ";W$;"."
255 ? "--------------------------------------":GOTO 102
260 ? "} This screen of information should aidthee in thy quest.":? :? "COMMAND SUMMARY:"
262 ? "L=Look at a mirror O=Open a chest":? "F=use a Flare      DR=DRink a potion"
264 ? "R=Read a scroll    ST=STatus report":? "H=Help             M=Map":? "X=eXit             U=Up"
266 ? "D=Down             N=North":? "S=South            E=East":? "W=West"
267 ? :? "MAP MEANINGS:":? "0=Empty    m=Mirror   s=Scroll":? "c=Chest    f=Flares   p=Potion"
268 ? "v=Vendor   t=Thief    w=Warp":? "U=Up       D=Down     X=eXit":? "T=Treasure M=Monster  *=You"
269 ? :? " Press thou any key to continue.":GET #1,C:? "}";:GOTO 102
270 IF RC<>2 THEN ? "Sorry. There is nothing to read here.":GOTO 110
271 VP=INT(RND(0)*5)+1:? " The scroll contains the ";:ON VP GOSUB 273,274,275,276,277:? "spell."
272 R(P,P2)=0:GOTO 472
273 ? "protection":RETURN 
274 ? "fireball":RETURN 
275 ? "lightning":RETURN 
276 ? "weaken":RETURN 
277 ? "teleport":RETURN 
300 TP=INT(RND(0)*10)+1:IF TP(1,TP)=0 AND TS<10 THEN 300
301 IF TP(1,TP)=0 THEN 152
305 GOSUB 822:H=TP:GOSUB 546:? " You see the ";H$;" at ";TP(1,H);",";X2;",";Y2;"!":GOTO 110
400 ? " This room is empty.":RETURN 
403 ? " There is a magic mirror mounted on   the wall here.":RETURN 
405 ? " There is a spell scroll here.":RETURN 
410 ? " There is a chest here.":RETURN 
415 ? " You pick up some flares here.":F=F+INT(RND(0)*5)+1:R(P,P2)=0:RETURN 
420 ? " There is a magic potion here.":RETURN 
425 ? " There is a vendor here. Do you wish  to purchase something?":INPUT C$:IF C$(1,1)="N" THEN 110
426 ? " He is selling:":? "  1> Weapons":? "  2> Armour":? "  3> Scrolls":? "  4> Potions":? 
427 ? " Which one";:INPUT BY:IF BY<1 OR BY>4 THEN ? "�":GOTO 427
428 GOTO 460
430 RN=INT(RND(0)*50)+1:IF RN>G THEN RN=G
431 ? " A thief sneaks from the shadows and  removes ";RN;" gold pieces from your":? "possession.":G=G-RN
432 GOTO 840
435 ? " This room contains a warp. Before yourealize what is going on, you appear  elsewhere..."
436 P=INT(RND(0)*7)+1:GOTO 586
440 ? " There are stairs up here.":RETURN 
445 ? " There are stairs down here.":RETURN 
450 ? "You see the exit to the DUNGEON of    DOOM here.":RETURN 
460 ON BY GOSUB 482,484,486,488:? :? " Which one";:INPUT VP:IF VP<1 OR VP>LM THEN ? "�":GOTO 460
461 IF BY<>4 OR VP<>2 THEN 464
462 ? "  1> Strength":? "  2> Dexterity":? "  3> Intelligence":? "  4> Maximum hit point score"
463 ? :? " Which";:INPUT AT:IF AT<1 OR AT>4 THEN ? "�":GOTO 462
464 G=G-P(VP):IF G<0 THEN GOSUB 815:G=G+P(VP):GOTO 102
466 ON BY GOTO 468,470,472,474
468 IF VP>W THEN W=VP:RESTORE 50:FOR I=1 TO W:READ W$:NEXT I
469 GOTO 102
470 IF VP>A THEN A=VP:RESTORE 56:FOR I=1 TO A:READ A$:NEXT I
471 GOTO 102
472 S(VP)=S(VP)+1:GOTO 102
474 ? "You drink the potion...":IF VP=1 THEN HP=HP+5+INT(RND(0)*10)+1:IF HP>MHP THEN HP=MHP
475 GOSUB 810:IF VP=1 THEN ? "Healing results.":GOTO 102
476 PD=INT(RND(0)*8)+1:PD2=INT(RND(0)*6)+1:GOSUB 860:? " The potion ";:ON PD GOSUB 490,491,492,493,494,495,496,497
477 IF ST>18 THEN ST=18
478 IF DX>18 THEN DX=18
479 IF IQ>18 THEN IQ=18
480 IF HP>40 THEN HP=40
481 GOTO 102
482 GOSUB 483:GOSUB 47:RETURN 
483 LM=3:P(1)=50:P(2)=100:P(3)=150:RETURN 
484 GOSUB 483:GOSUB 52:RETURN 
486 P(1)=50:P(2)=30:P(3)=50:P(4)=75:P(5)=80:LM=5:? "  1> Protection 50":? "  2> Fireball 30"
487 ? "  3> Lightning 50":? "  4> Weaken 75":? "  5> Teleport 80":RETURN 
488 ? "  1> Healing potion 50":P(1)=50:? "  2> Attribute enhancer 100":P(2)=100:LM=2:RETURN 
490 ? "increases your strength.":ST=ST+PD2:RETURN 
491 ? "decreases your strength.":ST=ST-PD2:RETURN 
492 ? "increases your dexterity.":DX=DX+PD2:RETURN 
493 ? "decreases your dexterity.":DX=DX-PD2:RETURN 
494 ? "makes you smarter.":IQ=IQ+PD2:RETURN 
495 ? "makes you dumber.":IQ=IQ-PD2:RETURN 
496 ? "increases your maximum":? "hit point score.":MHP=MHP+PD2+1:HP=HP+PD2+1:RETURN 
497 ? "decreases your maximum":? "hit point score.":MHP=MHP-PD2-1:HP=HP-PD2-1
498 IF HP<1 THEN POP :GOTO 600
499 RETURN 
500 MH=INT(RC/100)*10-8:MT$=M$(MH,VAL(M$(MH-1,MH-1))+MH-1):? "You are facing an angry ";MT$;"!"
501 MV=INT(RC/100)*3+INT(RND(0)*4)
502 GOSUB 820:? :? "Will you �ight, �un, or �pell";:INPUT C$:IF C$(1,1)="R" THEN 530
503 IF C$(1,1)="S" THEN 560
505 AS=20+5*(11-INT(RC/100))+DX+3*W
506 IF INT(RND(0)*100)+1>AS THEN ? " The ";MT$;" evades your blow!":GOTO 510
507 ? " You hit the ";MT$;"!":MD=W+INT(ST/3)+INT(RND(0)*5)-2:IF MD<1 THEN MD=1
508 MV=MV-MD:IF MV<1 THEN 540
509 IF RND(0)<0.05 AND W>0 THEN ? " Your ";W$;" breaks with the":? "impact!":W=0:W$="~~broken"
510 GOSUB 810:? :? " The ";MT$;" attacks!"
511 GOSUB 810:AS=20+5*(11-INT(RC/100))+DX*2
512 IF INT(RND(0)*100)+1>AS THEN 520
514 ? :? " You deftly dodge the blow!":GOTO 524
520 ? :? " The ";MT$;" hit you!"
522 DD=INT(RND(0)*INT(RC/100))+3-A:IF DD<0 THEN DD=0
523 HP=HP-DD:IF HP<1 THEN 600
524 ON DM+1 GOTO 502,542
530 IF AR=1 THEN ? " You are quite fatigued after your    previous efforts.":GOTO 502
531 ? :? " You turn and flee, the vile ";MT$:? "following close behind.":GOSUB 810
532 ? :IF RND(0)<0.4 THEN ? " Suddenly, you realize that the":? MT$;" is no longer following you.":GOTO 586
534 ? " Although you run your hardest, your  efforts to escape are made in vain.":AR=1:GOTO 500
540 ? :? " The foul ";MT$;" expires.":DM=1
541 IF RND(0)>0.7 THEN ? " As he dies, though, he launches one  final desperate attack.":DM=1:GOTO 511
542 DM=0:A=A-AE:AE=0
543 TP=((RC-19)/100-INT(RC/100))*100:IF TP<1 THEN 550
544 GOSUB 545:GOTO 840
545 TP(1,TP)=0:GOSUB 546:? " You find the ";H$;"!":TF=TF+1:R(P,P2)=0:RETURN 
546 TP=TP*18-15:H$=T$(TP,VAL(T$(TP-2,TP-1))+TP-1):RETURN 
550 GF=RC/20+INT(RND(0)*21):G=G+GF:? " You found ";GF;" gold pieces.":GOTO 840
560 IF IQ<12 THEN ? :? "You have insufficient intelligence.":GOTO 502
561 GOSUB 562:GOTO 564
562 ? :? "  1> Protection ";S(1):? "  2> Fireball ";S(2):? "  3> Lightning bolt ";S(3)
563 ? "  4> Weaken ";S(4):? "  5> Teleport ";S(5):? :RETURN 
564 ? "Which one";:INPUT S:IF S(S)=0 THEN ? :? " You know not that spell.":GOTO 502
566 S(S)=S(S)-1:ON S GOTO 567,570,575,580,585
567 ? :IF A>0 THEN ? " Your armour glows briefly in responseto your spell.":GOTO 569
568 ? " Your clothes glow briefly, becoming, temporarily, armour."
569 A=A+3:AE=AE+3:GOTO 510
570 ? :? " A glowing ball of fire converges withthe ";MT$;".":MV=MV-INT(RND(0)*5)+1-INT(IQ/3)
571 IF MV<1 THEN ? :? " The ";MT$;" evaporates in a":? "magnificent pyrotechnic display.":GOTO 542
572 GOTO 510
575 ? :? " The ";MT$;" is thunderstruck!":MV=MV-INT(RND(0)*10)+1-INT(IQ/2)
576 IF MV<1 THEN ? :? " The massive electrical charge proves lethal to the ";MT$;".":GOTO 542
577 GOTO 510
580 ? :? " A green mist envelops the ";MT$;",":? "depriving him of half his vitality.":MV=INT(MV/2)
581 IF MV<1 THEN ? " Seeing that the ";MT$;" had":? "barely any energy to begin with, its"
582 IF MV<1 THEN ? "death is no surprise.":GOTO 542
583 GOTO 510
585 ? :? " Thy surroundings vibrate momentarily,as you are magically transported      elsewhere..."
586 RN=INT(RND(0)*49)+1:IF RN=P2 THEN 586
587 P2=RN:GOTO 102
600 FOR I=8 TO 0 STEP -1:SOUND 0,200-I*10,12,8:POKE 709,I:FOR J=1 TO 10:NEXT J:NEXT I
602 ? "}";:POSITION 13,10:? "YOU HAVE DIED.":FOR I=1 TO 10:POKE 709,I:FOR J=1 TO 10:NEXT J:NEXT I
604 SOUND 0,0,0,0:POSITION 2,18:? " Art thou brave enough for another    attempt";:INPUT H$:IF H$="N" THEN 610
605 ? :? " Well, if you insist, but verily thou shalt regret it!":GOSUB 810
606 TF=0:CLOSE #2:TRAP 1000:GOTO 40
610 ? " Thou art a cowardly knave, I fear.   Mayhap one more worthy of this quest  shall happen along one day..."
612 TRAP 40000:END 
699 END 
700 IF TF<10 THEN 710
701 FOR I=0 TO 8:SOUND 0,(9-I)*10,10,8:POKE 710,I:FOR J=1 TO 10:NEXT J:NEXT I
702 ? "}";:POSITION 10,10:? "ALL HAIL THE VICTOR!"
703 FOR I=8 TO 0 STEP -1:SOUND 0,(9-I)*10,10,8:POKE 710,I:FOR J=1 TO 10:NEXT J:NEXT I
704 GOTO 604
710 ? "}";:? " What? And hast thou abandoned thy    quest before it was accomplished?"
712 ? " The DUNGEON of DOOM still holds ";10-TF:? "treasures that thine eyes shall never behold! Verily thy ";
714 ? "triumph is":? "incomplete!"
716 GOTO 604
799 END 
800 RN=INT(RND(0)*5):RD=INT(RND(0)*5):RA=INT(RND(0)*5):R2=INT(RND(0)*7):GOSUB 800+R:MHP=HP:RETURN 
801 ST=8+RN:DX=8+RD:IQ=8+RA:HP=20+R2:RETURN 
802 ST=10+RN:DX=8+RD:IQ=6+RA:HP=22+R2:RETURN 
803 ST=6+RN:DX=9+RD:IQ=10+RA:HP=16+R2:RETURN 
804 ST=6+RN:DX=10+RD:IQ=9+RA:HP=18+R2:RETURN 
805 ? "You have ";G;" gold pieces.":RETURN 
810 FOR T=1 TO 60:NEXT T:RETURN 
811 FOR T=1 TO 30:NEXT T:RETURN 
815 ? :? "�Don't try to cheat me, you stupid":? R$;". It won't work!":? :RETURN 
820 ? :? "ST-";ST;" DX-";DX;" IQ-";IQ;" HP-";HP;" FL-";P;" POS. ";
821 X=INT((P2-1)/7)+1:Y=P2-(X-1)*7:? X;",";Y:RETURN 
822 H=TP(2,TP):X2=INT((H-1)/7)+1:Y2=H-(X2-1)*7:RETURN 
823 H=(X2-1)*7+Y2:RETURN 
825 REM 
830 RESTORE 831:READ M$:M$=M$(2)
831 DATA "8Skeleton 6Goblin   6Kobold   3Orc      5Troll    8Werewolf 7Banshee  9Hellhound8Chimaera 6Dragon   "
832 RESTORE 833:READ T$:T$=T$(2):READ H$:H$=H$(2):T$(91)=H$
833 DATA "11Gold Fleece     11Black Pearl     09Ruby Ring       13Diamond Clasp   16Silver Medallion"
834 DATA "15Precious Spices 08Sapphire        14Golden Circlet  13Jeweled Cross   08Silmaril        "
835 CS$="L O F DRU D X N S E W M STH R ":F$="0mscfpvtw UDXTM*"
836 FOR I=1 TO 5:S(I)=0:NEXT I
837 RETURN 
840 R(P,P2)=0:GOTO 102
845 ? "Thy characteristics are as follows:":? 
846 ? " Strength     ";ST:? " Dexterity    ";DX:? " Intelligence ";IQ:? " Hit points   ";HP
848 ? :? "You may distribute 5 points among yourstrength, dexterity, and intelligence.(NOTE: They can't break 18)"
850 LR=850:PA=5:GOSUB 858:? "strength";:INPUT PD:AT=ST+PD:GOSUB 855:ST=AT
851 LR=851:GOSUB 858:? "dexterity";:INPUT PD:AT=DX+PD:GOSUB 855:DX=AT
852 LR=852:GOSUB 858:? "intelligence";:INPUT PD:AT=IQ+PD:GOSUB 855:IQ=AT:GOTO 45
855 IF PD>PA THEN GOSUB 815:AT=AT-PD:POP :GOTO LR
856 PA=PA-PD:IF AT>18 THEN PA=PA+AT-18:AT=18
857 RETURN 
858 ? :? "You have ";PA;" points.":RETURN 
860 IF R(P,P2)<>6 THEN RETURN 
862 PD=AT*2-1:RETURN 
1000 ? "�":TRAP 1000:GOTO PEEK(187)*256+PEEK(186)
