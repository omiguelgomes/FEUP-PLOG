:- dynamic bonus/1.

getCell(X, Y, GameState, Value) :- X > -1, Y > -1, X < 10, Y < 10, getRow(Y, GameState, Row), getCellInRow(X, Row, Value).

getRow(0, [H|_], H).
getRow(Y, [_|T], Row) :- Y1 is Y-1, getRow(Y1, T, Row).

getCellInRow(0, [H|_], H).
getCellInRow(X, [_|T], Value) :- X1 is X-1, getCellInRow(X1, T, Value).

getOpponent('B', 'W').
getOpponent('W', 'B').

/*Converts x position from letter to number*/
convertX('a', 0).
convertX('b', 1).
convertX('c', 2).
convertX('d', 3).
convertX('e', 4).
convertX('f', 5).
convertX('g', 6).
convertX('h', 7).
convertX('i', 8).
convertX('j', 9).

/*Position of the bonuses*/
bonus([]).

/*fill bonus with the actual bonus list*/
instantiateBonusList(GameState) :- findBonus(GameState, 1, 1, BonusList, []), retract(bonus(List)), assert(bonus(BonusList)).

findBonus(_, 0, 0, BonusList, BonusList).
findBonus(GameState, X, Y, BonusList, Temp) :- getCell(X, Y, GameState, 'P'), !, 
                                               append(Temp, [X-Y], NewTemp),
                                               nextCell(X, Y, NewX, NewY), 
                                               findBonus(GameState, NewX, NewY, BonusList, NewTemp).

findBonus(GameState, X, Y, BonusList, Temp) :- getCell(X, Y, GameState, _), !, 
                                               nextCell(X, Y, NewX, NewY), 
                                               findBonus(GameState, NewX, NewY, BonusList, Temp).


/*get bonus score for player*/
getBonus(GameState, Player, BonusScore) :- bonus(BonusList), getBonus(GameState, Player, BonusList, BonusScore, 0).

getBonus(GameState, Player, [X-Y|T], BonusScore, Temp) :- getCell(X, Y, GameState, Player), 
                                                          NewTemp is Temp + 3,
                                                          getBonus(GameState, Player, T, BonusScore, NewTemp).

getBonus(GameState, Player, [X-Y|T], BonusScore, Temp) :- getCell(X, Y, GameState, _),     
                                                          getBonus(GameState, Player, T, BonusScore, Temp).
getBonus(_, _, [], Bonus, Bonus).

/*Used to iterate through board, left to right, top to bottom*/

/*If we reached the last cell, return 0,0*/
nextCell(8, 8, 0, 0).
/*If we reached the last cell in the row, move to next row*/
nextCell(8, Y, 1, NextY) :-  NextY is Y + 1.
nextCell(X, Y, NextX, Y) :-  NextX is X + 1.

/*Used to flip necessary pieces*/
flipListRow(Player,GameState, [], Y, GameState, GameState).

flipListRow(Player,GameState, [H|Rest], Y, NewGameState, Final):-
    placePiece(GameState, Player, H, Y, NewGameState),
    flipListRow(Player, NewGameState, Rest, Y, _, Final).

flipListColumn(Player,GameState, X, [], GameState, GameState).

flipListColumn(Player,GameState, X, [H|Rest], NewGameState, Final):-
    placePiece(GameState, Player, X, H, NewGameState),
    flipListColumn(Player, NewGameState, X, Rest, _, Final).

flipListDiagonal(Player,GameState, [], [], GameState, GameState).

flipListDiagonal(Player,GameState, [X|Rest1], [Y|Rest2], NewGameState, Final):-
    placePiece(GameState, Player, X, Y, NewGameState),
    flipListDiagonal(Player, NewGameState, Rest1, Rest2, _, Final).

 
 /*Used to check if there are flipable pieces, returns in FinalList.*/
checkRowRight(GameState, Player, 9, Y, Row, TempList, TempList).

checkRowRight(GameState, Player, X, Y, Row, TempList, FinalList):-
    NewX is X+1,
    getCellInRow(NewX, Row, Value),
    (       /* Free space, can end*/ 
            Value == ' ' -> checkRowRight(GameState, Player, 9, Y, Row, [],FinalList)
        ;    /* Wall piece, can end */
            Value == '#' -> checkRowRight(GameState, Player, 9, Y, Row, [],FinalList) 
        ;   /* Player piece, flip current list, dont add */
            Value == Player -> checkRowRight(Final, Player, 9, Y, Row, TempList, FinalList)    
        ;   /* Player piece, flip current list, dont add */
            Value == 'J' ->  checkRowLeft(Final, Player, 0, Y, Row, TempList, FinalList)    
        ;   /* otherwise (oponent piece append to fliplist) -> */
            append(TempList, [NewX], NewTempList),
            checkRowRight(GameState, Player, NewX, Y, Row, NewTempList, FinalList)
    ).

checkRowLeft(GameState, Player, 0, Y, Row, TempList, TempList).

checkRowLeft(GameState, Player, X, Y, Row, TempList, FinalList):-
    NewX is X-1,
    getCellInRow(NewX, Row, Value),
    (       /* Free space, can end*/ 
            Value == ' ' -> checkRowLeft(GameState, Player, 0, Y, Row, [],FinalList)
        ;    /* Wall piece, can end */
            Value == '#' -> checkRowLeft(GameState, Player, 0, Y, Row, [],FinalList) 
        ;   /* Player piece, flip current list, dont add */
            Value == Player ->  checkRowLeft(Final, Player, 0, Y, Row, TempList, FinalList)    
        ;   /* Player piece, flip current list, dont add */
            Value == 'J' ->  checkRowLeft(Final, Player, 0, Y, Row, TempList, FinalList)    
        ;   /* otherwise (oponent piece append to fliplist) -> */
            append(TempList, [NewX], NewTempList),
            checkRowLeft(GameState, Player, NewX, Y, Row, NewTempList, FinalList)
        ).    

checkColumnDown(GameState, Player, X, 9, TempList, TempList).

checkColumnDown(GameState, Player, X, Y, TempList, FinalList):-
    NewY is Y+1,
    getCell(X, NewY, GameState, Value),
    (       /* Free space, can end*/ 
            Value == ' ' -> checkColumnDown(GameState, Player, X, 9, [], FinalList)
        ;    /* Wall piece, can end */
            Value == '#' -> checkColumnDown(GameState, Player, X, 9, [], FinalList) 
        ;   /* Player piece, flip current list, dont add */
            Value == Player -> checkColumnDown(Final, Player, X, 9, TempList, FinalList)    
        ;   /* Player piece, flip current list, dont add */
            Value == 'J' -> checkColumnUp(Final, Player, X, 0, TempList, FinalList)    
        ;   /* otherwise (oponent piece append to fliplist) -> */
            append(TempList, [NewY], NewTempList),
            checkColumnDown(GameState, Player, X, NewY, NewTempList, FinalList)
    ).

checkColumnUp(GameState, Player, X, 0, TempList, TempList).

checkColumnUp(GameState, Player, X, Y, TempList, FinalList):-
    NewY is Y-1,
    getCell(X, NewY, GameState, Value),
    (       /* Free space, can end*/ 
            Value == ' ' -> checkColumnUp(GameState, Player, X, 0, [],FinalList)
        ;    /* Wall piece, can end */
            Value == '#' -> checkColumnUp(GameState, Player, X, 0, [],FinalList) 
        ;   /* Player piece, flip current list, dont add */
            Value == Player -> checkColumnUp(Final, Player, X, 0, TempList, FinalList)    
        ;   /* Player piece, flip current list, dont add */
            Value == 'J' -> checkColumnUp(Final, Player, X, 0, TempList, FinalList)    
        ;    /* otherwise (oponent piece append to fliplist) -> */
            append(TempList, [NewY], NewTempList),
            checkColumnUp(GameState, Player, X, NewY, NewTempList, FinalList)
    ).

checkDiagonalPos1(GameState, Player, X, 0, TempListX, TempListY, TempListX, TempListY).
checkDiagonalPos1(GameState, Player, 9, Y, TempListX, TempListY, TempListX, TempListY).

checkDiagonalPos1(GameState, Player, X, Y, TempListX, TempListY, FinalListX, FinalListY):-
    NewY is Y-1,
    NewX is X+1,
    getCell(NewX, NewY, GameState, Value),
    (       /* Free space, can end*/ 
            Value == ' ' -> checkDiagonalPos1(GameState, Player, X, 0, [], [], FinalListX, FinalListY)
        ;    /* Wall piece, can end */
            Value == '#' -> checkDiagonalPos1(GameState, Player, X, 0, [], [], FinalListX, FinalListY) 
        ;   /* Player piece, flip current list, dont add */
            Value == Player -> checkDiagonalPos1(Final, Player, X, 0, TempListX, TempListY, FinalListX, FinalListY)    
        ;   /* Player piece, flip current list, dont add */
            Value == 'J' -> checkDiagonalPos1(Final, Player, X, 0, TempListX, TempListY, FinalListX, FinalListY)    
        ;   /* otherwise (oponent piece append to fliplist) -> */
            append(TempListX, [NewX], NewTempListX),
            append(TempListY, [NewY], NewTempListY),
            checkDiagonalPos1(GameState, Player, NewX, NewY, NewTempListX, NewTempListY, FinalListX, FinalListY)
    ).

checkDiagonalPos2(GameState, Player, X, 9, TempListX, TempListY, TempListX, TempListY).
checkDiagonalPos2(GameState, Player, 0, Y, TempListX, TempListY, TempListX, TempListY).

checkDiagonalPos2(GameState, Player, X, Y, TempListX, TempListY, FinalListX, FinalListY):-
    NewY is Y+1,
    NewX is X-1,
    getCell(NewX, NewY, GameState, Value),
    (       /* Free space, can end*/ 
            Value == ' ' -> checkDiagonalPos2(GameState, Player, X, 9, [], [], FinalListX, FinalListY)
        ;    /* Wall piece, can end */
            Value == '#' -> checkDiagonalPos2(GameState, Player, X, 9, [], [], FinalListX, FinalListY) 
        ;   /* Player piece, flip current list, dont add */
            Value == Player -> checkDiagonalPos2(Final, Player, X, 9, TempListX, TempListY, FinalListX, FinalListY)    
        ;   /* Player piece, flip current list, dont add */
            Value == 'J' -> checkDiagonalPos1(Final, Player, X, 9, TempListX, TempListY, FinalListX, FinalListY)    
        ;   /* otherwise (oponent piece append to fliplist) -> */
            append(TempListX, [NewX], NewTempListX),
            append(TempListY, [NewY], NewTempListY),
            checkDiagonalPos2(GameState, Player, NewX, NewY, NewTempListX, NewTempListY, FinalListX, FinalListY)
    ).


checkDiagonalNeg1(GameState, Player, X, 0, TempListX, TempListY, TempListX, TempListY).
checkDiagonalNeg1(GameState, Player, 0, Y, TempListX, TempListY, TempListX, TempListY).

checkDiagonalNeg1(GameState, Player, X, Y, TempListX, TempListY, FinalListX, FinalListY):-
    NewY is Y-1,
    NewX is X-1,
    getCell(NewX, NewY, GameState, Value),
    (       /* Free space, can end*/ 
            Value == ' ' -> checkDiagonalNeg1(GameState, Player, X, 0, [], [], FinalListX, FinalListY)
        ;    /* Wall piece, can end */
            Value == '#' -> checkDiagonalNeg1(GameState, Player, X, 0, [], [], FinalListX, FinalListY) 
        ;   /* Player piece, flip current list, dont add */
            Value == Player -> checkDiagonalNeg1(Final, Player, X, 0, TempListX, TempListY, FinalListX, FinalListY)    
        ;   /* Player piece, flip current list, dont add */
            Value == 'J' -> checkDiagonalPos1(Final, Player, X, 0, TempListX, TempListY, FinalListX, FinalListY)    
        ;   /* otherwise (oponent piece append to fliplist) -> */
            append(TempListX, [NewX], NewTempListX),
            append(TempListY, [NewY], NewTempListY),
            checkDiagonalNeg1(GameState, Player, NewX, NewY, NewTempListX, NewTempListY, FinalListX, FinalListY)
    ).

checkDiagonalNeg2(GameState, Player, X, 9, TempListX, TempListY, TempListX, TempListY).
checkDiagonalNeg2(GameState, Player, 9, Y, TempListX, TempListY, TempListX, TempListY).

checkDiagonalNeg2(GameState, Player, X, Y, TempListX, TempListY, FinalListX, FinalListY):-
    %nl, write('swag'), nl,
    NewY is Y+1,
    NewX is X+1,
    %nl,write(NewY),write('-'), write(NewX),nl,
    %write(FinalListX), nl, write(FinalListY), nl,
    getCell(NewX, NewY, GameState, Value),
    (       /* Free space, can end*/ 
            Value == ' ' -> checkDiagonalNeg2(GameState, Player, X, 9, [], [], FinalListX, FinalListY)
        ;    /* Wall piece, can end */
            Value == '#' -> checkDiagonalNeg2(GameState, Player, X, 9, [], [], FinalListX, FinalListY) 
        ;   /* Player piece, flip current list, dont add */
            Value == Player -> checkDiagonalNeg2(Final, Player, X, 9, TempListX, TempListY, FinalListX, FinalListY)    
        ;   /* Player piece, flip current list, dont add */
            Value == 'J' -> checkDiagonalPos1(Final, Player, X, 9, TempListX, TempListY, FinalListX, FinalListY)    
        ;   /* otherwise (oponent piece append to fliplist) -> */
            append(TempListX, [NewX], NewTempListX),
            append(TempListY, [NewY], NewTempListY),
            checkDiagonalNeg2(GameState, Player, NewX, NewY, NewTempListX, NewTempListY, FinalListX, FinalListY)
    ).
